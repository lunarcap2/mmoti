<% option Explicit %>

<!--#include virtual = "/common/common.asp"-->
<!--#include virtual = "/include/header/header.asp"-->

<%
Call FN_LoginLimit("1")    '����ȸ���� ���ٰ���

Dim stp     : stp = 1					'�̷¼� �ܰ�
Dim rid     : rid = request("rid")		'�̷¼� ��Ϲ�ȣ (rid�� ������ ����)
Dim rtype   : rtype = "T"				'�̷¼� ����(T:�߰�����, C:�Ϸ�)
Dim cflag   : cflag = request("cflag")	'����/��� ����. 1/8 �� ���簪�� ����

Dim isBaseResume						'�⺻�̷¼�
Dim set_user_id							'�ٸ� ������� �̷¼��� �������� ����ھ��̵�(�信���� ���)
Dim apply_resume						'�Ի����� �̷¼� ��ȸ����(���ȸ�� �����ڰ��� ���)
%>

<!--#include virtual = "/wwwconf/code/code_function.asp"-->
<!--#include virtual = "/wwwconf/code/code_function_ac.asp"-->
<!--#include virtual = "/wwwconf/code/code_function_jc.asp"-->
<!--#include virtual = "/wwwconf/code/code_function_resume.asp"-->
<!--#include virtual = "/wwwconf/code/code_resume.asp"-->

<!--#include virtual = "/wwwconf/function/db/DBConnection.asp"-->
<!--#include virtual = "/wwwconf/query_lib/user/ResumeInfo.asp"-->
<!--#include virtual = "/my/resume/comm/getResumeStepDBInfo.asp"-->

<%
Dim i, ii, seq
Dim comma : comma = ", "

'--�ۼ����� �̷¼� rid
Dim ing_rid : ing_rid = 0
Dim ing_rGubun
If IsArray(arrIngResume) Then
	ing_rid = arrIngResume(0,0)
	ing_rGubun = arrIngResume(1,0)
End If

'--�̷¼� �űԵ�� �� : 3���̻� ��� ���� > 10���� ����
If rid = 0  Then
	If IsArray(arrIngResume) Then
		If iResumeCnt >= 10 And ing_rid = 0 Then
			ShowAlertMsg "�̷¼��� 10������ ����� �����մϴ�.", "location.replace('/my/resume_list.asp');", True
		ElseIf iResumeCnt >= 10 And ing_rid > 0 Then
			ShowAlertMsg "", "if(confirm('�ۼ����� �̷¼��� �ֽ��ϴ�. ��� �ۼ��Ͻðڽ��ϱ�?')){location.replace('/my/resume/resume_regist.asp?rid="& ing_rid & "');}else{location.replace('/my/resume_list.asp');}", True
		ElseIf iResumeCnt < 10 And ing_rid > 0 Then
			ShowAlertMsg "", "if(confirm('�ۼ����� �̷¼��� �ֽ��ϴ�. ��� �ۼ��Ͻðڽ��ϱ�?')){location.replace('/my/resume/resume_regist.asp?rid="& ing_rid &"');}else{location.replace('/my/resume_list.asp');}", True
		End If
	Else
		If iResumeCnt >= 10 And ing_rid = 0 Then
			ShowAlertMsg "�̷¼��� 10������ ����� �����մϴ�.", "location.replace('/my/resume_list.asp');", True
		ElseIf iResumeCnt >= 10 And ing_rid > 0 Then
			ShowAlertMsg "", "if(confirm('�ۼ����� �̷¼��� �ֽ��ϴ�. ��� �ۼ��Ͻðڽ��ϱ�?')){location.replace('"& mydir &"/resume/resume_regist.asp?rid="& ing_rid & "');}else{location.replace('"& mydir &"');}", True
		ElseIf iResumeCnt < 10 And ing_rid > 0 Then
			ShowAlertMsg "", "if(confirm('�ۼ����� �̷¼��� �ֽ��ϴ�. ��� �ۼ��Ͻðڽ��ϱ�?')){location.replace('"& mydir &"/resume/resume_regist.asp?rid="& ing_rid &"');}else{location.replace('"& mydir &"/resume/resume_reg_step1.asp?flag=1&cflag=" & cflag & "');}", True
		End If
	End if
