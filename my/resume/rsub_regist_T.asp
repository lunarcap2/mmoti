<!--#include virtual = "/common/common.asp"-->
<!--#include virtual = "/include/header/header.asp"-->

<%
Dim rid				: rid			= Request("rid")
Dim stp				: stp			= Request("stp")
Dim rtype			: rtype			= Request("rtype")
Dim cflag			: cflag			= Request("cflag")
Dim rsubGubun		: rsubGubun		= Request("rsubGubun")
Dim schoolGubun		: schoolGubun	= Request("schoolGubun")
Dim isBaseResume	: isBaseResume	= Request("isBaseResume")
Dim rsubItem		: rsubItem		= Request("rsubItem")
Dim rsub_seq_no		: rsub_seq_no	= Request("rsub_seq_no")

Dim rsubGubun_txt
Select Case rsubGubun
	Case 1	rsubGubun_txt = "������"
	Case 2	rsubGubun_txt = "�з»���"
	Case 3	rsubGubun_txt = "��»���"
	Case 4	rsubGubun_txt = "�ڱ�Ұ���"
	Case 5	rsubGubun_txt = "����ٹ�����"
	Case 6	rsubGubun_txt = "����.���Ȱ��"
	Case 7	rsubGubun_txt = "�ܱ���"
	Case 8	rsubGubun_txt = "�ڰ���"
	Case 9	rsubGubun_txt = "����"
	Case 10 rsubGubun_txt = "����"
	Case 11 rsubGubun_txt = "�ؿܰ���"
	Case 12 rsubGubun_txt = "��Ʈ������"
	Case 13 rsubGubun_txt = "�������׸�"
End Select

ConnectDB DBCon, Application("DBInfo_FAIR")

	ReDim parameter(5)
	parameter(0)    = makeParam("@user_id", adVarChar, adParamInput, 20, user_id)
	parameter(1)    = makeParam("@rid", adVarChar, adParamInput, 50, rid)
	parameter(2)    = makeParam("@rsubGubun", adVarChar, adParamInput, 2, rsubGubun)
	parameter(3)    = makeParam("@rsubItem", adVarChar, adParamInput, 2, rsubItem)
	parameter(4)    = makeParam("@seq_no", adVarChar, adParamInput, 50, rsub_seq_no)
	parameter(5)    = makeParam("@rtype", adVarChar, adParamInput, 1, rtype)
	
	Dim arrDetail : arrDetail = arrGetRsSP(DBcon, "usp_�̷¼�_�׸�_��ȸ_M", parameter, "", "")

DisconnectDB DBCon

Response.write stp & "<br>"
Response.write isBaseResume
%>

<!--#include virtual = "/wwwconf/code/code_function.asp"-->
<!--#include virtual = "/wwwconf/code/code_function_ac.asp"-->
<!--#include virtual = "/wwwconf/code/code_function_jc.asp"-->
<!--#include virtual = "/wwwconf/code/code_function_resume.asp"-->
<!--#include virtual = "/wwwconf/code/code_resume.asp"-->

<!--#include virtual = "/wwwconf/function/db/DBConnection.asp"-->
<!--#include virtual = "/wwwconf/query_lib/user/ResumeInfo.asp"-->
<!--#include virtual = "/my/resume/comm/getResumeStepDBInfo.asp"-->

<!--�̷¼� ������ ����-->
<!--#include virtual = "/my/resume/inc_resume_data_set.asp"-->

<script type="text/javascript">
	function fn_move() {
		var move_url	= '';
		var msg			= '';
		var _val		= $('#rsubGubun').val();

		$('#frm_resume').attr('onsubmit','');
		
		if($('#rsub_step2').val() != '') {
			if(val == '5') {
				$('#rsub_area').hide();
				$('#rsub_ctjc').hide();
			}
			
			$('#contents').show();
			$('#rsub_step2').val('');
		}
		else{			
			if(_val == '1' || _val == '4' || _val == '5' || _val == '13') {
				move_url	= './resume_regist_T.asp';
				msg			= '�޴��� ���ư��ðڽ��ϱ�?';
			}
			else {
				move_url	= './rsub_view_T.asp';
				msg			= '����Ʈ�� ���ư��ðڽ��ϱ�?';
			}

			if(confirm(msg + '\n�Է��� �����Ͱ� �ִٸ� ������� �ʽ��ϴ�.')) {
				$('#frm_resume').attr('action', move_url);
				$('#frm_resume').submit();
			}
		}
	}
</script>
</head>

