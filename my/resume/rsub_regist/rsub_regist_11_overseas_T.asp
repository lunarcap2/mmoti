<%
If isArray(arrDetail) Then
	Dim ove_nm, ove_sYY, ove_sMM, ove_eYY, ove_eMM, ove_con
	ove_nm	= arrDetail(2,0)
	ove_sYY	= arrDetail(4,0)
	ove_sMM	= arrDetail(5,0)
	ove_eYY	= arrDetail(6,0)
	ove_eMM	= arrDetail(7,0)
	ove_con	= arrDetail(8,0)
End If

Dim ove_sDT, ove_eDT
If isDate(ove_sYY & "-" & ove_sMM) Then ove_sDT = ove_sYY & "." & ove_sMM
If isDate(ove_eYY & "-" & ove_eMM) Then ove_eDT = ove_eYY & "." & ove_eMM
%>

<script type="text/javascript">
	$(document).ready(function () {
		var _ove_nm = '<%=ove_nm%>';
		
		//��������
		$('[name="select_abroad_nation_code"] option').each(function(i) {
			if(this.value == _ove_nm) {
				$('[name="select_abroad_nation_code"]').initSelectbox(i);
			}
		});
	});

	function fn_overseas_s_div(obj) {
		if (obj.value.length == 7) {
			$(obj).parents('.cloneTargetDivision').find('#abroad_syear').val(obj.value.substr(0, 4));
			$(obj).parents('.cloneTargetDivision').find('#abroad_smonth').val(obj.value.substr(5, 2));
		} else {
			$(obj).parents('.cloneTargetDivision').find('#abroad_syear').val('');
			$(obj).parents('.cloneTargetDivision').find('#abroad_smonth').val('');
		}
	}
	function fn_overseas_e_div(obj) {
		if (obj.value.length == 7) {
			$(obj).parents('.cloneTargetDivision').find('#abroad_eyear').val(obj.value.substr(0, 4));
			$(obj).parents('.cloneTargetDivision').find('#abroad_emonth').val(obj.value.substr(5, 2));
		} else {
			$(obj).parents('.cloneTargetDivision').find('#abroad_eyear').val('');
			$(obj).parents('.cloneTargetDivision').find('#abroad_emonth').val('');
		}
	}
</script>

<!-- container -->
<div id="overseas_sel_option" style="display:none;">
	<% Call putCodeToSelectOption("getNationCode", 1, 300, "") %>
</div>
<div id="contents" class="sub_page">
	<div class="contents">
		<!-- �̷¼���ϼ�������:S -->
		<div class="mmResumeWrap">
			<div class="resumCreateWrap">
				<div class="innerWrap">

					<div class="mmResumeVarTable borderNone" name="div_overseas">


						<!-- Ŭ�п���:S -->
						<div class="cloneTargetDivision MT30 fnCloneTargetDivision">
							<div class="mmRow border colaps">
								<input type="hidden" id="abroad_nation_code" name="abroad_nation_code" value="<%=ove_nm%>" />
								<input type="hidden" id="abroad_org_name" name="abroad_org_name" value="" />
								<input type="hidden" id="abroad_syear" name="abroad_syear" value="<%=ove_sYY%>" />
								<input type="hidden" id="abroad_smonth" name="abroad_smonth" value="<%=ove_sMM%>" />
								<input type="hidden" id="abroad_eyear" name="abroad_eyear" value="<%=ove_eYY%>" />
								<input type="hidden" id="abroad_emonth" name="abroad_emonth" value="<%=ove_eMM%>" />

								<div class="mmCol12">
									<select class="fnCustomSelect" name="select_abroad_nation_code" onchange="fn_sel_value_set(this, 'abroad_nation_code');">
										<option value="">��������</option>
										<% Call putCodeToSelectOption("getNationCode", 1, 300, "") %>
									</select>
								</div>
								
								<div class="mmCol6">
									<div class="mmCmmInput date fnDatePicker">
										<div class="ip">
											<input type="text" value="<%=ove_sDT%>" name="abroad_sdate" placeholder="���۳��" onkeyup="numCheck(this, 'int'); changeDateType(this); fn_overseas_s_div(this);" onblur="chkDateType(this)" maxlength="6" />
										</div>
									</div>
								</div>
								<div class="mmCol6">
									<div class="mmCmmInput date fnDatePicker">
										<div class="ip">
											<input type="text" value="<%=ove_eDT%>" name="abroad_edate" placeholder="������" onkeyup="numCheck(this, 'int'); changeDateType(this); fn_overseas_e_div(this);" onblur="chkDateType(this)" maxlength="6" />
										</div>
									</div>
								</div>
							</div>

							<!-- �ؿܰ��� ���� : S-->
							<div class="mmTit MT55">�ؿܰ��� ����</div>
							<div class="mmRow border colaps MT20">
								<div class="mmCol12">
									<div class="mmCmmInput">
										<div class="ip">
											<textarea name="abroad_academy_name" value="" placeholder="�ؿܰ��� (ex.���п���, ��ȯ�л�, ��ŷ Ȧ������,�ؿܱٹ�)�� ������ �ּ���. "><%=ove_con%></textarea>
										</div>
									</div>
								</div>
							</div>
							<!-- �ؿܰ��� ���� : E-->
							
							<% If rsub_seq_no = "" Then %>
							<div class="mmBtnsWrap MT30 TXTC">
								<div class="mmRow">
									<div class="mmCol7">
										<a href="#;" class="mmBtns blue2 FWB" onclick="fn_append('<%=rsubGubun%>', this);"><small class="MR10">+</small>�ؿܰ��� �߰��ϱ�</a>
									</div>
								</div>
							</div>
							<% End If %>

							<div class="mmHr MT35"></div>
						</div>
						<!-- Ŭ�п���:E -->


					</div><!-- mmResumeVarTable -->
					<div class="mmBtnsWrap MT70 TXTC">
						<div class="mmRow">
							<div class="mmCol6">
								<a href="javascript:;" class="mmBtns navy outline FWB" onclick="fn_move();">����ϱ�</a>
							</div>
							<div class="mmCol6">
								<% If rsub_seq_no <> "" Then %>
								<a href="javascript:;" class="mmBtns navy FWB" onclick="fn_resume_update();">�����ϱ�</a>
								<% Else %>
									<% If rtype = "C" Then %>
									<a href="javascript:;" class="mmBtns navy FWB" onclick="fn_resume_save2();">�����ϱ�</a>
									<% Else %>
									<a href="javascript:;" class="mmBtns navy FWB" onclick="fn_resume_save_imsi();">�����ϱ�</a>
									<% End If %>
								<% End If %>
							</div>
						</div>
					</div>

				</div>
			</div>
		</div>
		<!-- �̷¼���ϼ�������:S -->
	</div>
</div>
<!-- //container -->
