<!-- container -->
<div id="contents" class="sub_page">
	<div class="contents">
		<!-- �̷¼���ϼ�������:S -->
		<div class="mmResumeWrap">
			<!-- if �ڰ��� ����:S -->
			<% If isArray(arrLicense) Then %>
			<div class="carrList MT40">
				<div class="innerWrap">
					<div class="mmTit borderBottom"> �ڰ��� ���� </div>
					<div class="mmLstArea tp3">
						<div class="mmlstUl">
							<!-- �ڰ��� ���� forEach : S-->
							<%
							For i=0 To UBound(arrLicense,2)
								Dim lic_idx, lic_nm, lic_agency, lic_DT
								lic_idx		= arrLicense(0,i)
								lic_nm		= arrLicense(1,i)
								lic_agency	= arrLicense(2,i)
								lic_DT		= arrLicense(3,i) & "�� " & arrLicense(4,i) & "��"
							%>
							<div class="mmLstTp paddingRight">
								<div class="txts">
									<a href="javascript:;" onclick="fn_detail('','','<%=lic_idx%>');">
										<div class="tt FWB lg">
											<%=lic_nm%>
											<span class="ln mmColorBlue"><%=lic_agency%></span>
											
										</div>
										<div class="st mmColorGray MT15">
											<span class="mmColorBlack FWB">���</span>
											<%=lic_DT%>
										</div>
									</a>

									<div class="right">
										<a href="#;" class="mmIcoDelBtns" onclick="fn_del('','<%=lic_idx%>','<%=rsubGubun%>');" title="����"></a>
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
				<a href="javascript:;" class="mmBtns navy FWB" onclick="fn_move('1','');"><small class="MR10">+</small>�ڰ��� �߰�</a>
			</div>
			<!-- if ��»���:E -->
			<!-- else ��»��� :S -->
			<% Else %>
			<div class="mmResumeNoResult MT40">
				<div class="innerWrap">
					<div class="mmTit">�ڰ��� ����</div>
					<div class="noResultBox MT20">
						<div class="inner">
							<div class="txts">�ۼ��� �ڰ��� ������ �����ϴ�.<br>����� �ּ���.</div>
							<div class="mmBtnsWrap MT30">
								<a href="javascript:;" class="mmBtns blue2 FWB" onclick="fn_move('1','');"><small class="MR10">+</small>�ڰ��� ���� �߰�</a>
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