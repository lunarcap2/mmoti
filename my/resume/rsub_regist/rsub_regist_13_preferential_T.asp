<%
'arrPersonal		= arrData(0)(14)'����/���
'arrMilitary		= arrData(0)(15)'����
'arrEmpSupport		= arrData(0)(16)'��������ݴ��

Dim patriot_flag, protect_flag, handicap_flag, handicap_grd, handicap_grd_nm, emp_support_flag
Dim military_yn, military_nm, kind_class_nm, military_kind, military_class
Dim military_sdate, military_syear, military_smonth, military_edate, military_eyear, military_emonth, military_end

If isArray(arrPersonal) Then
	patriot_flag = arrPersonal(0, 0)	'����
	protect_flag = arrPersonal(5, 0)	'�����ȣ���
	handicap_flag = arrPersonal(1, 0)	'���
	handicap_grd = arrPersonal(2, 0)	'��ֵ��
End If

If isArray(arrEmpSupport) Then 
	emp_support_flag = arrEmpSupport(0, 0) '���������
End If

If isArray(arrMilitary) Then
	military_yn		= arrMilitary(0, 0)
	military_syear	= arrMilitary(3, 0)
	military_smonth	= arrMilitary(4, 0)
	military_eyear	= arrMilitary(5, 0)
	military_emonth	= arrMilitary(6, 0)
	military_kind	= arrMilitary(1, 0)
	military_class	= arrMilitary(2, 0)
	military_end	= arrMilitary(10, 0)
End If

If isDate(military_syear & "-" & military_smonth) Then military_sdate = military_syear & "." & military_smonth
If isDate(military_eyear & "-" & military_emonth) Then military_edate = military_eyear & "." & military_emonth
%>

<script type="text/javascript">
	$(document).ready(function () {
		var patriot_flag, protect_flag, handicap_flag, emp_support_flag, military_yn, military_kind, military_class
		patriot_flag		= "<%=patriot_flag%>";
		protect_flag		= "<%=protect_flag%>";
		handicap_flag		= "<%=handicap_flag%>";
		handicap_grd		= '<%=handicap_grd%>';
		emp_support_flag	= "<%=emp_support_flag%>";
		military_yn			= "<%=military_yn%>";
		military_kind		= "<%=military_kind%>";
		military_class		= "<%=military_class%>";

		if (patriot_flag == "1") {
			$("#patriot_flag").click();
		}
		if (protect_flag == "1") {
			$("#protect_flag").click();
		}
		if (emp_support_flag == "1") {
			$("#emp_support_flag").click();
		}
		
		$('#sel_handicap_grd option').each(function(i) {
			if(this.value == handicap_grd) {
				$('#sel_handicap_grd').initSelectbox(i);
			}
		});

		if (military_yn != "") {
			$('[name="CSN"]').each(function() {
				if (this.value == military_yn) {
					this.checked = true; //checked ó��
				}
			});
			
			if(military_yn == '2' || military_yn == '3' || military_yn == '5') {
				if(military_yn == '2' || military_yn == '3') {
					$('#div_military_end').show();
				}

				$('[name="div_military"]').attr('style','display:none;');
			}
			else {
				$('#sel_military_kind').initSelectbox(military_kind);
				$('#sel_military_class').initSelectbox(military_class);

				$('[name="div_military"]').attr('style','display:block;');
			}
		}
	});

	function fn_military_s_div(obj) {
		if (obj.value.length == 7) {
			$(obj).parents('.cloneTargetDivision').find('#military_syear').val(obj.value.substr(0, 4));
			$(obj).parents('.cloneTargetDivision').find('#military_smonth').val(obj.value.substr(5, 2));
		} else {
			$(obj).parents('.cloneTargetDivision').find('#military_syear').val('');
			$(obj).parents('.cloneTargetDivision').find('#military_smonth').val('');
		}
	}
	function fn_military_e_div(obj) {
		if (obj.value.length == 7) {
			$(obj).parents('.cloneTargetDivision').find('#military_eyear').val(obj.value.substr(0, 4));
			$(obj).parents('.cloneTargetDivision').find('#military_emonth').val(obj.value.substr(5, 2));
		} else {
			$(obj).parents('.cloneTargetDivision').find('#military_eyear').val('');
			$(obj).parents('.cloneTargetDivision').find('#military_emonth').val('');
		}
	}

	function fn_military(obj) {
		var _val = $(obj).val();

		$('#handicap_flag').val('1');

		if(_val == '2' || _val == '3' || _val == '5') {
			if(_val == '2' || _val == '3') {
				$('#div_military_end').show();
			}
			else {
				$('[name="military_end"]').val('');
				$('#div_military_end').hide();
			}
			
			$('#military_kind').val('');
			$('#military_class').val('');
			$('#military_syear').val('');
			$('#military_smonth').val('');
			$('#military_eyear').val('');
			$('#military_emonth').val('');

			$('#sel_military_kind').initSelectbox();
			$('#sel_military_class').initSelectbox();
			$('[name="military_sdate"]').val('');
			$('[name="military_edate"]').val('');

			$('[name="div_military"]').attr('style','display:none;');
		}
		else {
			$('[name="military_end"]').val('');
			$('#div_military_end').hide();

			$('[name="div_military"]').attr('style','display:block;');
		}
	}

	function fn_handicap(obj) {
		if($(obj).val() != '') {
			$('#handicap_flag').val('1');
		}
		else {
			$('#handicap_flag').val('');
		}
	}
