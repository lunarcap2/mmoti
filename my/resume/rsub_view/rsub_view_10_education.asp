<!-- container -->
<div id="contents" class="sub_page">
	<div class="contents">
		<!-- �̷¼���ϼ�������:S -->
		<div class="mmResumeWrap">
			<!-- if �����̼� ����:S -->
			<% If isArray(arrAcademy) Then %>
			<div class="carrList MT40">
				<div class="innerWrap">
					<div class="mmTit borderBottom"> �����̼� ���� </div>
					<div class="mmLstArea tp3">
						<div class="mmlstUl">
							<!-- �����̼� ���� forEach : S-->
							<%
							For i=0 To Ubound(arrAcademy,2)
								Dim edu_idx, edu_nm, edu_agency, edu_sYY, edu_sMM, edu_eYY, edu_eMM
								edu_idx		= arrAcademy(0,i)
								edu_nm		= arrAcademy(6,i)
								edu_agency	= arrAcademy(1,i)
								edu_sYY		= arrAcademy(2,i)
								edu_sMM		= arrAcademy(3,i)
								edu_eYY		= arrAcademy(4,i)
								edu_eMM		= arrAcademy(5,i)
							%>
							<div class="mmLstTp paddingRight">
								<div class="txts">
									<a href="javascript:;" onclick="fn_detail('','','<%=edu_idx%>');">
										<div class="tt FWB lg mmColorBlue"><%=edu_nm%></div>
										<div class="st mmColorGray MT15">
											<span class="mmColorBlack FWB"><%=edu_agency%></span>
											<span class="ln mmColorGray"><%=edu_sYY%>�� <%=edu_sMM%>��~<%=edu_eYY%>�� <%=edu_eMM%>��</span>
										</div>
									</a>

									<div class="right">
										<a href="#;" class="mmIcoDelBtns" onclick="fn_del('','<%=edu_idx%>','<%=rsubGubun%>');" title="����"></a>
									</div>
								</div>
							</div>
							<% Next %>
							<!-- �����̼� ���� forEach : E-->
						</div>
					</div>
				</div>
			</div>
			<div class="mmBtnsWrap TXTC MT40">
				<a href="javascript:;" class="mmBtns navy FWB" onclick="fn_move('1','');"><small class="MR10">+</small>�����̼� �߰�</a>
			</div>
			<!-- if �����̼� ����:E -->
			<!-- else �����̼� ���� :S -->
			<% Else %>
			<div class="mmResumeNoResult MT40">
				<div class="innerWrap">
					<div class="mmTit">�����̼� ����</div>
					<div class="noResultBox MT20">
						<div class="inner">
							<div class="txts">�ۼ��� �����̼� ������ �����ϴ�.<br>����� �ּ���.</div>
							<div class="mmBtnsWrap MT30">
								<a href="javascript:;" class="mmBtns blue2 FWB" onclick="fn_move('1','');"><small class="MR10">+</small>�����̼� ���� �߰�</a>
							</div>
						</div>
					</div>
				</div>
			</div>
			<% End If %>
			<!-- else �����̼� ���� :E -->


		</div>
		<!-- �̷¼���ϼ�������:S -->
	</div>
</div>
<!-- //container -->