<%
If isArray(arrDetail) Then
	Dim univ_nm, univ_etype, univ_sYY, univ_sMM, univ_eYY, univ_eMM, univ_major, univ_point, univ_pointavg, univ_research, univ_minornm, univ_minor, univ_grd
	univ_nm			= arrDetail(3,0)
	univ_etype		= arrDetail(16,0)
	univ_sYY		= arrDetail(6,0)
	univ_sMM		= arrDetail(12,0)
	univ_eYY		= arrDetail(7,0)
	univ_eMM		= arrDetail(13,0)
	univ_major		= arrDetail(5,0)
	univ_point		= arrDetail(8,0)
	univ_pointavg	= arrDetail(9,0)
	univ_research	= arrDetail(25,0)
	univ_minornm	= arrDetail(19,0)
	univ_minor		= arrDetail(18,0)
	univ_grd		= arrDetail(14,0)
End If

Dim univ_sDT, univ_eDT
If isDate(univ_sYY & "-" & univ_sMM) Then univ_sDT = univ_sYY & "." & univ_sMM
If isDate(univ_eYY & "-" & univ_eMM) Then univ_eDT = univ_eYY & "." & univ_eMM
%>

<script type="text/javascript">
	$(document).ready(function () {
		var _univ_etype		= '<%=univ_etype%>';
		var _univ_pointavg	= '<%=univ_pointavg%>';
		var _univ_grd		= '<%=univ_grd%>';
		var _univ_minor		= '<%=univ_minor%>';
		var _univ_minornm	= '<%=univ_minornm%>';
		
		//��������
		$('[name="select_univ_etype"] option').each(function(i) {
			if(this.value == _univ_etype) {
				$('[name="select_univ_etype"]').initSelectbox(i);
			}
		});

		//����
		$('[name="select_univ_pointavg"] option').each(function(i) {
			if(this.value == _univ_pointavg) {
				$('[name="select_univ_pointavg"]').initSelectbox(i);
			}
		});

		//����
		$('[name="select_univ1_grd"] option').each(function(i) {
			if(this.value == _univ_grd) {
				$('[name="select_univ1_grd"]').initSelectbox(i);
			}
		});

		//�߰�����
		if(_univ_minor != '' || _univ_minornm != '') {
			$('[name="div_univ_add_minor"]').attr('style', 'display:block;');
			$('[name="div_univ_add_minor"]').next().children().children().children().text('�߰����� ����');

			$('[name="select_univ_minor"] option').each(function(i) {
				if(this.value == _univ_minor) {
					$('[name="select_univ_minor"]').initSelectbox(i);
				}
			});
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

	//�߰����� �����ؼ�
	function fn_univ_minor(obj) {
		var bool = $('[name="div_univ_add_minor"]').is(':visible');

		if(bool) {
			$(obj).text('���� �߰�');
			$(obj).parents('.cloneTargetDivision').find('#univ_minornm').val('');
			$(obj).parents('.cloneTargetDivision').find('#univ_minor').val('');
			$(obj).parents('.cloneTargetDivision').find('[name="select_univ_minor"]').initSelectbox();

			$('[name="div_univ_add_minor"]').attr('style','display:none;');
		}
		else {
			$(obj).text('�߰����� ����');

			$('[name="div_univ_add_minor"]').attr('style','display:block;');
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

					<div class="mmResumeVarTable borderNone" name="div_school_univ">
						<div class="cloneTargetDivision MT30 fnCloneTargetDivision">
							<div class="mmRow border colaps">
								<input type="hidden" id="final_scholar" name="final_scholar" value="">

								<input type="hidden" id="univ_kind" name="univ_kind" value="<%=schoolGubun%>">
								<input type="hidden" id="sc_type" name="sc_type" value="2">
								<input type="hidden" id="univ_depth" name="univ_depth" value=""> <!-- �迭�ڵ�(X) -->
								<input type="hidden" id="univ_pointavg" name="univ_pointavg" value="<%=univ_pointavg%>"> <!-- ��������(X) -->
								<input type="hidden" id="univ_code" name="univ_code" value=""> <!-- �����ڵ�(X) -->
								<input type="hidden" id="univ_major_code" name="univ_major_code" value=""> <!-- �����ڵ�(X) -->
								<input type="hidden" id="univ_area" name="univ_area" value=""> <!-- �����ڵ�(X) -->
								<input type="hidden" id="univ_stype" name="univ_stype" value="1"> <!-- �����ڵ�(X) -->
								<input type="hidden" id="univ1_grd" name="univ1_grd" value="<%=univ_grd%>"> <!-- ���������ڵ�(X) -->

								<input type="hidden" id="univ_syear" name="univ_syear" value="<%=univ_sYY%>">
								<input type="hidden" id="univ_smonth" name="univ_smonth" value="<%=univ_sMM%>">
								<input type="hidden" id="univ_eyear" name="univ_eyear" value="<%=univ_eYY%>">
								<input type="hidden" id="univ_emonth" name="univ_emonth" value="<%=univ_eMM%>">
								<input type="hidden" id="univ_etype" name="univ_etype" value="<%=univ_etype%>"> <!-- �������� -->
								<input type="hidden" id="univ_minor" name="univ_minor" value="<%=univ_minor%>"> <!-- ������ -->
								<input type="hidden" id="univ_mdepth" name="univ_mdepth" value=""> <!-- �������迭�ڵ�(X) -->
								<input type="hidden" id="univ_minor_code" name="univ_minor_code" value=""> <!-- �������ڵ�(X) -->

								<input type="hidden" id="gde" name="gde" value=""> <!---���԰������-->

								<div class="mmCol12 ">
									<div class="mmCmmInput">
										<div class="ip">
											<input type="text" value="<%=univ_nm%>" id="univ_name" name="univ_name" placeholder="�б����� �Է��� �ּ���." onkeyup="fn_kwSearchItem(this, 'univ')" autocomplete="off" />
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
											<input type="text" value="<%=univ_sDT%>" name="univ_sdate" placeholder="���г��" onkeyup="numCheck(this, 'int'); changeDateType(this); fn_school_s_div(this);" onblur="chkDateType(this)" maxlength="6" />
										</div>
									</div>
								</div>
								<div class="mmCol6">
									<div class="mmCmmInput date fnDatePicker">
										<div class="ip">
											<input type="text" value="<%=univ_eDT%>" name="univ_edate" placeholder="�������" onkeyup="numCheck(this, 'int'); changeDateType(this); fn_school_e_div(this);" onblur="chkDateType(this)" maxlength="6" />
										</div>
									</div>
								</div>
							</div>

							<% If schoolGubun = "6" Then %>
							<div class="mmTit MT55">����</div>
							<div class="mmRow border colaps MT20">
								<div class="mmCol12">
									<select class="fnCustomSelect" name="select_univ1_grd" onchange="fn_sel_value_set(this, 'univ1_grd');">
										<option value="">��������</option>
										<option value="1">����</option>
										<option value="2">�ڻ�</option>
										<option value="3">���ڻ�</option>
									</select>
								</div>
							</div>
							<% End If %>

							<!-- ���� : S-->
							<div class="mmTit MT55">����</div>
							<div class="mmRow border colaps MT20">
								<!--
								<div class="mmCol12">
									<select class="fnCustomSelect">
										<option value="">������ ������ �ּ���. </option>
									</select>
								</div>-->
								<div class="mmCol12 ">
									<div class="mmCmmInput">
										<div class="ip">
											<input type="text" value="<%=univ_major%>" id="univ_major" name="univ_major" placeholder="������ �Է��� �ּ���." onkeyup="fn_kwSearchItem(this, 'major')" autocomplete="off" />
										</div>
										<!-- �˻���� â : S -->
										<!-- ���� Ŭ���� .mmCmmInput �ȿ� �ڽ����� �־���� -->
										<div class="result_box" id="id_result_box">
										</div>
										<!-- �˻���� â : E -->
									</div>
								</div>
							</div>
							<!-- ���� : E-->
							<!-- ���� : S-->
							<div class="mmTit MT55">����</div>
							<div class="mmRow border colaps MT20">
								<div class="mmCol8">
									<div class="mmCmmInput">
										<div class="ip">
											<input type="text" value="<%=univ_point%>" id="univ_point" name="univ_point" placeholder="������ �Է��� �ּ���." maxlength="4" />
										</div>
									</div>
								</div>
								<div class="mmCol4 ">
									<select class="fnCustomSelect" name="select_univ_pointavg" onchange="fn_sel_value_set(this, 'univ_pointavg');">
										<option value="">����</option>
										<option value="4.0">4.0</option>
										<option value="4.3">4.3</option>
										<option value="4.5">4.5</option>
										<option value="7.0">7.0</option>
										<option value="100">100</option>
									</select>
								</div>
							</div>
							<!-- ���� : E-->
							<!-- �����߰� : S-->
							<div name="div_univ_add_minor" style="display:none;">
								<div class="mmTit MT55">�߰�����</div>
								<div class="mmRow border colaps MT20">
									<div class="mmCol8">
										<div class="mmCmmInput">
											<div class="ip">
												<input type="text" value="<%=univ_minornm%>" id="univ_minornm" name="univ_minornm" placeholder="������ �Է��� �ּ���." onkeyup="fn_kwSearchItem(this, 'major')" autocomplete="off" />
											</div>
											<!-- �˻���� â : S -->
											<!-- ���� Ŭ���� .mmCmmInput �ȿ� �ڽ����� �־���� -->
											<div class="result_box" id="id_result_box">
											</div>
											<!-- �˻���� â : E -->
										</div>
									</div>
									<div class="mmCol4 ">
										<select class="fnCustomSelect" name="select_univ_minor" onchange="fn_sel_value_set(this, 'univ_minor');">
											<option value="">��������</option>
											<option value="��">������</option>
											<option value="����">��������</option>
										</select>
									</div>
								</div>
							</div>
							<!-- �����߰� : E-->
							<div class="mmBtnsWrap TXTC MT25">
								<div class="mmRow">
									<div class="mmCol6"><a href="javascript:;" class="mmBtns blue FWB" onclick="fn_univ_minor(this);"><small class="MR10">+</small>���� �߰�</a></div>
								</div>
							</div>


							<!-- �̼����� �� �������� : S-->
							<div class="mmTit MT65">�̼����� �� ��������</div>
							<div class="mmRow border colaps MT20">
								<div class="mmCol12">
									<div class="mmCmmInput">
										<div class="ip">
											<input type="text" value="<%=univ_research%>" id="univ_research" name="univ_research" placeholder="�̼����� �� ���������� �Է��� �ּ���." />
										</div>
									</div>
								</div>
							</div>
							<!-- �̼����� �� �������� : E-->
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
