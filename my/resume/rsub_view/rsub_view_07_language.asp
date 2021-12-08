<!-- container -->
<div id="contents" class="sub_page">
	<div class="contents">
		<!-- �̷¼���ϼ�������:S -->
		<div class="mmResumeWrap">
			<!-- if ��»���:S -->
			<% If isArray(arrLanguageUse) Or isArray(arrLanguageExam) Then %>
			<div class="carrList MT40">				
				<div class="innerWrap">
					<% If isArray(arrLanguageUse) Then %>
					<div class="mmTit borderBottom"> ȸȭ �ɷ� </div>
					<div class="mmLstArea tp3">
						<div class="mmlstUl lastBorder">
							<!-- ��»��� forEach : S-->
							<% For i=0 To UBound(arrLanguageUse,2)
								Dim lan_idx, lan_kinds, lan_ability
								lan_idx		= arrLanguageUse(0,i)
								use_lan		= getLanguageCode(arrLanguageUse(1,i))
								use_ability	= arrLanguageUse(2,i)

								Select Case use_ability
									Case "1" : use_ability = "��"
									Case "2" : use_ability = "��"
									Case "3" : use_ability = "��"
								End Select
							%>
							<div class="mmLstTp paddingRight">
								<div class="txts">
									<a href="javascript:;" onclick="fn_detail('','1','<%=lan_idx%>');">
										<div class="tt mmColorBlue FWB inline MR10"><%=use_lan%></div>
										<div class="mmLbsWrap inline">
											<span class="mmLbs blue2"><%=use_ability%></span>
										</div>
									</a>

									<div class="right">
										<a href="#;" class="mmIcoDelBtns" onclick="fn_del('1','<%=lan_idx%>','<%=rsubGubun%>');" title="����"></a>
									</div>
								</div>
							</div>
							<% Next %>
							<!-- ��»��� forEach : E-->
						</div>
					</div>
					<% End If %>

					<% If isArray(arrLanguageExam) Then %>
					<div class="mmTit borderBottom MT60"> ���� ���� </div>
					<div class="mmLstArea tp3">
						<div class="mmlstUl">
							<!-- ��»��� forEach : S-->
							<%
							If isArray(arrLanguageExam) Then
								For i=0 To UBound(arrLanguageExam,2)
									Dim exam_idx, exam_lan, exam_kinds, exam_ability, exam_ability_gb, exam_dt
									exam_idx		= arrLanguageExam(0,i)
									exam_lan		= getLanguageCode(arrLanguageExam(1,i))
									exam_kinds		= getLanguageExamCodeNm(arrLanguageExam(2,i))
									exam_ability	= arrLanguageExam(3,i)
									exam_ability_gb	= arrLanguageExam(6,i)
									exam_dt			= arrLanguageExam(4,i) & "�� " & arrLanguageExam(5,i) & "��"

									Select Case exam_ability_gb
										Case "1" : exam_ability_gb = "��"
										Case "2" : exam_ability_gb = "��"
									End Select
							%>
							<div class="mmLstTp paddingRight">
								<div class="txts">
									<a href="javascript:;" onclick="fn_detail('','2','<%=exam_idx%>');">
										<div class="tt mmColorBlue FWB"><%=exam_lan%></div>
										<div class="st MT15 mmColorGray">
											<span class="mmColorBlack FWB"><%=exam_kinds%></span> <span class="ln"><%=exam_ability&exam_ability_gb%></span> <span class="ln"><%=exam_dt%></span>
										</div>
									</a>

									<div class="right">
										<a href="#;" class="mmIcoDelBtns" onclick="fn_del('2','<%=exam_idx%>','<%=rsubGubun%>');" title="����"></a>
									</div>
								</div>
							</div>
							<%
								Next
							End If
							%>
							<!-- ��»��� forEach : E-->
						</div>
					</div>
					<% End If %>
				</div>
			</div>
			<div class="mmBtnsWrap TXTC MT40">
				<a href="javascript:;" class="mmBtns navy FWB" onclick="fn_move('1','');"><small class="MR10">+</small>���� �ɷ� �߰�</a>
			</div>
			<!-- if ��»���:E -->
			<!-- else ��»��� :S -->
			<% Else %>
			<div class="mmResumeNoResult MT40">
				<div class="innerWrap">
					<div class="mmTit">���� �ɷ�</div>
					<div class="noResultBox MT20">
						<div class="inner">
							<div class="txts">�ۼ��� ���� �ɷ��� �����ϴ�.<br>����� �ּ���.</div>
							<div class="mmBtnsWrap MT30">
								<a href="javascript:;" class="mmBtns blue2 FWB" onclick="fn_move('1','');"><small class="MR10">+</small>���� �ɷ� �߰�</a>
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