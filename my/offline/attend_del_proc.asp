<!--#include virtual = "/common/common.asp"-->
<!--#include virtual = "/wwwconf/function/db/DBConnection.asp"-->

<%
	If g_LoginChk <> "1" Then
		Response.write "<script>alert('�α��� �� �̿��� �����մϴ�..'); window.history.back();</script>"
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
		Response.write "<script>alert('�߸��� �����Դϴ�.'); window.history.back();</script>"
		Response.End
	End If

	ConnectDB DBCon, Application("DBInfo_FAIR")

		Dim rtn : rtn = "X"
		ReDim parameter(3)
		parameter(0)    = makeParam("@userid", adVarChar, adParamInput, 20, user_id)
		parameter(1)    = makeParam("@attendIDX", adInteger, adParamInput, 4, AttendIDX)
		parameter(2)    = makeParam("@attenddate", adVarChar, adParamInput, 10, AttendDate)
		parameter(3)    = makeParam("@RTN", adChar, adParamOutput, 1, "")

		Call execSP(DBCon, "usp_��������_��û���", parameter, "", "")
		rtn = getParamOutputValue(parameter, "@RTN")


	DisconnectDB DBCon

%>

<script>
	var rtn = "<%=rtn%>";
	if (rtn == "O") {
		alert("�������� �ڶ�ȸ ��û ��ҵǾ����ϴ�.");
	} else {
		var returnMsg;	
		switch (rtn){
			case "X" :
				returnMsg = "��û���� ������ �߻��Ͽ����ϴ�.";
				break;
			default :
				returnMsg = "";
		}

		alert(returnMsg);
	}
	location.href = "/my/offline/attend.asp";
</script>