<!--#include virtual = "/common/common.asp"-->
<!--#include virtual = "/wwwconf/function/db/DBConnection.asp"-->

<%
Session.CodePage  = 949			'�ѱ�
Response.CharSet  = "euc-kr"	'�ѱ�
Response.AddHeader "Pragma","no-cache"
Response.AddHeader "cache-control", "no-staff"
Response.Expires  = -1


Dim txtPhone, txtName, militaryPersonnelNumber
txtPhone				= Request("txtPhone")
txtName					= unescape(Request("txtName"))
militaryPersonnelNumber	= Request("militaryPersonnelNumber")


ConnectDB DBCon, Application("DBInfo_FAIR")
	
	Dim strSql : strSql = ""
	strSql = strSql & "SELECT COUNT(*) FROM ��������� WHERE �̸� = '" & txtName & "'"
	strSql = strSql & " AND ���� = '" & militaryPersonnelNumber & "'"
	strSql = strSql & " AND REPLACE(����ó,'-','') = '" & txtPhone & "'"
	
	Response.write arrGetRsSql(DBCon, strSql, "", "")(0,0)	

DisconnectDB DBCon
%>