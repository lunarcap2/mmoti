<%
If isArray(arrDetail) Then
	Dim edu_nm, edu_agency, edu_sYY, edu_sMM, edu_eYY, edu_eMM
	edu_nm		= arrDetail(7,0)
	edu_agency	= arrDetail(2,0)
	edu_sYY		= arrDetail(3,0)
	edu_sMM		= arrDetail(4,0)
	edu_eYY		= arrDetail(5,0)
	edu_eMM		= arrDetail(6,0)
End If

Dim edu_sDT, edu_eDT
If isDate(edu_sYY & "-" & edu_sMM) Then edu_sDT = edu_sYY & "." & edu_sMM
If isDate(edu_eYY & "-" & edu_eMM) Then edu_eDT = edu_eYY & "." & edu_eMM
%>

<script type="text/javascript">
	function fn_education_s_div(obj) {
		if (obj.value.length == 7) {
			$(obj).parents('.cloneTargetDivision').find('#academy_syear').val(obj.value.substr(0, 4));
			$(obj).parents('.cloneTargetDivision').find('#academy_smonth').val(obj.value.substr(5, 2));
		} else {
			$(obj).parents('.cloneTargetDivision').find('#academy_syear').val('');
			$(obj).parents('.cloneTargetDivision').find('#academy_smonth').val('');
		}
	}
	function fn_education_e_div(obj) {
		if (obj.value.length == 7) {
			$(obj).parents('.cloneTargetDivision').find('#academy_eyear').val(obj.value.substr(0, 4));
			$(obj).parents('.cloneTargetDivision').find('#academy_emonth').val(obj.value.substr(5, 2));
		} else {
			$(obj).parents('.cloneTargetDivision').find('#academy_eyear').val('');
			$(obj).parents('.cloneTargetDivision').find('#academy_emonth').val('');
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

					<div class="mmResumeVarTable borderNone" name="div_education">
						<!-- Ŭ�п���:S -->
						<div class="cloneTargetDivision MT30 fnCloneTargetDivision">
							<div class="mmRow border colaps">
								<input type="hidden" id="academy_syear" name="academy_syear" value="<%=edu_sYY%>" />
								<input type="hidden" id="academy_smonth" name="academy_smonth" value="<%=edu_sMM%>" />
								<input type="hidden" id="academy_eyear" name="academy_eyear" value="<%=edu_eYY%>" />
								<input type="hidden" id="academy_emonth" name="academy_emonth" value="<%=edu_eMM%>" />

								<div class="mmCol12">
									<div class="mmCmmInput">
										<div class="ip">
											<input type="text" value="<%=edu_nm%>" name="academy_name" placeholder="�������� �Է��� �ּ���." />
										</div>
									</div>
								</div>
								<div class="mmCol12">
									<div class="mmCmmInput">
										<div class="ip">
											<input type="text" value="<%=edu_agency%>" name="academy_org_name" placeholder="��������� �Է��� �ּ���." />
										</div>
									</div>
								</div>
								<div class="mmCol6">
									<div class="mmCmmInput date fnDatePicker">
										<div class="ip">
											<input type="text" value="<%=edu_sDT%>" name="academy_sdate" placeholder="���۳��" onkeyup="numCheck(this, 'int'); changeDateType(this); fn_education_s_div(this);" onblur="chkDateType(this)" maxlength="6" />
										</div>
									</div>
								</div>
								<div class="mmCol6">
									<div class="mmCmmInput date fnDatePicker">
										<div class="ip">
											<input type="text" value="<%=edu_eDT%>" name="academy_edate" placeholder="������" onkeyup="numCheck(this, 'int'); changeDateType(this); fn_education_e_div(this);" onblur="chkDateType(this)" maxlength="6" />
										</div>
									</div>
								</div>
							</div>
							
							<% If rsub_seq_no = "" Then %>
							<div class="mmBtnsWrap MT30 TXTC">
								<div class="mmRow">
									<div class="mmCol7">
										<a href="javascript:;" class="mmBtns blue2 FWB" onclick="fn_append('<%=rsubGubun%>', this);"><small class="MR10">+</small>�����̼� �߰��ϱ�</a>
									</div>
								</div>
							</div>
							<% End If %>

							<div class="mmHr MT35"></div>
						</div>
						<!-- Ŭ�п���:E -->
					</div><!-- mmResumeVarTable -->
					<div class="mmBtnsWrap MT80 TXTC">
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
