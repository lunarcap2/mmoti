<%
	 Response.CharSet="euc-kr"
     Session.codepage="949"
     Response.codepage="949"
     Response.ContentType="text/html;charset=euc-kr"
%>

<!--#include virtual = "/common/common.asp"-->
<!--#include virtual="/wwwconf/function/db/DBConnection.asp"-->

<%
	Response.AddHeader "P3P", "CP='ALL CURa ADMa DEVa TAIa OUR BUS IND PHY ONL UNI PUR FIN COM NAV INT DEM CNT STA POL HEA PRE LOC OTC'"

	Dim resume_no, open_yn, open_day

	resume_no	= request("resume_no")
	open_yn		= request("open_yn")
	open_day	= request("open_day")
	
	ConnectDB DBCon, Application("DBInfo_FAIR")

	SpName="usp_�̷¼�_��������_����"

	Dim param(3)
	param(0) = makeparam("@���ξ��̵�", adVarChar, adParamInput, 20, user_id)
	param(1) = makeparam("@�̷¼���Ϲ�ȣ", adInteger, adParamInput, 4, resume_no)
	param(2) = makeparam("@��������", adInteger, adParamInput, 4, open_yn)
	param(3) = makeparam("@�����Ⱓ", adInteger, adParamInput, 4, open_day)

	rtn_value = arrGetRsSP(DBCon, SpName, param, "", "")
	
	DisconnectDB DBCon
%>