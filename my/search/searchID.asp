<!--#include virtual = "/common/common.asp"-->
<!--#include virtual = "/include/header/header.asp"-->

</head>

<body>
	<!-- header -->
	<div  id="header">
		<div class="header-wrap detail">
			<div class="detail_box">
				<a href="/">����</a>
				<p>���̵� ã��</p>
			</div>
		</div>
	</div>
	<!-- //header -->
	
	<!-- container -->
	<div id="contents" class="sub_page">
		<div class="contents">
			<div class="signup_area">
				<div class="inputArea">
					<input type="hidden" id="emailAuthNumChk" value="0">
					<input type="hidden" id="mobileAuthNumChk" value="0">
					<input type="hidden" id="AuthChk" value="0">
					<input type="hidden" id="hd_kind" value="2">
					<input type="hidden" id="hd_idx" value="">
					<input type="hidden" id="userIP" value="<%=Request.ServerVariables("REMOTE_ADDR")%>">
					<input type="hidden" id="site_short_name" value="<%=site_short_name%>">

					<div id="memberPer" class="memberInfo per">
						<h4>ȸ������ �Է�<span>ȸ������ �� �Է��� ���� ������ ��Ȯ�� �Է��ϼ���.</span></h4>
						
						<div class="tb_area">
							<table class="tb">
								<colgroup>
									<col style="width:8.5rem"/>
									<col />
								</colgroup>
								<tbody>
									<tr>
										<th class="req">�̸�</th>
										<td>
											<div class="inp">
												<input type="text" id="user_nm" class="txt placehd" name="user_nm" placeholder="�̸� (�Ǹ��Է�)">
												<p class="txt"></p>
											</div>
										</td>
									</tr>
								</tbody>
							</table>
						</div>

						<div class="certiTab">
							<label class="radiobox on" for="perCertiWay1">
								<input type="radio" id="perCertiWay1" class="rdi" name="perCertiWay" onclick="memberTabFnc(this,'#certiInfo1.per','#certiInfo2.per');return false;" checked=""><span>�޴������� �����ޱ�</span>
							</label>
							<label class="radiobox off" for="perCertiWay2">
								<input type="radio" id="perCertiWay2" class="rdi" name="perCertiWay" onclick="memberTabFnc(this,'#certiInfo2.per','#certiInfo1.per');return false;"><span>�̸��Ϸ� �����ޱ�</span>
							</label>

							<div class="tabInfoArea">
								<div id="certiInfo1" class="tabInfo per">
									<div class="tb_area">
										<table class="tb">
											<colgroup>
												<col style="width:8.5rem"/>
												<col />
											</colgroup>
											<tbody>
												<tr>
													<th class="req">�޴��� ��ȣ</th>
													<td>
														<div class="inp btn2">
															<div class="sec">
																<input type="text" id="hp_num" class="txt placehd" name="hp_num" placeholder="�޴��� ��ȣ">
																<span class="num" id="hp_count">(00:00)</span>
																<button type="button" class="btn" id="aMobile" onclick="fnAuthSms();">������ȣ ����</button>
																<p class="txt"></p>
															</div>
															<div class="sec">
																<input type="text" id="mobileAuthNumber" class="txt placehd" name="mobileAuthNumber" placeholder="������ȣ">
																<button type="button" class="btn" onclick="fnAuth();">����Ȯ��</button>
																<p class="txt" id="alertBox_sms"></p>
															</div>
														</div>
													</td>
												</tr>
											</tbody>
										</table>
									</div><!-- .tb_area -->
								</div><!-- .tabInfo -->

								<div id="certiInfo2" class="tabInfo per">
									<div class="tb_area">
										<table class="tb">
											<colgroup>
												<col style="width:8.5rem"/>
												<col />
											</colgroup>
											<tbody>
												<tr>
													<th class="req">�̸���</th>
													<td>
														<div class="inp btn2">
															<div class="sec">
																<input type="text" id="email" class="txt placehd" name="email" placeholder="�̸���">
																<button type="button" class="btn" id="aEmail" onclick="fnAuthemail();">������ȣ ����</button>
																<p class="txt"></p>
															</div>
															<div class="sec">
																<input type="text" id="emailAuthNumber" class="txt placehd" name="emailAuthNumber" placeholder="������ȣ">
																<button type="button" class="btn" onclick="fnAuth();">����Ȯ��</button>
																<p class="txt" id="alertBox_email"></p>
															</div>
														</div>
													</td>
												</tr>
											</tbody>
										</table>
									</div><!-- .tb_area -->
								</div><!-- .tabInfo -->
							</div><!-- .tabInfoArea -->

							<script type="text/javascript">
									function memberTabFnc(obj, obj1, obj2) {//�Ǹ޴�
										var _this = $(obj);
										var _tab = _this.parent('li')
										var _index = _tab.index()
										var _areaN = $(obj1)
										var _area = $(obj2)
										_tab.addClass('on').siblings("li").removeClass("on")
										_areaN.css("display","block");
										_area.css("display","none");
									}//�Ǹ޴�
							</script>
						</div><!-- .certiTab -->

						<div class="btnWrap">
							<a href="#addInfoPer" class="btn typeSky" onclick="onSubmit_ID('USER');">���̵� ã��</a>
						</div><!-- .btnWrap -->

						<div id="searchID_rtn" class="sch_area" style="display:none;">
							<h4>���̵� ã�� ���</h4>								
					
							<div class="sch_id" id="compid_list">
							</div>

							<div class="btnWrap">
								<a href="/my/login.asp" class="btn typeSky">�α����ϱ�</a>
								<a href="/my/search/searchPW.asp" class="btn typeSky">��й�ȣã��</a>
							</div><!-- .btnWrap -->
						</div>

						<div class="customCenter">
							<dl>
								<dd><%=site_name%> ��繫��</dd>
								<dd class="tel">
									<span>TEL) <strong class="num"><%=site_callback_phone%></strong></span>
									<span>FAX) 02-2006-9594</span>
								</dd><!-- .tel -->
								<dd class="time">
									<em>����ð� :</em> ���� 10��~18�� ���� (�ָ�, ������ �޹�)
								</dd><!-- .time -->
								<dd class="email">
									<span>e-mail)</span> <a href="mailto:<%=site_helpdesk_mail%>"><%=site_helpdesk_mail%></a>
								</dd><!-- .email -->
							</dl>
						</div><!-- .customCenter -->
					</div>
				</div>
			</div><!-- signup_area-->


		</div><!-- contents -->
	</div><!-- contents -->
	<!-- //container -->

<!-- �ϴ� -->
<!--#include virtual = "/include/footer.asp"-->
<!-- �ϴ� -->

</body>
</html>