End If

'�⺻�̷¼� ������
If iResumeCnt = "0" Then isBaseResume = "1"
If rid <> 0 And IsArray(arrResume) Then isBaseResume = arrResume(1, 0)

Response.write isBaseResume & "<br>"
Response.write rid & "<br>"
Response.write stp
%>

<!--�̷¼� ������ ����-->
<!--#include virtual = "/my/resume/inc_resume_data_set.asp"-->

<script type="text/javascript">
	$(document).ready(function () {
		window.onpageshow = function(event) {
			if(event.persisted || (window.performance && window.performance.navigation.type == 2)) {
				location.reload();
			}
		}

		//$(this).include(true);
		$(this).customTags();


		$('li[id^="resume"]').hide();

		$('#resume2').show();	//�з�
		$('#resume3').show();	//���
		$('#resume4').show();	//�ڱ�Ұ���
		$('#resume5').show();	//����ٹ�����

		var arrActivity		= '<%=isArray(arrActivity)%>';		//����.���Ȱ��
		var arrLanguageUse	= '<%=isArray(arrLanguageUse)%>';	//�ܱ���
		var arrLanguageExam	= '<%=isArray(arrLanguageExam)%>';	//�ܱ���
		var arrLicense		= '<%=isArray(arrLicense)%>';		//�ڰ���
		var arrPrize		= '<%=isArray(arrPrize)%>';			//����
		var arrAcademy		= '<%=isArray(arrAcademy)%>';		//����
		var arrAbroad		= '<%=isArray(arrAbroad)%>';		//�ؿܰ���
		var arrPortfolio	= '<%=isArray(arrPortfolio)%>'		//��Ʈ������
		var arrPersonal		= '<%=isArray(arrPersonal)%>';		//�������׸�
		var arrMilitary		= '<%=isArray(arrMilitary)%>';		//�������׸�
		var arrEmpSupport	= '<%=isArray(arrEmpSupport)%>';	//�������׸�

		var arrBase			= '<%=isArray(arrBase)%>';

		if($("#rid").val() != "0") {
			if(arrActivity != 'False') {
				$('#resume6').show();
				$('input[id="chk_resume6"]').prop('checked',true);
			}

			if(arrLanguageUse != 'False' || arrLanguageExam != "False") {
				$('#resume7').show();
				$('input[id="chk_resume7"]').prop('checked',true);
			}

			if(arrLicense != 'False') {
				$('#resume8').show();
				$('input[id="chk_resume8"]').prop('checked',true);
			}

			if(arrPrize != 'False') {
				$('#resume9').show();
				$('input[id="chk_resume9"]').prop('checked',true);
			}

			if(arrAcademy != 'False') {
				$('#resume10').show();
				$('input[id="chk_resume10"]').prop('checked',true);
			}

			if(arrAbroad != 'False') {
				$('#resume11').show();
				$('input[id="chk_resume11"]').prop('checked',true);
			}

			/*
			if(arrPortfolio != 'False') {
				$('#resume12').show();
				$('input[id="chk_resume12"]').prop('checked',true);
			}
			*/

			if(arrPersonal != 'False' || arrMilitary != 'False' || arrEmpSupport != 'False') {
				$('#resume13').show();
				$('input[id="chk_resume13"]').prop('checked',true);
			}
		}

		$('[name="chk_resume"]').each(function () {
			$(this).attr('onclick','fn_chk(this);');
			
			if('<%=rtype%>' == 'C' && this.checked == true) {
				$(this).attr('onclick','fn_del(\'\',\'\',\'' + $(this).val() + '\')');
			}
		});
	});

	//�� �׸� �̵�
	function fn_move(val) {
		var rid		= '<%=rid%>';
		var move_url = './rsub_view_T.asp';

		if(rid == 0 && val != '1') {
			fn_first();
			return;
		}

		if(val == '1' || val == '4' || val == '5' || val == '13') {
			var move_url = './rsub_regist_T.asp';
		}

		$('#rsubGubun').val(val);
		
		$('#frm_resume').attr('target', '_self');
		$('#frm_resume').attr('action', move_url);
		$('#frm_resume').submit();
	}

	//�̷¼��׸��߰�
	function fn_chk(obj) {
		var chk_bool	= $(obj).is(":checked");
		var chk_val		= $(obj).val();

		if(chk_bool) {
			$('#resume' + chk_val).show();
		}
		else {
			$('#resume' + chk_val).hide();
		}
	}

	function fn_first() {
		alert('�������� ���� ����� �ּ���.');
		return;
	}
