<!-- container -->
<div id="contents" class="sub_page">
	<div class="contents">
		<!-- �̷¼���ϼ�������:S -->
		<div class="mmResumeWrap">
			<!-- if ��»���:S -->
			<% If isArray(arrCareer) Then %>
			<div class="carrList MT40">
				<div class="innerWrap">
					<div class="mmTit borderBottom">
						�ٹ�ȸ��
						<% If total_career <> "�Էµ� ������ �����ϴ�." Then %>
						<span class="mmsTit sm right mmColorActiun">��ü ��³�� (<%=total_career%>)</span>
						<% End If %>
					</div>
					<div class="mmLstArea tp3">
						<div class="mmlstUl">
							<!-- ��»��� forEach : S-->
							<%
							For i=0 To UBound(arrCareer,2)
								Dim car_idx, car_nm, car_sYY, car_sMM, car_eYY, car_eMM, car_ing
								car_idx	= arrCareer(0,i)
								car_nm	= arrCareer(1,i)
								car_sYY	= arrCareer(6,i)
								car_sMM	= arrCareer(7,i)
								car_eYY	= arrCareer(8,i)
								car_eMM	= arrCareer(9,i)
								car_ing	= arrCareer(5,i)

								If car_ing = "1" Then
									Dim car_sDT, car_eDT, car_term

									car_sDT = car_sYY & "-" & car_sMM
									car_eDT = car_eYY & "-" & car_eMM

									car_term = career_month(DateDiff("m", car_sDT, car_eDT))
								End If
							%>
							<div class="mmLstTp paddingRight">
								<div class="txts">
									<a href="javascript:;" onclick="fn_detail('','','<%=car_idx%>');">
										<div class="tt mmColorBlue FWB"><%=car_nm%></div>
										<div class="st MT15">
											<span class="mmColorBlack FWB">�Ի�</span> <%=car_sYY%>�� <%=car_sMM%>�� ~
											<% If car_ing = "1" Then %>
											<span class="mmColorBlack FWB">���</span> <%=car_eYY%>�� <%=car_eMM%>��
											<span class="mmColorBlue2">(<%=car_term%>)</span>
											<% End If %>
										</div>
									</a>

									<div class="right">
										<a href="#;" class="mmIcoDelBtns" onclick="fn_del('','<%=car_idx%>','<%=rsubGubun%>');" title="����"></a>
									</div>
								</div>
							</div>
							<% Next %>
							<!-- ��»��� forEach : E-->
						</div>
					</div>
				</div>
			</div>
			<div class="mmBtnsWrap TXTC MT40">
				<a href="javascript:;" class="mmBtns navy FWB" onclick="fn_move('1', '');"><small class="MR10">+</small>��� �߰��ϱ�</a>
			</div>
			<!-- if ��»���:E -->
			<!-- else ��»��� :S -->
			<% Else %>
			<div class="mmResumeNoResult MT40">
				<div class="innerWrap">
					<div class="mmTit">��»���</div>
					<div class="noResultBox MT20">
						<div class="inner">
							<div class="txts">�ۼ��� ��»����� �����ϴ�.<br>����� �ּ���.</div>
							<div class="mmBtnsWrap MT30">
								<a href="javascript:;" class="mmBtns blue2 FWB" onclick="fn_move('1', '');"><small class="MR10">+</small>��� �߰��ϱ�</a>
							</div>
						</div>
					</div>
				</div>

				<div class="mmResumeNoResult MT40">
					<div class="innerWrap">
						<div class="noResultBox sm MT20">
							<div class="inner">
								<a href="javascript:;" class="mmBtns blue2 FWB" onclick="fn_move('2', '');">����</a>
								<!-- <div class="mmCmmInput radiochk">
									<input type="checkbox" id="C1" value="����" onclick="fn_move('2', '');" >
									<label for="C1" class="lb FWB">����</label>
								</div> -->
							</div>
						</div>
						<div class="mmCmmLst indent indent13 MT15">
							<div class="cmmtp mmColorRed">*������ �����Ͻø�, ����.���Ȱ������ �ٷ� �̵��մϴ�.</div>
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
