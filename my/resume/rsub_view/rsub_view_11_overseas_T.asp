<!-- container -->
<div id="contents" class="sub_page">
	<div class="contents">
		<!-- �̷¼���ϼ�������:S -->
		<div class="mmResumeWrap">
			<!-- if �ڰ��� ����:S -->
			<% If isArray(arrAbroad) Then %>
			<div class="carrList MT40">
				<div class="innerWrap">
					<div class="mmTit borderBottom"> �ؿܰ��� </div>
					<div class="mmLstArea tp3">
						<div class="mmlstUl">
							<!-- �ڰ��� ���� forEach : S-->
							<%
							For i=0 To UBound(arrAbroad,2)
								Dim ove_idx, ove_nm, ove_sYY, ove_sMM, ove_eYY, ove_eMM, ove_con
								ove_idx	= arrAbroad(0,i)
								ove_nm	= getNationCode(arrAbroad(1,i))
								ove_sYY	= arrAbroad(3,i)
								ove_sMM	= arrAbroad(4,i)
								ove_eYY	= arrAbroad(5,i)
								ove_eMM	= arrAbroad(6,i)
								ove_con	= arrAbroad(7,i)
							%>
							<div class="mmLstTp paddingRight">
								<div class="txts">
									<a href="javascript:;" onclick="fn_detail('','','<%=ove_idx%>');">
										<div class="tt FWB lg mmColorBlue"><%=ove_nm%><span class="ln mmColorBlack"><%=ove_sYY%>�� <%=ove_sMM%>��~<%=ove_eYY%>�� <%=ove_eMM%>��</span></div>
										<div class="st mmColorGray MT15"><%=ove_con%></div>
									</a>

									<div class="right">
										<a href="#;" class="mmIcoDelBtns" onclick="fn_del('','<%=ove_idx%>','<%=rsubGubun%>');" title="����"></a>
									</div>
								</div>
							</div>
							<% Next %>
							<!-- �ڰ��� ���� forEach : E-->
						</div>
					</div>
				</div>
			</div>
			<div class="mmBtnsWrap TXTC MT40">
				<a href="javascript:;" class="mmBtns navy FWB" onclick="fn_move('1','')"><small class="MR10">+</small>�ؿܰ��� �߰�</a>
			</div>
			<!-- if ��»���:E -->
			<!-- else ��»��� :S -->
			<% Else %>
			<div class="mmResumeNoResult MT40">
				<div class="innerWrap">
					<div class="mmTit">�ؿܰ���</div>
					<div class="noResultBox MT20">
						<div class="inner">
							<div class="txts">�ۼ��� �ؿܰ����� �����ϴ�.<br>����� �ּ���.</div>
							<div class="mmBtnsWrap MT30">
								<a href="javascript:;" class="mmBtns blue2 FWB" onclick="fn_move('1','')"><small class="MR10">+</small>�ؿܰ��� �߰�</a>
							</div>
						</div>
					</div>
				</div>
			</div>
			<% End If %>
			<!-- else ��»��� :E -->


		</div>
		<!-- �̷¼���ϼ�������:S -->
	</div>
</div>
<!-- //container -->