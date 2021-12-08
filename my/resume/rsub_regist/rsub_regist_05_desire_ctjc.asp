<script type="text/javascript" src="https://job3.career.co.kr/js/cat_jc.js"></script>
<script type="text/javascript" src="https://job3.career.co.kr/js/cat_ct.js"></script>
<script type="text/javascript" src="/js/resume_jc.js"></script>
<script type="text/javascript" src="/js/resume_ct.js"></script>
<script type="text/javascript">
	// �������� ��������
	function fn_save_ctjc() {
		fn_save_jc();
		fn_save_ct();
	}
</script>

<div class="contents" style="padding-bottom: 0;">
	<!-- �̷¼���ϼ�������:S -->
	<div class="mmResumeWrap">
		<div class="resumCreateWrap">
			<div class="mmScrArea">
				<div class="mmTabs">
					<ul class="lst">
						<li class="tp fnTabsli active"><a href="#" class="txt" onclick="fn_append_jc();">����(����)</a></li>
						<li class="tp fnTabsli"><a href="#" class="txt" onclick="fn_append_ct();">���(����)</a></li>						
						<li class="tp fnTabsli "><a href="#" class="txt">Ű����</a></li>
					</ul>
				</div>
				<!-- ����(����): S -->
				<div class="fnTabsDiv active">
					<div class="mmScrRow">
						<div class="mmScrCol6">
							<!--1������-->
							<ul id="col_ul_jc1" class="mmScrLst">
							</ul>
						</div>
						<div class="mmScrCol6">
							<!--2������-->
							<ul id="col_ul_jc2" class="mmScrLst">
							</ul>
						</div>
					</div>
				</div>
				<!-- ����(����): E -->
				<!-- ���(����): S -->
				<div class="fnTabsDiv">
					<div class="mmScrRow">
						<div class="mmScrCol6">
							<!--1������-->
							<ul id="col_ul_ct1" class="mmScrLst">
							</ul>
						</div>
						<div class="mmScrCol6">
							<!--2������-->
							<ul id="col_ul_ct2" class="mmScrLst">
							</ul>
						</div>
					</div>
				</div>
				<!-- ���(����): E -->
				<!-- Ű����˻� :S -->
				<div class="fnTabsDiv">
					<div class="innerWrap MB80">
						<!--3������-->
						<div id="col_ul_jc3">
						<%
						If isArray(jc_code_all) Then
							For i=0 To UBound(jc_code_all)
						%>
						<script>
							fn_jc3_set('<%=jc_code_all(i)%>','<%=getJobtype(jc_code_all(i))%>');
						</script>
						<%
							Next 
						End If
						%>
						</div>

						<!--3������-->
						<div id="col_ul_ct3">
						<%
						If isArray(ct_code_all) Then
							For i=0 To UBound(ct_code_all)
						%>
						<script>
							fn_ct3_set('<%=ct_code_all(i)%>','<%=getJobtype(ct_code_all(i))%>');
						</script>
						<%
							Next 
						End If
						%>
						</div>
					</div>
				</div>
				<!-- Ű����˻� :E -->
				<div class="mmHr"></div>
				<div class="mmScrBottom">
					<div class="innerWrap">
						<div class="mmBreadCom ">
							<div class="tp ">
								<span class="lb">����</span>
								<div id="btm_category_jc" class="txts">
									<%
									If isArray(jc_code_all) Then
										For i=0 To UBound(jc_code_all)
									%>
									<div class="tt">
										<span><%=getJobtype(jc_code_all(i))%></span>
										<button class="clBtn" name="category_out_jc2" value="<%=jc_code_all(i)%>" onclick="fn_jckey2_del('<%=jc_code_all(i)%>')" title="����"></button>
										<span class="mmColorBlue2">></span>
										<span name="span_set_jc3">
											<%
											If isArray(arrJcKwd) Then
												For ii=0 To UBound(arrJcKwd, 2)
													If jc_code_all(i) = Left(arrJcKwd(0, ii), 4) Then
											%>
											<div class="tt">
												<span class="mgbInner"><%=arrJcKwd(1, ii)%></span>
												<button class="clBtn" name="category_out_jc3" value="<%=arrJcKwd(0, ii)%>" onclick="fn_jckey3_del('<%=arrJcKwd(0, ii)%>')" title="����"></button>
											</div>
											<%
													End If
												Next
											End If
											%>
										</span>
									</div>
									<%
										Next
									End If
									%>
								</div>
							</div>

							<div class="tp ">
								<span class="lb">���</span>
								<div id="btm_category_ct" class="txts">
									<%
									If isArray(ct_code_all) Then
										For i=0 To UBound(ct_code_all)
									%>
									<div class="tt">
										<span><%=getJobtype(ct_code_all(i))%></span>
										<button class="clBtn" name="category_out_ct2" value="<%=ct_code_all(i)%>" onclick="fn_ctkey2_del('<%=ct_code_all(i)%>')" title="����"></button>
										<span class="mmColorBlue2">></span>
										<span name="span_set_ct3">
											<%
											If isArray(arrCtKwd) Then
												For ii=0 To UBound(arrCtKwd, 2)
													If ct_code_all(i) = Left(arrCtKwd(0, ii), 4) Then
											%>
											<div class="tt">
												<span class="mgbInner"><%=arrCtKwd(1, ii)%></span>
												<button class="clBtn" name="category_out_ct3" value="<%=arrCtKwd(0, ii)%>" onclick="fn_ctkey3_del('<%=arrCtKwd(0, ii)%>')" title="����"></button>
											</div>
											<%
													End If
												Next
											End If
											%>
										</span>
									</div>
									<%
										Next
									End If
									%>
								</div>
							</div>
						</div>
						<div class="mmBtnsWrap TXTC MT35">
							<a href="javascript:;" class="mmBtns navy bold" onclick="fn_hope(''); fn_save_ctjc();"><small class="MR10">+</small>Ű���� ���ÿϷ�</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- �̷¼���ϼ�������:S -->
</div>