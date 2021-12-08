<%
If isArray(arrDetail) Then
	Dim  high_nm, high_etype, high_sYY, high_sMM, high_eYY, high_eMM, high_gde
	high_nm		= arrDetail(3,0)
	high_etype	= arrDetail(16,0)
	high_sYY	= arrDetail(6,0)
	high_sMM	= arrDetail(12,0)
	high_eYY	= arrDetail(7,0)
	high_eMM	= arrDetail(13,0)
	high_gde	= arrDetail(22,0)
End If

Dim high_sDT, high_eDT, high_gde_DT
If high_gde <> "" Then 
	If isDate(high_eYY & "-" & high_eMM) Then high_gde_DT = high_eYY & "." & high_eMM
Else
	If isDate(high_sYY & "-" & high_sMM) Then high_sDT = high_sYY & "." & high_sMM
	If isDate(high_eYY & "-" & high_eMM) Then high_eDT = high_eYY & "." & high_eMM
End If
%>

<script type="text/javascript">
	$(document).ready(function () {
		var _high_etype = '<%=high_etype%>';
		var _high_gde	= '<%=high_gde%>';
		
		//��������
		$('[name="select_univ_etype"] option').each(function(i) {
			if(this.value == _high_etype) {
				$('[name="select_univ_etype"]').initSelectbox(i);
			}
		});

		//���԰������ üũ�ڽ�
		if(_high_gde == '1') {
			$('#C1').attr('checked',true);

			//�б��� �־���
			$('#univ_name').attr('readonly',true);

			//display ó��
			$('[name="univ_sdate"]').parent().parent().parent().attr('style','display:none;');
			$('[name="univ_edate"]').parent().parent().parent().attr('style','display:none;');
			$('[name="select_univ_etype"]').parent().parent().attr('style','display:none;');

			$('[name="gde_edate"]').parent().parent().parent().attr('style','display:block;');
		}
	});

	function fn_school_s_div(obj) {
		if (obj.value.length == 7) {
			$(obj).parents('.cloneTargetDivision').find('#univ_syear').val(obj.value.substr(0, 4));
			$(obj).parents('.cloneTargetDivision').find('#univ_smonth').val(obj.value.substr(5, 2));
		} else {
			$(obj).parents('.cloneTargetDivision').find('#univ_syear').val('');
			$(obj).parents('.cloneTargetDivision').find('#univ_smonth').val('');
		}
	}

	function fn_school_e_div(obj) {
		if (obj.value.length == 7) {
			$(obj).parents('.cloneTargetDivision').find('#univ_eyear').val(obj.value.substr(0, 4));
			$(obj).parents('.cloneTargetDivision').find('#univ_emonth').val(obj.value.substr(5, 2));
		} else {
			$(obj).parents('.cloneTargetDivision').find('#univ_eyear').val('');
			$(obj).parents('.cloneTargetDivision').find('#univ_emonth').val('');
		}
	}

	function fn_chk(obj) {
		var bool = $(obj).is(":checked");

		//���԰������ üũ��
		if(bool) {
			//�ʱ�ȭ
			$(obj).parents('.cloneTargetDivision').find('#univ_syear').val('');
			$(obj).parents('.cloneTargetDivision').find('#univ_smonth').val('');
			$(obj).parents('.cloneTargetDivision').find('#univ_eyear').val('');
			$(obj).parents('.cloneTargetDivision').find('#univ_emonth').val('');
			$(obj).parents('.cloneTargetDivision').find('[name="univ_sdate"]').val('');
			$(obj).parents('.cloneTargetDivision').find('[name="univ_edate"]').val('');
			$(obj).parents('.cloneTargetDivision').find('[name="univ_etype"]').val('');
			$(obj).parents('.cloneTargetDivision').find('[name="select_univ_etype"]').initSelectbox();

			//�� ����
			$(obj).parents('.cloneTargetDivision').find('#univ_name').val('���԰������').attr('readonly',true);
			$(obj).parents('.cloneTargetDivision').find('#gde').val($(obj).val());

			//display ó��
			$(obj).parents('.cloneTargetDivision').find('[name="univ_sdate"]').parent().parent().parent().attr('style','display:none;');
			$(obj).parents('.cloneTargetDivision').find('[name="univ_edate"]').parent().parent().parent().attr('style','display:none;');
			$(obj).parents('.cloneTargetDivision').find('[name="select_univ_etype"]').parent().parent().attr('style','display:none;');

			$(obj).parents('.cloneTargetDivision').find('[name="gde_edate"]').parent().parent().parent().attr('style','display:block;');
		}
		else {
			//�ʱ�ȭ
			$(obj).parents('.cloneTargetDivision').find('#univ_name').val('').attr('readonly',false);
			$(obj).parents('.cloneTargetDivision').find('#univ_eyear').val('');
			$(obj).parents('.cloneTargetDivision').find('#univ_emonth').val('');
			$(obj).parents('.cloneTargetDivision').find('[name="gde_edate"]').val('');
			$(obj).parents('.cloneTargetDivision').find('#gde').val('');

			//display ó��
			$(obj).parents('.cloneTargetDivision').find('[name="univ_sdate"]').parent().parent().parent().attr('style','display:inline-block;');
			$(obj).parents('.cloneTargetDivision').find('[name="univ_edate"]').parent().parent().parent().attr('style','display:inline-block;');
			$(obj).parents('.cloneTargetDivision').find('[name="select_univ_etype"]').parent().parent().attr('style','display:block;');

			$(obj).parents('.cloneTargetDivision').find('[name="gde_edate"]').parent().parent().parent().attr('style','display:none;');
		}
	}
</script>

