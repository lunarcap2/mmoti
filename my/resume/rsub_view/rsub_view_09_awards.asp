<!-- container -->
<div id="contents" class="sub_page">
	<div class="contents">
		<!-- �̷¼���ϼ�������:S -->
		<div class="mmResumeWrap">
			<!-- if ���󳻿�:S -->
			<% If isArray(arrPrize) Then %>
			<div class="carrList MT40">
				<div class="innerWrap">
					<div class="mmTit borderBottom"> ���󳻿� </div>
					<div class="mmLstArea tp3">
						<div class="mmlstUl">
							<!-- ���󳻿� forEach : S-->
							<%
							For i=0 To UBound(arrPrize,2)
								Dim awa_idx, awa_nm, awa_agency, awa_dt
								awa_idx		= arrPrize(0,i)
								awa_nm		= arrPrize(2,i)
								awa_agency	= arrPrize(1,i)
								awa_dt		= arrPrize(3,i) & "�� " & arrPrize(4,i) & "��"
							%>
							<div class="mmLstTp paddingRight">
								<div class="txts">
									<a href="javascript:;" onclick="fn_detail('','','<%=awa_idx%>');">
										<div class="tt FWB lg mmColorBlue"><%=awa_nm%></div>
										<div class="st mmColorGray MT15">
											<span class="mmColorBlack FWB"><%=awa_agency%></span>
											<span class="ln mmColorGray"><%=awa_dt%></span>
										</div>
									</a>

									<div class="right">
										<a href="#;" class="mmIcoDelBtns" onclick="fn_del('','<%=awa_idx%>','<%=rsubGubun%>');" title="����"></a>
									</div>
								</div>
							</div>
							<% Next %>
							<!-- ���󳻿� forEach : E-->
						</div>
					</div>
				</div>
			</div>
			<div class="mmBtnsWrap TXTC MT40">
				<a href="javascript:;" class="mmBtns navy FWB" onclick="fn_move('1','');"><small class="MR10">+</small>���󳻿� �߰�</a>
			</div>
			<!-- if ��»���:E -->
			<!-- else ��»��� :S -->
			<% Else %>
			<div class="mmResumeNoResult MT40">
				<div class="innerWrap">
					<div class="mmTit">���󳻿�</div>
					<div class="noResultBox MT20">
						<div class="inner">
							<div class="txts">�ۼ��� ���󳻿��� �����ϴ�.<br>����� �ּ���.</div>
							<div class="mmBtnsWrap MT30">
								<a href="javascript:;" class="mmBtns blue2 FWB" onclick="fn_move('1','');"><small class="MR10">+</small>���󳻿� �߰�</a>
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