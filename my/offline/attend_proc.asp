<!--#include virtual = "/common/common.asp"-->
<!--#include virtual = "/wwwconf/function/db/DBConnection.asp"-->

<%
	If g_LoginChk <> "1" Then
		Response.write "<script>alert('로그인 후 이용이 가능합니다..'); window.history.back();</script>"
		Response.End
	End If
	Dim AttendDate, strRemoteAddr, strUserAgent,Phone
	AttendDate		= request("AttendDate")
	Phone			= request("Phone")
	strRemoteAddr	= Request.ServerVariables("REMOTE_ADDR")
    strUserAgent	= Request.ServerVariables("HTTP_USER_AGENT")

	Dim rtn : rtn = "X"

	If AttendDate <> "" And Len(AttendDate) = 10 then
		ConnectDB DBCon, Application("DBInfo_FAIR")

			
			ReDim parameter(5)
			parameter(0)    = makeParam("@userid", adVarChar, adParamInput, 20, user_id)
			parameter(1)    = makeParam("@attend", adVarChar, adParamInput, 50, "Y")
			parameter(2)    = makeParam("@RemoteAddr", adVarChar, adParamInput, 3000, strRemoteAddr)
			parameter(3)    = makeParam("@UserAgent", adVarChar, adParamInput, 5000, strUserAgent)
			parameter(4)    = makeParam("@attenddate", adVarChar, adParamInput, 10, AttendDate)
			parameter(5)    = makeParam("@RTN", adChar, adParamOutput, 1, "")

			Call execSP(DBCon, "usp_오프라인_참석", parameter, "", "")
			rtn = getParamOutputValue(parameter, "@RTN")


		DisconnectDB DBCon
	End if

	'// 신청자 휴대폰 정보가 있어야 안내 문자
	If rtn = "O" then
		If (isnull(Phone) = False) Then
			Dim str_AttendDate

			If AttendDate = "2021-11-24" then
				str_AttendDate = AttendDate & " 수요일"
			ElseIf AttendDate = "2021-11-25" then
				str_AttendDate = AttendDate & " 목요일"
			End if

			'2-3) 문자 발송
			ConnectDB DBCon2, Application("DBInfo_etc")

				Dim now_time, msg, strSql4, smsid
				now_time = year(now) & Right("0"&month(now),2) & Right("0"&day(now),2) & Right("0"&hour(now),2) & Right("0"&minute(now),2) & Right("0"&second(now),2)
				
				msg = "안녕하세요 "&site_name&" 운영 사무국 입니다."& vbCrlf & vbCrlf
				msg = msg & "오프라인 박람회 사전신청 완료되었습니다."& vbCrlf & vbCrlf
				msg = msg & "■ 참석날짜 : "&str_AttendDate&""& vbCrlf
				msg = msg & "감사합니다."& vbCrlf

				Set Rs = Server.CreateObject("ADODB.RecordSet")
				strSql4 = "select max(CMP_MSG_ID) as cmid from arreo_sms where not (left(CMP_MSG_ID, 5) = 'ALARM') "
				Rs.Open strSql4, DBCon2, 0, 1
				If Not (Rs.BOF Or Rs.EOF) Then
					smsid = rs("cmid") + 1

					sql2 = "Insert Into arreo_sms (CMP_MSG_ID, CMP_USR_ID, ODR_FG, SMS_GB, USED_CD, MSG_GB, WRT_DTTM, SND_DTTM, SND_PHN_ID, RCV_PHN_ID, CALLBACK, SUBJECT, SND_MSG, EXPIRE_VAL, SMS_ST, RSLT_VAL, RSRVD_ID, RSRVD_WD)" &_
							" Values ('" & smsid & "', '00000', '2', '1', '00', 'M', '" & now_time & "', '" & now_time & "', 'daumhr', '" & Replace(Replace(Phone, " ", ""),"-","") & "', '" & Replace(Replace(site_callback_phone, " ", ""),"-","") & "', '"&site_name&"', '" & msg & "', 0, '0', 99,'','');"
					DBCon2.Execute(sql2)
				End If
				Rs.Close

			DisconnectDB DBCon2		

		End If
	End if

%>

<script>
	var rtn = "<%=rtn%>";
	if (rtn == "O") {
		alert("전역예정장병 취업박람회 사전신청이 완료되었습니다.");
	} else {
		var returnMsg;	
		switch (rtn){
			case "M" :
				returnMsg = "해당날짜 사전신청이 마감되었습니다.";
				break;
			case "A" :
				returnMsg = "이미 사전신청이 완료되었습니다.";
				break;
			case "X" :
				returnMsg = "사전신청도중 오류가 발생하였습니다.";
				break;
			default :
				returnMsg = "";
		}

		alert(returnMsg);
	}
	location.href = "/my/offline/attend.asp";
</script>