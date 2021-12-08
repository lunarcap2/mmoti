<!--#include virtual = "/common/common.asp"-->
<!--#include virtual = "/wwwconf/function/db/DBConnection.asp"-->

<%
	If g_LoginChk <> "1" Then
		Response.write "<script>alert('로그인 후 이용이 가능합니다..'); window.history.back();</script>"
		Response.End
	End If

	Dim AttendIDX, AttendDate
	AttendIDX			= request("AttendIDX")
	AttendDate			= request("AttendDate_Del")
'Response.write user_id
'Response.write AttendIDX
'Response.write AttendDate
'Response.end

	If AttendIDX = "" Then
		Response.write "<script>alert('잘못된 접근입니다.'); window.history.back();</script>"
		Response.End
	End If

	ConnectDB DBCon, Application("DBInfo_FAIR")

		Dim rtn : rtn = "X"
		ReDim parameter(3)
		parameter(0)    = makeParam("@userid", adVarChar, adParamInput, 20, user_id)
		parameter(1)    = makeParam("@attendIDX", adInteger, adParamInput, 4, AttendIDX)
		parameter(2)    = makeParam("@attenddate", adVarChar, adParamInput, 10, AttendDate)
		parameter(3)    = makeParam("@RTN", adChar, adParamOutput, 1, "")

		Call execSP(DBCon, "usp_오프라인_신청취소", parameter, "", "")
		rtn = getParamOutputValue(parameter, "@RTN")


	DisconnectDB DBCon

%>

<script>
	var rtn = "<%=rtn%>";
	if (rtn == "O") {
		alert("오프라인 박람회 신청 취소되었습니다.");
	} else {
		var returnMsg;	
		switch (rtn){
			case "X" :
				returnMsg = "신청도중 오류가 발생하였습니다.";
				break;
			default :
				returnMsg = "";
		}

		alert(returnMsg);
	}
	location.href = "/my/offline/attend.asp";
</script>