<!-- container -->
<script>
	$(document).ready(function () {
		$('.fnDialogSchSelectButton').click(function () {
			$('[data-layerpop="fnDialogSchSelect"]').cmmLocLaypop({
				parentAddClass: 'dialogSchSelect',
			});
		});
	});
</script>

<div id="contents" class="sub_page">
	<div class="contents">
		<!-- �̷¼���ϼ�������:S -->
		<div class="mmResumeWrap">
			<!-- if �з»���:S -->
			<% If isArray(arrSchool) Then %>
			<div class="carrList borderNone">
				<div class="innerWrap">
					<!-- �з»��� forEach : S-->
					<%
					For i=0 To UBound(arrSchool,2)
						Dim sch_idx, sch_nm, sch_sYY, sch_sMM, sch_eYY, sch_eMM, sch_kind_nm, sch_etype, sch_etype_nm, sch_major
						sch_etype_nm = ""

						sch_idx		= arrSchool(0,i)
						sch_kind	= arrSchool(2,i)
						sch_nm		= arrSchool(3,i)
						sch_sYY		= arrSchool(7,i)
						sch_sMM		= arrSchool(8,i)
						sch_eYY		= arrSchool(10,i)
						sch_eMM		= arrSchool(11,i)
						sch_etype	= arrSchool(12,i)
						sch_major	= arrSchool(6,i)

						Select Case sch_etype
							Case "3" : sch_etype_nm = "����"
							Case "4" : sch_etype_nm = "����"
							Case "5" : sch_etype_nm = "����"
							Case "7" : sch_etype_nm = "����(��)"
							Case "8" : sch_etype_nm = "����"
						End Select

						If sch_kind = "3" Then
							sch_kind_nm = "����б�"
						ElseIf sch_kind = "4" Or sch_kind = "5" Then
							sch_kind_nm = "����(��)"
							sch_kind	= "4"
						ElseIf sch_kind = "6" Then
							sch_kind_nm = "���п�"
						End If

					%>
					<div class="fnSchollSortParse" data-params="<%=sch_kind%>">
						<div class="mmTit borderBottom MT40 <"><%=sch_kind_nm%></div>
						<div class="mmLstArea tp3">
							<div class="mmlstUl">
								<div class="mmLstTp">
									<div class="txts">
										<a href="javascript:;" onclick="fn_detail('<%=sch_kind%>','','<%=sch_idx%>');">
											<div class="tt mmColorBlue lg FWB inline"><%=sch_nm%></div>
											<div class="mmLbsWrap inline">
												<span class="mmLbs">
													<% If sch_kind <> "3" Then %>
													<%=sch_major%> /
													<% End If %>

													<%=sch_etype_nm%>
													</span>
											</div>
											<div class="st MT15 mmColorGray">
												<% If sch_nm <> "���԰������" Then %>
												���� : <%=sch_sYY%>�� <%=sch_sMM%>��<span class="ln"></span>
												���� : <%=sch_eYY%>�� <%=sch_eMM%>��
												<% Else %>
												�հ� : <%=sch_eYY%>�� <%=sch_eMM%>��
												<% End If %>
											</div>
										</a>

										<div class="right">
											<!--<a href="#;" class="mmIcoDelBtns" onclick="$(this).closest('.fnSchollSortParse').remove();" title="����"></a>-->
											<a href="#;" class="mmIcoDelBtns" onclick="fn_del('','<%=sch_idx%>','<%=rsubGubun%>');" title="����"></a>
										</div>
									</div>
								</div>
							</div>
							<div class="mmHr"></div>
						</div>
					</div>
					<% Next %>
					<!-- �з»��� forEach : E-->
				</div>
			</div>
			<div class="mmBtnsWrap TXTC MT40">
				<a href="#" class="mmBtns navy FWB fnDialogSchSelectButton"><small class="MR10">+</small>�з»��� �߰�</a>
			</div>
			<!-- if �з»���:E -->
			<!-- else �з»��� :S -->
			<% Else %>
			<div class="mmResumeNoResult MT40">
				<div class="innerWrap">
					<div class="mmTit">�з»���</div>
					<div class="noResultBox MT20">
						<div class="inner">
							<div class="txts">�ۼ��� �з»����� �����ϴ�.<br>����� �ּ���.</div>
							<div class="mmBtnsWrap MT30">
								<a href="#" class="mmBtns blue2 FWB fnDialogSchSelectButton"><small class="MR10">+</small>�з� �߰��ϱ�</a>
							</div>
						</div>
					</div>
				</div>
			</div>
			<% End If %>
			<!-- else ��»��� :E -->

			<!-- �б����� �˾� :S -->
			<!-- �˾� : S -->
			<div class="cmm_layerpop cmmLocLaypop" data-layerpop="fnDialogSchSelect">
				<div class="dialogSchSelectInner">
					<a href="javascript:;" class="layClosebtn MT30" title="�˾��ݱ�"></a>
					<div class="schSelArea MT55">
						<div class="mmRow allPadding">
							<div class="mmCol6">
								<a href="#;" class="bx" onclick="fn_move('1','6');">���п�</a>
							</div>
							<div class="mmCol6">
								<a href="#;" class="bx" onclick="fn_move('1','5');">����(4��)</a>
							</div>
							<div class="mmCol6">
								<a href="#;" class="bx" onclick="fn_move('1','4');">����(2,3��)</a>
							</div>
							<div class="mmCol6">
								<a href="#;" class="bx" onclick="fn_move('1','3');">����б�</a>
							</div>
						</div>
					</div>
					<div class="mmCmmLst indent indent15 TXTL MT70">
						<div class="cmmtp mmColorRed">*��κ��� �����ںе��� ����б������Է��� �մϴ�.</div>
					</div>
				</div>
			</div>
			<!-- �˾� : E -->
			<!-- �б����� �˾� :E -->


		</div>
		<!-- �̷¼���ϼ�������:S -->
	</div>
</div>
<!-- //container -->
