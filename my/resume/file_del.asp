<%
	Option Explicit

	Response.CacheControl = "no-cache"
	Response.AddHeader "Pragma", "no-cache"
	Response.Expires = -1
	Response.Charset = "euc-kr"
%>
<!--#include virtual = "/common/constant.asp"-->
<!--#include virtual = "/wwwconf/function/db/DBConnection.asp"-->
<%
	'Dim sourcepath : sourcepath = "D:\solution\"& site_title &"\files\resume\"
	Dim sourcepath : sourcepath = "\\218.145.70.142\files$\files\fair\resume\"
	
	Dim objFS
	set objFS = CreateObject("Scripting.FileSystemObject")

	'���� ����
	Dim file_name, resume_no, file_seq
	file_name = Request.Form("del_file_name")
	resume_no = Request.Form("del_resume_no")
	file_seq = Request.Form("del_file_seq")

	If file_name <> "" Then
		If objFs.FileExists(sourcepath & file_name) Then 
			objFs.DeleteFile sourcepath & file_name

			If resume_no <> "" And file_seq <> "" Then 
				ConnectDB DBCon, Application("DBInfo_FAIR")
				Dim strSql : strSql = ""
				strSql = strSql & " DELETE �̷¼���Ʈ������ WHERE ��Ϲ�ȣ = "& resume_no &" AND ������ȣ = "& file_seq &";"
				strSql = strSql & " UPDATE �̷¼���Ʈ������"
				strSql = strSql & " SET ������ȣ = ������ȣ - 1"
				strSql = strSql & " WHERE ��Ϲ�ȣ = " & resume_no
				strSql = strSql & " AND ������ȣ > " & file_seq

				Call execSQL(DBCon, strSql, "", "")
				DisconnectDB DBCon
			End If 

		End If
	End If
%>