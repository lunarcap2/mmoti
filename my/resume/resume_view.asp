<!--#include virtual = "/common/common.asp"-->
<!--#include virtual = "/wwwconf/function/db/DBConnection.asp"-->
<!--#include virtual = "/wwwconf/code/code_function.asp"-->
<!--#include virtual = "/wwwconf/code/code_function_ac.asp"-->
<!--#include virtual = "/wwwconf/code/code_function_jc.asp"-->
<!--#include virtual = "/wwwconf/code/code_function_resume.asp"-->
<!--#include virtual = "/wwwconf/code/code_resume.asp"-->
<!--#include virtual = "/wwwconf/query_lib/user/ResumeInfo.asp"-->
<%
	Call FN_LoginLimit("1")	'����ȸ�� ���

	Dim stp     : stp = 1					'�̷¼� �ܰ�
	Dim rid     : rid = request("rid")		'�̷¼� ��Ϲ�ȣ (rid�� ������ ����)
	Dim rtype   : rtype = "T"				'�̷¼� ����(T:�߰�����, C:�Ϸ�)
	Dim cflag   : cflag = request("cflag")	'����/��� ����. 1/8 �� ���簪�� ����

	If rid = "" Or rid = "0" Then
		ShowAlertMsg "�߸��� �����Դϴ�.", "history.back();", True
	End If

	Dim i, ii
%>
<!--#include virtual = "/my/resume/comm/getResumeStepDBInfo.asp"-->
<!--#include virtual = "/include/header/header.asp"-->
<script type="text/javascript">

</script>
</head>

<body>

<!-- header -->
<div  id="header">
	<div class="header-wrap detail">
		<div class="detail_box">
			<a href="javascript:window.close();" class="close">�ݱ�</a>
			<p>������ ����</p>
		</div>
		</div>
	</div>
</div>
<!-- //header -->

<!-- ���� -->
<!--#include file = "./comm/inc_resume_view.asp"-->
<!-- //���� -->

<!-- �ϴ� -->
<!--#include virtual = "/include/footer.asp"-->
<!-- �ϴ� -->

</body>
</html>