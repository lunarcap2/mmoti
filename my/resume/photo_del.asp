<!--#include virtual = "/common/common.asp"-->
<!--#include virtual="/wwwconf/function/db/DBConnection.asp"-->
<%
	Response.CacheControl = "no-cache"
	Response.AddHeader "Pragma", "no-cache"
	Response.Expires = -1
	Response.Charset = "euc-kr"
	
	Dim hid_myPhoto, photo_reg_rid, photo_reg_stp, photo_reg_rtype, photo_reg_cflag, photo_reg_gubun
	hid_myPhoto		= Request("hid_myPhoto")	' ���� ��� ���ϸ�
	photo_reg_rid	= Request("rid")
	photo_reg_stp	= Request("step")
	photo_reg_rtype	= Request("rtype")
	photo_reg_cflag	= Request("cflag")
	photo_reg_gubun	= Request("rsubGubun")
	

	If Len(hid_myPhoto)>0 And InStr(hid_myPhoto, "/")>0 Then 
		splPhoto	= Split(hid_myPhoto, "/")	
		chkPolder	= splPhoto(0)
		chkFileNm	= splPhoto(1)
	End If 


	Dim sourcepath
	'sourcepath	= "D:\solution\"& site_title &"\files\mypic\"&chkPolder	' ���� ���� ��ġ
	sourcepath = "\\218.145.70.142\files$\files\fair\mypic\" & chkPolder

	Dim objFS, Post
	Set objFS = CreateObject("Scripting.FileSystemObject")


	If Len(chkFileNm)>0 Then
		
		' 1) ���� ����
		Set Post = Server.CreateObject("ActiveFile.Post")
		On Error Resume Next
		objFs.DeleteFile sourcepath &"\"& chkFileNm
		Post.Flush
		Set Post = Nothing 

		' 2) DB ���� ���� ����
ConnectDB DBCon, Application("DBInfo_FAIR")

		strSql = "UPDATE ����ȸ������ SET �������� = ''"
		strSql = strSql & " WHERE ���ξ��̵� = '" & user_id & "'"
		strSql = strSql & " ; UPDATE �̷¼� SET �������� = '0', ��������=''"
		strSql = strSql & " WHERE ���ξ��̵� = '" & user_id & "'"
		strSql = strSql & " ; UPDATE �̷¼��������� SET �������� = '0', ��������=''"
		strSql = strSql & " WHERE ���ξ��̵� = '" & user_id & "'"
DBCon.Execute (strSql)

DisconnectDB DBCon

		Response.Write "<script language=javascript>"&_
		"alert('�̷¼� ������ ���� �Ǿ����ϴ�.');"&_
		"location.href='/my/resume/rsub_regist.asp?rid=" & photo_reg_rid & "&step=" & photo_reg_stp & "&rtype=" & photo_reg_rtype & "&cflag=" & photo_reg_cflag & "&rsubGubun=" & photo_reg_gubun & "';"&_
		"</script>"
		Response.End
	Else 
		Response.write "<script language='javascript'>"
		Response.write "alert('���� ��� ������ ã�� �� �����ϴ�.');"
		Response.write "history.back();"
		Response.write "</script>"
	End If 
%>