<%
%>

<!-- container -->
<div id="contents" class="sub_page">
	<div class="contents">
		<!-- �̷¼���ϼ�������:S -->
		<div class="mmResumeWrap">
			<!-- if ����.���Ȱ��:S -->
			<% If isArray(arrActivity) Then %>
			<div class="carrList MT40">
				<div class="innerWrap">
					<div class="mmTit borderBottom"> Ȱ������ </div>
					<div class="mmLstArea tp3">
						<div class="mmlstUl">
							<!-- ����.���Ȱ�� forEach : S-->
							<%
							For i=0 To UBound(arrActivity,2)
								Dim act_idx, act_nm, act_gb, act_sYY, act_sMM, act_eYY, act_eMM, act_sDT, act_eDT, act_totalMM
								act_totalMM = ""
								act_idx		= arrActivity(0,i)
								act_nm		= arrActivity(7,i)
								act_gb		= arrActivity(1,i)
								act_sYY		= arrActivity(3,i)
								act_sMM		= arrActivity(4,i)
								act_eYY		= arrActivity(5,i)
								act_eMM		= arrActivity(6,i)

								Select Case act_gb
									Case "1" : act_gb = "����"
									Case "2" : act_gb = "�Ƹ�����Ʈ"
									Case "3" : act_gb = "����Ȱ��"
									Case "4" : act_gb = "���Ƹ�"
									Case "5" : act_gb = "�ڿ�����"
									Case "6" : act_gb = "���Ȱ��"
									Case "7" : act_gb = "��ȸȰ��"
								End Select
								
								If Len(act_sMM) = 1 Then
									act_sMM = "0" & act_sMM
								End If

								If Len(act_eMM) = 1 Then
									act_eMM = "0" & act_eMM
								End If

								act_sDT = act_sYY & "-" & act_sMM
								act_eDT = act_eYY & "-" & act_eMM
								
								If act_sDT <> "-" Or act_eDT <> "-" Then
									act_sDT = act_sYY & "-" & act_sMM
									act_eDT = act_eYY & "-" & act_eMM

									act_totalMM = career_month(DateDiff("m", act_sDT, act_eDT))
								End If
							%>
							<div class="mmLstTp paddingRight">
								<div class="txts">
									<a href="javascript:;" onclick="fn_detail('','','<%=act_idx%>');">
										<div class="tt inline mmColorBlue FWB MR10">
											<%=act_nm%>
										</div>
										<div class="mmLbsWrap inline">
											<span class="mmLbs blue2"><%=act_gb%></span>
										</div>
									</a>
									<div class="right">
										<a href="#;" class="mmIcoDelBtns" onclick="fn_del('','<%=act_idx%>','<%=rsubGubun%>');" title="����"></a>
									</div>
									<% If act_totalMM <> "" Then %>
									<div class="st MT15">
										<span class="mmColorBlack FWB">
											<% If act_sDT <> "-" Then %>
											�Ի�</span> <%=act_sYY%>�� <%=act_sMM%>�� ~ 
											<% End If %>
											<% If act_eDT <> "-" Then %>
											<span class="mmColorBlack FWB">���</span> <%=act_eYY%>�� <%=act_eMM%>�� 
											<% End If %>
											<% If act_sDT <> "-" And act_eDT <> "-" Then %>
											<span class="mmColorBlue2">(<%=act_totalMM%>)</span>
											<% End If %>
									</div>
									<% End If %>
								</div>
							</div>
							<% Next %>
							<!-- ����.���Ȱ�� forEach : E-->
						</div>
					</div>
				</div>
			</div>
			<div class="mmBtnsWrap TXTC MT40">
				<a href="javascript:;" class="mmBtns navy FWB" onclick="fn_move('1','');"><small class="MR10">+</small>����.���Ȱ�� �߰�</a>
			</div>
			<!-- if ����.���Ȱ��:E -->
			<!-- else ����.���Ȱ�� :S -->
			<% Else %>
			<div class="mmResumeNoResult MT40">
				<div class="innerWrap">
					<div class="mmTit">Ȱ������</div>
					<div class="noResultBox MT20">
						<div class="inner">
							<div class="txts">�ۼ��� Ȱ�������� �����ϴ�.<br>����� �ּ���.</div>
							<div class="mmBtnsWrap MT30">
								<a href="javascript:;" class="mmBtns blue2 FWB" onclick="fn_move('1','');"><small class="MR10">+</small>����.���Ȱ�� �߰��ϱ�</a>
							</div>
						</div>
					</div>
				</div>
			</div>
			<% End If %>
			<!-- else ����.���Ȱ�� :E -->


		</div>
		<!-- �̷¼���ϼ�������:S -->
	</div>
</div>
<!-- //container -->