<%
If isArray(arrDetail) Then
	Dim act_nm, act_type, act_sYY, act_sMM, act_eYY, act_eMM, act_con
	act_nm		= arrDetail(9,0)
	act_type	= arrDetail(3,0)
	act_sYY		= arrDetail(5,0)
	act_sMM		= arrDetail(6,0)
	act_eYY		= arrDetail(7,0)
	act_eMM		= arrDetail(8,0)
	act_con		= arrDetail(11,0)
End If

If Len(act_sMM) = "1" Then act_sMM = "0" & act_sMM
If Len(act_eMM) = "1" Then act_eMM = "0" & act_eMM

Dim act_sDT, act_eDT
If isDate(act_sYY & "-" & act_sMM) Then act_sDT = act_sYY & "." & act_sMM
If isDate(act_eYY & "-" & act_eMM) Then act_eDT = act_eYY & "." & act_eMM
%>

<script type="text/javascript">
	$(document).ready(function () {
		var _act_type = '<%=act_Type%>';

		//����.���Ȱ�� ����
		$('[name="select_rac_type"] option').each(function(i) {
			if(this.value == _act_type) {
				$('[name="select_rac_type"]').initSelectbox(i);
			}
		});
	});

	function fn_rac_s_div(obj) {
		if (obj.value.length == 7) {
			$("#rac_syear").val(obj.value.substr(0, 4));
			$("#rac_smonth").val(obj.value.substr(5, 2));
		} else {
			$("#rac_syear").val("");
			$("#rac_smonth").val("");
		}
	}
	function fn_rac_e_div(obj) {
		if (obj.value.length == 7) {
			$("#rac_eyear").val(obj.value.substr(0, 4));
			$("#rac_emonth").val(obj.value.substr(5, 2));
		} else {
			$("#rac_eyear").val("");
			$("#rac_emonth").val("");
		}
	}

	function _loc_fn_resume_save() {
		//���ÿ��� �ѹ��� �������̼�üũ�� ���� �������̼� ����
		if(!$('[name="rac_organization"]').val()){
			alert('��� �� ��ü���� �Է��� �ּ���.');
			return false;
		}
		if(!$('[name="rac_type"]').val()){
			alert('����.���Ȱ���� ������ �ּ���.');
			return false;
		}
		if(!$('[name="rac_sdate"]').val()){
			alert('���۳���� �Է����ּ���');
			return false;
		}
		if(!$('[name="rac_edate"]').val()){
			alert('���۳���� �Է����ּ���');
			return false;
		}
		if(!$('[name="rac_content"]').val()){
			alert('Ȱ�������� �Է����ּ���');
			return false;
		}
		<% If rsub_seq_no <> "" Then %>
		fn_resume_update();
		<% Else %>
			<% If rtype = "C" Then %>
			fn_resume_save2();
			<% Else %>
			fn_resume_save_imsi();
			<% End If %>
		<% End If %>
	}
</script>

<!-- container -->
<div id="contents" class="sub_page">
	<div class="contents">
		<!-- �̷¼���ϼ�������:S -->
		<div class="mmResumeWrap">
			<div class="resumCreateWrap MT30">
				<div class="innerWrap">
					<div class="mmTit">Ȱ���Ⱓ</div>
					<div class="mmResumeVarTable borderNone">
						<div class="cloneTargetDivision MT30 fnCloneTargetDivision">
							<div class="mmRow border colaps">
								<input type="hidden" id="rac_type" name="rac_type" value="<%=act_type%>" />
								<input type="hidden" id="rac_type_text" name="rac_type_text" value=" " />
								<input type="hidden" id="rac_syear" name="rac_syear" value="<%=act_sYY%>" />
								<input type="hidden" id="rac_smonth" name="rac_smonth" value="<%=act_sMM%>" />
								<input type="hidden" id="rac_eyear" name="rac_eyear" value="<%=act_eYY%>" />
								<input type="hidden" id="rac_emonth" name="rac_emonth" value="<%=act_eMM%>" />
								<input type="hidden" id="rac_location" name="rac_location" value=" " />

								<input type="hidden" id="rac_seq" name="rac_seq" value="<%=rsub_seq_no%>">

								<div class="mmCol12">
									<div class="mmCmmInput">
										<div class="ip">
											<input type="text" name="rac_organization" placeholder="��� �� ��ü���� �Է��� �ּ���." value="<%=act_nm%>" />
										</div>
									</div>
								</div>
								<div class="mmCol12">
									<select class="fnCustomSelect" name="select_rac_type" onchange="fn_sel_value_set(this, 'rac_type');">
										<option value="">����.���Ȱ���� ������ �ּ���.</option>
										<option value="1">����</option>
										<option value="2">�Ƹ�����Ʈ</option>
										<option value="3">����Ȱ��</option>
										<option value="4">���Ƹ�</option>
										<option value="5">�ڿ�����</option>
										<option value="6">���Ȱ��</option>
										<option value="7">��ȸȰ��</option>
									</select>
								</div>
								<div class="mmCol6">
									<div class="mmCmmInput date fnDatePicker">
										<div class="ip">
											<input type="text" name="rac_sdate" placeholder="���۳��" value="<%=act_sDT%>" onkeyup="numCheck(this, 'int'); changeDateType(this); fn_rac_s_div(this);" onblur="chkDateType(this)" maxlength="6" />
										</div>
									</div>
								</div>
								<div class="mmCol6">
									<div class="mmCmmInput date fnDatePicker">
										<div class="ip">
											<input type="text" name="rac_edate" placeholder="������" value="<%=act_eDT%>" onkeyup="numCheck(this, 'int'); changeDateType(this); fn_rac_e_div(this);" onblur="chkDateType(this)" maxlength="6" />
										</div>
									</div>
								</div>
							</div>

							<!-- Ȱ������ �� �������� ���� : S-->
							<div class="mmTit MT55">Ȱ������ �� �������� ����</div>
							<div class="mmRow border colaps MT20">
								<div class="mmCol12">
									<div class="mmCmmInput">
										<div class="ip">
											<textarea name="rac_content" placeholder="Ȱ�� ������(��Ȳ-����-���) ������ �����ϴ� ���� �����ϴ�."><%=act_con%></textarea>
										</div>
									</div>
								</div>
							</div>
							<!-- Ȱ������ �� �������� ���� : E-->
						</div>

						<div class="mmBtnsWrap MT70 TXTC">
							<div class="mmRow">
								<div class="mmCol6">
									<a href="javascript:;" class="mmBtns navy outline FWB" onclick="fn_move();">����ϱ�</a>
								</div>
								<div class="mmCol6">
									<a href="javascript:;" class="mmBtns navy FWB" onclick="_loc_fn_resume_save();">�����ϱ�</a>
								</div>
							</div>
						</div>
					</div><!-- mmResumeVarTable -->

				</div>
			</div>
		</div>
		<!-- �̷¼���ϼ�������:S -->
	</div>
</div>
<!-- //container -->
