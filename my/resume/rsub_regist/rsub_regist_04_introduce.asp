<!-- container -->
<div id="contents" class="sub_page">
	<div class="contents">
		<!-- �̷¼���ϼ�������:S -->
		<div class="mmResumeWrap">
			<div class="resumCreateWrap">
				<div class="innerWrap">
					<div class="mmResumeVarTable borderNone" name="div_introduce">
						<%
						If isArray(arrNew_Essay) Then
							For i=0 To UBound(arrNew_Essay, 2)
								Dim ess_idx, ess_tit, ess_con
								ess_idx	= arrNew_Essay(0, i)
								ess_tit	= arrNew_Essay(4, i)
								ess_con	= arrNew_Essay(5, i)
						%>
						<div class="cloneTargetDivision MT30 fnCloneTargetDivision">
							<div class="mmRow border colaps">
								<input type="hidden" id="res_seq" name="res_seq" value="<%=ess_idx%>">
								<div class="mmCol12">
									<div class="mmCmmInput">
										<div class="ip">
											<input type="text" value="<%=ess_tit%>" name="res_quotation" placeholder="�׸��� �Է��� �ּ���" />
										</div>
									</div>
								</div>
							</div>
							<div class="mmRow colaps MT15">
								<div class="mmCol12">
									<div class="mmCmmInput">
										<div class="ip">
											<textarea value="" id="res_content" name="res_content" placeholder="�ش� ������ �Է��� �ּ���." style="height: 24rem;"><%=ess_con%></textarea>
										</div>
									</div>
								</div>
							</div>
							<div class="mmBtnsWrap MT30 TXTC">
								<div class="mmRow">
									<div class="mmCol6">
										<a href="#;" class="mmBtns blue2 FWB" onclick="fn_append('<%=rsubGubun%>', this);"><small class="MR10">+</small>�߰��ϱ�</a>
									</div>
									<div class="mmCol6">
										<a href="#;" class="mmBtns blue2 outline FWB" onclick="fn_del('', <%=ess_idx%>, '<%=rsubGubun%>');">�����ϱ�</a>
									</div>
								</div>
							</div>
							<div class="mmHr MT35"></div>
						</div>
						<%
							Next
						Else
						%>
						<div class="cloneTargetDivision MT30 fnCloneTargetDivision">
							<div class="mmRow border colaps">
								<input type="hidden" id="res_seq" name="res_seq" value="0">
								<div class="mmCol12">
									<div class="mmCmmInput">
										<div class="ip">
											<input type="text" value="" name="res_quotation" placeholder="�׸��� �Է��� �ּ���" />
										</div>
									</div>
								</div>
							</div>
							<div class="mmRow colaps MT15">
								<div class="mmCol12">
									<div class="mmCmmInput">
										<div class="ip">
											<textarea value="" id="res_content" name="res_content" placeholder="�ش� ������ �Է��� �ּ���." style="height: 24rem;"></textarea>
										</div>
									</div>
								</div>
							</div>
							
							<div class="mmBtnsWrap MT30 TXTC">
								<div class="mmRow">
									<div class="mmCol6">
										<a href="#;" class="mmBtns blue2 FWB" onclick="fn_append('<%=rsubGubun%>', this);"><small class="MR10">+</small>�߰��ϱ�</a>
									</div>
									<div class="mmCol6">
										<a href="#;" class="mmBtns blue2 outline FWB" onclick="fn_remove(this);">�����ϱ�</a>
									</div>
								</div>
							</div>
							<div class="mmHr MT35"></div>							
						</div>
						<% End If %>
					</div><!-- mmResumeVarTable -->

					<div class="mmBtnsWrap MT95">
						<div class="mmRow">
							<div class="mmCol6">
								<a href="javascript:;" class="mmBtns navy outline FWB" onclick="fn_move('<%=rsubGubun%>');">����ϱ�</a>
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


				</div>
			</div>
		</div>
		<!-- �̷¼���ϼ�������:S -->
	</div>
</div>
<!-- //container -->
