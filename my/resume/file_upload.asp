<%
	Option Explicit

	Response.CacheControl = "no-cache"
	Response.AddHeader "Pragma", "no-cache"
	Response.Expires = -1
	Response.Charset = "euc-kr"
%>
<!--#include virtual = "/common/constant.asp"-->
<%	
	dim temppath, sourcepath
	'temppath = "D:\solution\"& site_title &"\files\temp\"
	'sourcepath = "D:\solution\"& site_title &"\files\resume\"

	temppath = "\\218.145.70.142\files$\files\temp\"
	sourcepath = "\\218.145.70.142\files$\files\fair\resume\"

	Dim targetpath, datepath
	datepath = Left(replace(FormatDateTime(Now(), 2),"-",""), 6)
	targetpath = sourcepath & datepath & "\"
	
	Dim objFS
	set objFS = CreateObject("Scripting.FileSystemObject")

	Randomize()
	dim randomno : randomno = Int(10000* Rnd())
	randomno = right("0000"&randomno,5)
	dim newFileName : newFileName = replace(FormatDateTime(Now(), 2),"-","") & replace(FormatDateTime(Now(), 4),":","") & right(now(),2) & randomno

	dim Post, UploadedFile
	dim fileName, fileExtension, fileSize, filefullName
	dim user_photo, gubun, frmnm
	dim strsql, str, strDBCon

    Dim maxFileSize

    '-- ÷������ �ø���
	if inStr(Request.ServerVariables("CONTENT_TYPE"), "multipart/form-data") > 0 then

		' Perform the upload
		set Post = Server.CreateObject("ActiveFile.Post")
		'Post.MaxFileSize=150000

		On Error Resume Next

		Post.Upload temppath
		
		set UploadedFile = Post("uploadFile").File
		fileExtension = UploadedFile.FileExtension
		fileSize = UploadedFile.Size
		fileName = UploadedFile.FileName

		'Response.write "fileExtension : " & fileExtension & "<br>"
		'Response.write "filename : " & fileName & "<br>"

		'input�� ��������
		Dim file_index, pre_file_name
		file_index = Post.FormInputs("file_index").Value
		pre_file_name = Post.FormInputs("pre_file_name").Value

		dim AllowExtension : AllowExtension = Array("gif", "jpg", "jpeg", "png", "txt", "pdf", "ppt", "pptx", "xls", "xlsx", "doc", "docx", "hwp")
		dim blnAllowExtension : blnAllowExtension = false
		dim intIndex
		For intIndex=0 to Ubound(AllowExtension)
			If LCase(fileExtension) = AllowExtension(intIndex) then
				blnAllowExtension = true
				Exit For
			End If
		Next
		maxFileSize = 1024 * 1024 * 4

		
		' ��ϰ��� Ȯ���� üũ
		If blnAllowExtension = false then

			UploadedFile.Delete
			set UploadedFile=Nothing
			
			Post.Flush
			set Post=Nothing
			%>
			<script type='text/javascript'>
				var msg = "÷�������� ����� �� �����ϴ�. ����� �� ���� ���� Ȯ���ڸ� ����ϼ̽��ϴ�.";
				top.fn_portfolio_upload_result("0", "<%=file_index%>", "", "", msg);
			</script>
			<%
			'Response.write "0|÷�������� ��ϵ��� �ʾҽ��ϴ�. ����� �� ���� ���� Ȯ���ڸ� ����ϼ̽��ϴ�." 
			Response.End
		end If

		' ���� ������ üũ
		if CLng(fileSize) > maxFileSize then
			
			UploadedFile.Delete
			set UploadedFile=Nothing
			
			Post.Flush
			set Post=Nothing

			%>
			<script type='text/javascript'>
				var msg = "÷�������� ����� �� �����ϴ�. ����� �� �ִ� ���� ������� �ִ� <%=(maxFileSize/1024/1024)%>MB �Դϴ�.";
				top.fn_portfolio_upload_result("0", "<%=file_index%>", "", "", msg);
			</script>
			<%
			'Response.write "0|÷�������� ��ϵ��� �ʾҽ��ϴ�. ����� �� �ִ� ���� ������� �ִ� "& (maxFileSize/1024/1024) &"MB �Դϴ�."
			Response.End
		
		' ���� ��������κ�
		Else

			'���������� ����
			If objFs.FolderExists(targetpath) = False Then
				objFs.CreateFolder(targetpath)
			End If

			UploadedFile.Copy targetpath & newFileName & "." & fileExtension
			UploadedFile.Delete

			'�������� ����
			If pre_file_name <> "" Then
				objFs.DeleteFile sourcepath & pre_file_name
			End If
			
			Post.Flush
			set UploadedFile=Nothing
			set Post=Nothing
			%>
			<script type='text/javascript'>
				var file_index, filename, newfile
				file_index = "<%=file_index%>";
				filename = "<%=fileName%>";
				newfile = "<%=datepath%>/" + "<%=newFileName%>" + "." + "<%=fileExtension%>";
				top.fn_portfolio_upload_result("1", file_index, filename, newfile, "��ϼ���");
			</script>
			<%
			'Response.write "1|" & fileName & "|" & newFileName & "." & fileExtension
			'response.end
		end If
	end if
%>