</script>

</head>
<body>
	<!-- header -->
	<div  id="header">
		<div class="header-wrap detail">
			<div class="detail_box">
				<a href="/my/resume_list.asp">����</a>
				<p><%=p_headertit%></p>
			</div>
		</div>
	</div>
	<!-- //header -->

	<!-- container -->
	<div id="contents" class="sub_page mmGray">
		<div class="contents">
			<!-- �̷¼���ϼ�������:S -->
			<div class="mmResumeWrap">
				<div class="mmProfileArea">
					<div class="mmProfileinner">
						<div class="mmProfileTitle">
							<div class="mmCmmInput">
								<div class="ip">
									<input type="text" value="<%=p_resumeTitle%>" readonly>
								</div>
							</div>
						</div>
						<div class="lt">
							<div class="mmThumb">
								<div class="mmThumbInner">
									<img src="<%=p_userPhotoURL%>" alt="">
								</div>
							</div>
							<a href="javascript:;" class="mmBtns white blue bold md MT15" onclick="fn_move('1');">������ ���</a>
						</div>
						<div class="rt">
							<div class="txts">
								<ul class="lst">
									<li class="tp">
										<span class="lb">�̸�</span>
										<div class="tt"><%=p_userName%>(<%=p_age%>)
											<!--
											<%
											If p_age <> "" And p_gender <> "" Then
											%>
											(<%=p_age%><%=comma%><%=p_gender%>)
											<% Else %>
											(<%=p_age%><%=p_gender%>)
											<% End If %>
											-->
										</div>
									</li>
									<li class="tp">
										<span class="lb">�޴���</span>
										<div class="tt"><%=p_phone%></div>
									</li>
									<li class="tp">
										<span class="lb">�̸���</span>
										<div class="tt"><%=p_email%></div>
									</li>
									<li class="tp">
										<span class="lb">�ּ�</span>
										<div class="tt multiEllipsis"><%=p_address%></div>
									</li>
									<li class="tp">
										<span class="lb">�����Ұ�</span>
										<div class="tt multiEllipsis"><%=p_selfIntro%></div>
									</li>
								</ul>
							</div>
						</div>
					</div>
					<div class="mmBtnsWrap TXTR">
						<% If rid <> 0 Then %>
						<a href="javascript:;" class="mmBtns white outline md bold" onclick="fn_resume_save_preview();">�̷¼� ����</a>
						<% End If %>
					</div>
				</div>
				<div class="mmLstArea">
					<ul class="mmlstUl">
						<!-- forEach : S
							- �з»���, ��»���, �ڱ�Ұ���, ��� �ٹ����� ���
						-->
						<%
						For i=2 To 13
							Dim item_val
							Select Case i
								Case 2	item_val = "�з»���&"		& final_school
								Case 3	item_val = "��»���&"		& total_career
								Case 4	item_val = "�ڱ�Ұ���&"	& introduce_cnt
								Case 5	item_val = "����ٹ�����&"	& desire_cnt
								Case 6	item_val = "����.���Ȱ��&"	& lately_activity
								Case 7	item_val = "�ܱ���&"		& kind_language
								Case 8	item_val = "�ڰ���&"		& license_cnt
								Case 9	item_val = "����&"			& awards_cnt
								Case 10 item_val = "����&"			& education_cnt
								Case 11 item_val = "�ؿܰ���&"		& lately_overseas
								Case 12 item_val = "��Ʈ������&"	& portfolio_cnt
								Case 13 item_val = "�������׸�&"	& preferential_cnt
							End Select
						%>
						<% If i <> 12 Then %>
						<li class="mmLstTp" id="resume<%=i%>">
							<div class="inner">
								<a href="javascript:;" class="txts" onclick="fn_move('<%=i%>');">
									<span class="lb"><%=Split(item_val,"&")(0)%></span>
									<div class="tt mmColorActiun"><%=Split(item_val,"&")(1)%></div>
									<span class="icos arrowNext"></span>
								</a>
							</div>
						</li>
						<% End If %>
						<% Next %>
						<!-- forEach : E -->
					</ul>
				</div>
				<div class="resumAddArea MT60">
					<div class="innerWrap">
						<div class="mmTit">�̷¼� �׸� �߰�</div>
						<div class="listArea MT20">
							<div class="mmRow allPadding">
								<!-- �̷¼��׸��߰� forEach : S -->
								<%
								For i=6 To 13
									Dim add_item
									Select Case i
										Case 6	add_item = "����.���Ȱ��"
										Case 7	add_item = "�ܱ���"
										Case 8	add_item = "�ڰ���"
										Case 9	add_item = "����"
										Case 10	add_item = "����"
										Case 11 add_item = "�ؿܰ���"
										Case 12 add_item = "��Ʈ������"
										Case 13 add_item = "�������׸�"
									End Select
								%>
								<% If i <> 12 Then %>
								<div class="mmCol6">
									<div class="mmCmmInput radiochk">
										<input type="checkbox" id="chk_resume<%=i%>" name="chk_resume" value="<%=i%>">
										<label for="chk_resume<%=i%>" class="lb FWB"><%=add_item%></label>
									</div>
								</div>
								<% End If %>
								<% Next %>
								<!-- �̷¼��׸��߰� forEach : E -->
							</div>
						</div>
					</div>
				</div>

				<% If rtype <> "C" Then %>
				<div class="resumAddArea MT60">
					<div class="innerWrap">
						<div class="mmCmmLst indent indent13 MT15">
							<div class="cmmtp mmColorRed">* ��Ϲ�ư�� �����ž� ������ϵ˴ϴ�.</div>
						</div>
					</div>
					<div class="mmBtnsWrap TXTC MT60">
						<% If rid = "0" Then %>
						<a href="javascript:;" class="mmBtns navy" onclick="fn_first();">���</a>
						<% Else %>
						<a href="javascript:;" class="mmBtns navy" onclick="fn_resume_save();">���</a>
						<% End If %>
					</div>
				</div>
				<% End If %>
			</div>
			<!-- �̷¼���ϼ�������:S -->
		</div>
	</div>
	<!-- //container -->

	<!-- �ϴ� -->
	<!--#include virtual = "/include/footer.asp"-->
	<!-- //�ϴ� -->
</body>
</html>

<form method="post" id="frm_resume" name="frm_resume" action="">
	<input type="hidden" id="rid" name="rid" value="<%=rid%>" />
	<input type="hidden" name="rtype" value="<%=rtype%>" />
	<input type="hidden" name="cflag" value="<%=cflag%>" />
	<input type="hidden" name="stp" value="<%=stp%>" />
	<input type="hidden" name="rGubun" value="<%=rGubun%>" />
	<input type="hidden" name="resumeIsComplete" value="" />
	<input type="hidden" name="isBaseResume" value="<%=isBaseResume%>" />

	<input type="hidden" id="rsubGubun" name="rsubGubun" value="" />
	<input type="hidden" id="rsubItem" name="rsubItem" value="" />
	<input type="hidden" id="rsub_seq_no" name="rsub_seq_no" value="" />
</form>