</script>

<!-- container -->
<div id="contents" class="sub_page">
	<div class="contents">
		<!-- �̷¼���ϼ�������:S -->
		<div class="mmResumeWrap">
			<div class="resumCreateWrap MT30">
				<div class="innerWrap">

					<div class="mmResumeVarTable borderNone">
						<div class="cloneTargetDivision MT30 fnCloneTargetDivision">
							<div class="mmRow border colaps">
								<!-- ��� -->
								<input type="hidden" id="handicap_grd" name="handicap_grd" value="<%=handicap_grd%>" />

								<input type="hidden" id="handicap_flag" name="handicap_flag" value="" />

								<!-- �������� -->
								<input type="hidden" id="military_yn" name="military_yn" value="<%=military_yn%>" />
								<input type="hidden" id="military_syear" name="military_syear" value="<%=military_syear%>" />
								<input type="hidden" id="military_smonth" name="military_smonth" value="<%=military_smonth%>" />
								<input type="hidden" id="military_eyear" name="military_eyear" value="<%=military_eyear%>" />
								<input type="hidden" id="military_emonth" name="military_emonth" value="<%=military_emonth%>" />
								<input type="hidden" id="military_work" name="military_work" value="" />
								
								<input type="hidden" id="military_kind" name="military_kind" value="<%=military_kind%>" />
								<input type="hidden" id="military_class" name="military_class" value="<%=military_class%>" />

								<div class="mmCol12 absRight absRight150">
									<div class="mmCmmInput">
										<div class="ip">
											<input type="text" value="" name="" placeholder="���� ���" />
										</div>
									</div>
									<div class="absTarget TXTR">
										<div class="mmCmmInput radiochk sm inline">
											<input type="checkbox" id="patriot_flag" name="patriot_flag" value="1">
											<label for="patriot_flag" class="lb FWB">���</label>
										</div>
									</div>
								</div>
								<div class="mmCol12 absRight absRight150">
									<div class="mmCmmInput">
										<div class="ip">
											<input type="text" value="" name="" placeholder="�����ȣ ���" />
										</div>
									</div>
									<div class="absTarget TXTR">
										<div class="mmCmmInput radiochk sm inline">
											<input type="checkbox" id="protect_flag" name="protect_flag" value="1">
											<label for="protect_flag" class="lb FWB">���</label>
										</div>
									</div>
								</div>
								<div class="mmCol12 absRight absRight150">
									<div class="mmCmmInput">
										<div class="ip">
											<input type="text" value="" name="" placeholder="��������� ���" />
										</div>
									</div>
									<div class="absTarget TXTR">
										<div class="mmCmmInput radiochk sm inline">
											<input type="checkbox" id="emp_support_flag" name="emp_support_flag" value="1">
											<label for="emp_support_flag" class="lb FWB">���</label>
										</div>
									</div>
								</div>
							</div>
							
							<div class="mmTit MT50">���</div>
							<div class="mmRow border colaps MT20">
								<div class="mmCol12">
									<select class="fnCustomSelect" id="sel_handicap_grd" onchange="fn_sel_value_set(this, 'handicap_grd'); fn_handicap(this);">
										<option value="">��ֵ�� ����</option>
										<option value="1">1��</option>
										<option value="2">2��</option>
										<option value="3">3��</option>
										<option value="4">4��</option>
										<option value="5">5��</option>
										<option value="6">6��</option>
									</select>
								</div>
							</div>
							
								
							<div class="mmTit borderBottom MT50">��������</div>
							<div class="mmGridBoxWrap isCheckRadio MT20">
								<div class="mmRow allPadding">
									<%
									For ii=1 To 5
										Dim mili_chk_txt
										Select Case ii
											Case 1 mili_chk_txt = "����"
											Case 2 mili_chk_txt = "����"
											Case 3 mili_chk_txt = "����"
											Case 4 mili_chk_txt = "������"
											Case 5 mili_chk_txt = "�ش����"
										End Select
									%>
									<div class="mmCol4">
										<input type="radio" id="CS<%=ii%>" value="<%=ii%>" name="CSN" onclick="fn_sel_value_set(this, 'military_yn'); fn_military(this);">
										<label for="CS<%=ii%>" class="mmGridBox">
											<span class="mgbInner"><%=mili_chk_txt%></span>
										</label>
									</div>
									<% Next %>
									<div class="mmCmmInput" id="div_military_end" style="display:none;">
										<div class="ip">
											<input type="text" value="<%=military_end%>" name="military_end" placeholder="�����Է�" />
										</div>
									</div>
								</div>
							</div>
							<div class="mmRow border colaps MT30" name="div_military" style="display:none;">
								<div class="mmCol6">
									<select class="fnCustomSelect" id="sel_military_kind" onchange="fn_sel_value_set(this, 'military_kind');">
										<option value="">����</option>
										<% Call putCodeToSelectOption("getMilitaryKind", 1, 99, "") %>
									</select>
								</div>
								<div class="mmCol6">
									<select class="fnCustomSelect" id="sel_military_class" onchange="fn_sel_value_set(this, 'military_class');">
										<option value="">���</option>
										<% Call putCodeToSelectOption("getMilitaryClass", 1, 19, "") %>
									</select>
								</div>
								<div class="mmCol6" style="border-left: none;">
									<div class="mmCmmInput date fnDatePicker">
										<div class="ip">
											<input type="text" value="<%=military_sdate%>" name="military_sdate" placeholder="���۳��" onkeyup="numCheck(this, 'int'); changeDateType(this); fn_military_s_div(this);" onblur="chkDateType(this)" maxlength="6" />
										</div>
									</div>
								</div>
								<div class="mmCol6">
									<div class="mmCmmInput date fnDatePicker">
										<div class="ip">
											<input type="text" value="<%=military_edate%>" name="military_edate" placeholder="������" onkeyup="numCheck(this, 'int'); changeDateType(this); fn_military_e_div(this);" onblur="chkDateType(this)" maxlength="6" />
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="mmCmmLst indent indent15 MT30">
							<div class="cmmtp mmFontSize21 FWB mmColorBlack">�� �ΰ����� ������ ���� ���� �ȳ�</div>
							<div class="cmmtp mmFontSize18 mmColorBlack">�� �������̿���� : ����ȸ�� �ǻ翡 ���� ����Ȱ��</div>
							<div class="cmmtp mmFontSize18 mmColorBlack">�� ���� �׸� : ��������</div>
							<div class="cmmtp mmFontSize18 mmColorBlack">�� ���� �� �̿�Ⱓ : ���� �̿�� ����</div>
							<div class="cmmtp mmFontSize18 mmColorBlack">�� �ΰ������� �����׸��̸�, �Է����� �ʴ��� �̷¼� �ۼ��� ������ ���� �ʽ��ϴ�.</div>
						</div>


						<div class="mmBtnsWrap MT80 TXTC">
							<div class="mmRow">
								<div class="mmCol6">
									<a href="javascript:;" class="mmBtns navy outline FWB" onclick="fn_move();">����ϱ�</a>
								</div>
								<div class="mmCol6">
									<% If rtype = "C" Then %>
									<a href="javascript:;" class="mmBtns navy FWB" onclick="fn_resume_save2();">�����ϱ�</a>
									<% Else %>
									<a href="javascript:;" class="mmBtns navy FWB" onclick="fn_resume_save_imsi();">�����ϱ�</a>
									<% End If %>
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