<!-- container -->
<div id="contents" class="sub_page">
	<div class="contents">
		<!-- �̷¼���ϼ�������:S -->
		<div class="mmResumeWrap">
			<div class="resumCreateWrap">
				<div class="innerWrap">

					<div class="mmResumeVarTable borderNone" name="div_school_high">
						<div class="cloneTargetDivision MT30 fnCloneTargetDivision">
							<div class="mmRow border colaps">
								<input type="hidden" id="final_scholar" name="final_scholar" value="">

								<input type="hidden" id="univ_kind" name="univ_kind" value="3">
								<input type="hidden" id="sc_type" name="sc_type" value="2">
								<input type="hidden" id="univ_depth" name="univ_depth" value=""> <!-- �迭�ڵ�(X) -->
								<input type="hidden" id="univ_pointavg" name="univ_pointavg" value=""> <!-- ��������(X) -->
								<input type="hidden" id="univ_code" name="univ_code" value=""> <!-- �����ڵ�(X) -->
								<input type="hidden" id="univ_major_code" name="univ_major_code" value=""> <!-- �����ڵ�(X) -->
								<input type="hidden" id="univ_area" name="univ_area" value=""> <!-- �����ڵ�(X) -->
								<input type="hidden" id="univ_stype" name="univ_stype" value="1"> <!-- �����ڵ�(X) -->
								<input type="hidden" id="univ1_grd" name="univ1_grd" value=""> <!-- ���������ڵ�(X) -->

								<input type="hidden" id="univ_syear" name="univ_syear" value="<%=high_sYY%>">
								<input type="hidden" id="univ_smonth" name="univ_smonth" value="<%=high_sMM%>">
								<input type="hidden" id="univ_eyear" name="univ_eyear" value="<%=high_eYY%>">
								<input type="hidden" id="univ_emonth" name="univ_emonth" value="<%=high_eMM%>">
								<input type="hidden" id="univ_etype" name="univ_etype" value="<%=high_etype%>"> <!-- �������� -->
								<input type="hidden" id="univ_minor" name="univ_minor" value=""> <!-- ������ -->
								<input type="hidden" id="univ_mdepth" name="univ_mdepth" value=""> <!-- �������迭�ڵ�(X) -->
								<input type="hidden" id="univ_minor_code" name="univ_minor_code" value=""> <!-- �������ڵ�(X) -->

								<input type="hidden" id="univ_major" name="univ_major" value="">
								<input type="hidden" id="univ_research" name="univ_research" value="">
								<input type="hidden" id="univ_point" name="univ_point" value="">
								<input type="hidden" id="univ_minornm" name="univ_minornm" value="">

								<input type="hidden" id="gde" name="gde" value="<%=high_gde%>"> <!---���԰������-->

								<div class="mmCol12 ">
									<div class="mmCmmInput">
										<div class="ip">
											<input type="text" value="<%=high_nm%>" id="univ_name" name="univ_name" placeholder="�б����� �Է��� �ּ���." onkeyup="fn_kwSearchItem(this, 'high')" autocomplete="off" />
										</div>
										<!-- �˻���� â : S -->
										<!-- ���� Ŭ���� .mmCmmInput �ȿ� �ڽ����� �־���� -->
										<div class="result_box" id="id_result_box">
										</div>
										<!-- �˻���� â : E -->
									</div>
								</div>
								<div class="mmCol12">
									<select class="fnCustomSelect" name="select_univ_etype" onchange="fn_sel_value_set(this, 'univ_etype');">
										<option value="">��������</option>
										<option value="3">����</option>
										<option value="4">����</option>
										<option value="5">����</option>
										<option value="7">����(��)</option>
										<option value="8">����</option>
									</select>
								</div>
								<div class="mmCol6">
									<div class="mmCmmInput date fnDatePicker">
										<div class="ip">
											<input type="text" value="<%=high_sDT%>" name="univ_sdate" placeholder="���г��" onkeyup="numCheck(this, 'int'); changeDateType(this); fn_school_s_div(this);" onblur="chkDateType(this)" maxlength="6" />
										</div>
									</div>
								</div>
								<div class="mmCol6">
									<div class="mmCmmInput date fnDatePicker">
										<div class="ip">
											<input type="text" value="<%=high_eDT%>" name="univ_edate" placeholder="�������" onkeyup="numCheck(this, 'int'); changeDateType(this); fn_school_e_div(this);" onblur="chkDateType(this)" maxlength="6" />
										</div>
									</div>
								</div>
								<div class="mmCol12" style="display:none;">
									<div class="mmCmmInput date fnDatePicker">
										<div class="ip">
											<input type="text" value="<%=high_gde_DT%>" name="gde_edate" placeholder="�հݳ��" onkeyup="numCheck(this, 'int'); changeDateType(this); fn_school_e_div(this);" onblur="chkDateType(this)" maxlength="6" />
										</div>
									</div>
								</div>
							</div>
							<div class="MT30">
								<div class="mmCmmInput radiochk sm">
									<input type="checkbox" id="C1" value="1" onclick="fn_chk(this);"/>
									<label for="C1" class="lb FWB">���� �������</label>
								</div>
							</div>
							<!--
							<div class="mmBtnsWrap MT30 TXTC">
								<div class="mmRow">
									<div class="mmCol6">
										<a href="javascript:;" class="mmBtns blue2 FWB" onclick="fn_append({code:'<%=rsubGubun%>',gubun:'<%=schoolGubun%>' }, this);"><small class="MR10">+</small>�з� �߰��ϱ�</a>
									</div>
								</div>
							</div>
							-->
							<div class="mmHr MT35"></div>
						</div>
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
