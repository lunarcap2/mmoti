<%@  codepage="949" language="VBScript" %>
<%
 Option Explicit
 Session.CodePage = 949
 Response.ChaRset = "EUC-KR"
%>
<%
'============================================================
'	�̷¼� ����(�Է�/����) : �ܰ躰(step), �Ϸ�� �̷¼� ����
'
'	#�����ۼ���	: 2009-12-07
'	#�ۼ���		: �ӱ���(gidol@career.co.kr)
'============================================================
'Response.Buffer= True

'------ ������ �⺻���� ����.
g_MenuID = "110101"
'redir = ""	'�ѹ�URL�� �����������̸� �������� ������.
%>

<!--#include virtual = "/common/common.asp"-->
<!--#include virtual = "/include/header/header.asp"-->

<% Call FN_LoginLimit("1")    '����ȸ���� ���ٰ��� %>

<!--#include virtual = "/wwwconf/function/db/DBConnection.asp"-->
<!--#include virtual = "/wwwconf/code/code_resume.asp"-->
<!--#include virtual = "/wwwconf/function/common/base_util.asp"-->
<!--#include virtual = "/wwwconf/function/resume/getResumeExecParamsNew.asp"-->
<!--#include virtual = "/wwwconf/query_lib/user/ResumeInfo.asp"-->

<!--#include virtual = "/my/resume/comm/ResumeInfo.asp"-->
<%
Dim svrNm			: svrNm			= Request.ServerVariables("SERVER_NAME")
Dim myDir			: myDir			= "/my"
Dim siteGubun		: siteGubun		= "W"
Dim siteDomain		: siteDomain	= "career.co.kr"
Dim siteDomainstr	: siteDomainstr	= ""

If siteDomain <> "" Then
	siteDomainstr = "document.domain='" & siteDomain & "';" & vbcrlf
End If

Dim stp		: stp		= Request.Form("stp")
Dim rid		: rid		= strFix(Request.Form("rid"), "int", 0)
Dim rtype	: rtype		= Request.Form("rtype")
Dim cflag	: cflag		= request.form("cflag")
Dim rGubun	: rGubun	= Request.Form("rGubun")
'If rtype = "C" Then stp = "5"

Dim complete_rid    '�Ϸ�� �̷¼� ��Ϲ�ȣ
Dim resumeIsComplete	: resumeIsComplete	= Request.Form("resumeIsComplete")
Dim isBaseResume		: isBaseResume		= Request.Form("isBaseResume")
Dim rsubGubun			: rsubGubun			= Request.Form("rsubGubun")

Dim ii, seq
Dim retUrl, ret_val, execRid, res_seq
Dim self_intro, jc_code_all, ct_code_all
Dim rsubItem, rsub_seq_no
Dim save_resume_id, complete_resume_id

save_resume_id		= 0
complete_resume_id	= 0
rsubItem	= Trim(Request.Form("rsubItem"))
rsub_seq_no	= Trim(Request.Form("rsub_seq_no"))
self_intro	= Request.Form("self_intro")
self_intro	= CareerEnCrypt(self_intro)

g_debug = False

If rtype = "T" And CK_ResumeCnt >= 10 And rid = 0 Then
	ShowAlertMsg "�̷¼��� 10������ ����� �����մϴ�.", "location.replace('"& mydir &"/resume_list.asp');", True
End If
%>

<!--����-->
<!--#include virtual = "/my/resume/inc_resume_item_delete_T.asp"-->

<!--�ӽ�����, ����, ����-->
<!--#include virtual = "/my/resume/inc_resume_item_insert_T.asp"-->
	
<%
Dim move_url, msg

If rsubGubun = "1" Or rsubGubun = "4" Or rsubGubun = "5" Or rsubGubun = "13" Then
	move_url = "/my/resume/rsub_regist_T.asp"
Else
	move_url = "/my/resume/rsub_view_T.asp"
End If

if rtype = "T" Then		
	If resumeIsComplete = "2" Then '�߰������ϰ��
		msg = "�ӽ������� �Ϸ�Ǿ����ϴ�."
	ElseIf resumeIsComplete = "3" Then '�߰����� �̸�����
		move_url = "/my/resume/resume_preview.asp"
	ElseIf resumeIsComplete = "1" Then
		msg = "�̷¼� ����� �Ϸ�Ǿ����ϴ�."
		move_url = "/my/resume_list.asp"
	Else
		move_url = "./resume_regist_T.asp"
	End If
Else
	If resumeIsComplete = "3" Then '�߰����� �̸�����
		move_url = "/my/resume/resume_preview.asp"
	ElseIf resumeIsComplete = "1" Or resumeIsComplete = "4" Then
		msg = "����Ǿ����ϴ�."
	Else
		move_url = "./resume_regist_T.asp"
	End If
End If
%>

<script type="text/javascript">
	$(document).ready(function () {
		var completeGB = '<%=resumeIsComplete%>';
		if(completeGB == '1' || completeGB == '2' || completeGB == '4') {
			alert('<%=msg%>');
		}
		
		$('#frm_resume').attr('action', '<%=move_url%>');
		$('#frm_resume').submit();
	});
</script>

<form method="post" id="frm_resume" name="frm_resume" target="_self" action="">
	<input type="hidden" id="rid" name="rid" value="<%=rid%>" />
	<input type="hidden" name="rtype" value="<%=rtype%>" />
	<input type="hidden" name="cflag" value="<%=cflag%>" />
	<input type="hidden" name="stp" value="<%=stp%>" />
	<input type="hidden" name="rGubun" value="<%=rGubun%>" />
	<input type="hidden" name="resumeIsComplete" value="<%=resumeIsComplete%>" />
	<input type="hidden" name="isBaseResume" value="<%=isBaseResume%>" />

	<input type="hidden" id="rsubGubun" name="rsubGubun" value="<%=rsubGubun%>" />
</form>

