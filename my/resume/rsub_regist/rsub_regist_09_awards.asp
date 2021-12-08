<%
If isArray(arrDetail) Then
	Dim awa_nm, awa_agency, awa_sYY, awa_sMM
	awa_nm		= arrDetail(3,0)
	awa_agency	= arrDetail(2,0)
	awa_sYY		= arrDetail(4,0)
	awa_sMM		= arrDetail(5,0)
End If

Dim awa_DT
If isDate(awa_sYY & "-" & awa_sMM) Then awa_DT = awa_sYY & "." & awa_sMM
%>

<script type="text/javascript">
	function fn_awards_div(obj) {
		if (obj.value.length == 7) {
			$(obj).parents('.mmResumeVarTable').find('#prize_year').val(obj.value.substr(0, 4));
			$(obj).parents('.mmResumeVarTable').find('#prize_month').val(obj.value.substr(5, 2));
		} else {
			$(obj).parents('.mmResumeVarTable').find('#prize_year').val('');
			$(obj).parents('.mmResumeVarTable').find('#prize_month').val('');
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
								<input type="hidden" id="prize_year" name="prize_year" value="<%=awa_sYY%>" />
								<input type="hidden" id="prize_month" name="prize_month" value="<%=awa_sMM%>" />

								<div class="mmCol12 ">
									<div class="mmCmmInput">
										<div class="ip">
											<input type="text" value="<%=awa_nm%>" name="prize_name" placeholder="������� �Է��� �ּ���." />
										</div>
									</div>
								</div>
								<div class="mmCol12 ">
									<div class="mmCmmInput">
										<div class="ip">
											<input type="text" value="<%=awa_agency%>" name="prize_org_name" placeholder="��������� ������ �ּ���." />
										</div>
									</div>
								</div>
								<div class="mmCol12">
									<div class="mmCmmInput date fnDatePicker">
										<div class="ip">
											<input type="text" value="<%=awa_DT%>" name="prize_date" placeholder="������" onkeyup="numCheck(this, 'int'); changeDateType(this); fn_awards_div(this);" onblur="chkDateType(this)" maxlength="6" />
										</div>
									</div>
								</div>
							</div>
						</div>


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
					</div><!-- mmResumeVarTable -->

				</div>
			</div>
		</div>
		<!-- �̷¼���ϼ�������:S -->
	</div>
</div>
<!-- //container -->