<body>
	<script>
		$(document).ready(function () {
			//$(this).include(true);
			$(this).customTags();
		});
	</script>

	<!-- header -->
	<div id="header">
		<div class="header-wrap detail">
			<div class="detail_box">
				<a href="javascript:;" onclick="fn_move();">����</a>
				<p><%=rsubGubun_txt%></p>
			</div>
		</div>
	</div>
	<!-- //header -->

	<form method="post" id="frm_resume" name="frm_resume" action="">
		<input type="hidden" id="rid" name="rid" value="<%=rid%>" />
		<input type="hidden" name="rtype" value="<%=rtype%>" />
		<input type="hidden" name="cflag" value="<%=cflag%>" />
		<input type="hidden" name="stp" value="<%=stp%>" />
		<input type="hidden" name="rGubun" value="<%=rGubun%>" />
		<input type="hidden" name="resumeIsComplete" value="" />
		<input type="hidden" name="isBaseResume" value="<%=isBaseResume%>" />

		<input type="hidden" id="rsubGubun" name="rsubGubun" value="<%=rsubGubun%>" />
		<input type="hidden" id="hid_myPhoto" name="hid_myPhoto" value="<%=p_userPhoto%>">

		<input type="hidden" id="rsub_step2" name="rsub_step2" value="" /> <!--���������� ��ϴ��϶� ��� (��»���(3)�� ������Ʈ������/ ����ٹ�����(5)�� ����,������)-->
		<input type="hidden" id="rsubItem" name="rsubItem" value="<%=rsubItem%>" />
		<input type="hidden" id="rsub_seq_no" name="rsub_seq_no" value="<%=rsub_seq_no%>" />

		<% If rsubGubun = "1" Then %>
			<!--#include virtual = "/my/resume/rsub_regist/rsub_regist_01_userinfo_T.asp"-->
		<% ElseIf rsubGubun = "2" Then %>
			<% If schoolGubun = "3" Then %>
				<!--#include virtual = "/my/resume/rsub_regist/rsub_regist_02_school_high.asp"-->
			<% Else %>
				<!--#include virtual = "/my/resume/rsub_regist/rsub_regist_02_school_univ.asp"-->
			<% End If %>
		<% ElseIf rsubGubun = "3" Then %>
			<!--#include virtual = "/my/resume/rsub_regist/rsub_regist_03_career.asp"-->
		<% ElseIf rsubGubun = "4" Then %>
			<!--#include virtual = "/my/resume/rsub_regist/rsub_regist_04_introduce.asp"-->
		<% ElseIf rsubGubun = "5" Then %>
			<!--#include virtual = "/my/resume/rsub_regist/rsub_regist_05_desire.asp"-->
		<% ElseIf rsubGubun = "6" Then %>
			<!--#include virtual = "/my/resume/rsub_regist/rsub_regist_06_activity.asp"-->
		<% ElseIf rsubGubun = "7" Then %>
			<!--#include virtual = "/my/resume/rsub_regist/rsub_regist_07_language.asp"-->
		<% ElseIf rsubGubun = "8" Then %>
			<!--#include virtual = "/my/resume/rsub_regist/rsub_regist_08_license.asp"-->
		<% ElseIf rsubGubun = "9" Then %>
			<!--#include virtual = "/my/resume/rsub_regist/rsub_regist_09_awards.asp"-->
		<% ElseIf rsubGubun = "10" Then %>
			<!--#include virtual = "/my/resume/rsub_regist/rsub_regist_10_education.asp"-->
		<% ElseIf rsubGubun = "11" Then %>
			<!--#include virtual = "/my/resume/rsub_regist/rsub_regist_11_overseas.asp"-->
		<% ElseIf rsubGubun = "12" Then %>
			<!--#include virtual = "/my/resume/rsub_regist/rsub_regist_12_portfolio.asp"-->
		<% ElseIf rsubGubun = "13" Then %>
			<!--#include virtual = "/my/resume/rsub_regist/rsub_regist_13_preferential.asp"-->
		<% End If %>
	</form>

	<!-- �ϴ� -->
	<!--#include virtual = "/include/footer.asp"-->
	<!-- //�ϴ� -->
</body>

</html>

<iframe id="procFrame" name="procFrame" style="position:absolute; top:0; left:0; width:0;height:0;border:0;" frameborder="0" src="about:blank"></iframe>

<!--���ϵ��-->
<form id="fileUploadForm" name="fileUploadForm" method="post" enctype="multipart/form-data" target="procFrame" action="./file_upload.asp" onsubmit="return false;">
	<span style="display:none;">
	<input type="file" id="uploadFile" name="uploadFile" onchange="javascript:document.fileUploadForm.submit();">
	</span>
	<input type="hidden" id="file_index" name="file_index" value="">
	<input type="hidden" id="pre_file_name" name="pre_file_name" value="">
</form>

<!--���ϻ���-->
<form id="filedelForm" name="filedelForm" method="post" target="procFrame" action="./file_del.asp">
	<input type="hidden" id="del_resume_no" name="del_resume_no" value="<%=rid%>">
	<input type="hidden" id="del_file_name" name="del_file_name" value="">
	<input type="hidden" id="del_file_seq" name="del_file_seq" value="">
</form>