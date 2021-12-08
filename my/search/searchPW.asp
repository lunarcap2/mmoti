<!--#include virtual = "/common/common.asp"-->
<!--#include virtual = "/include/header/header.asp"-->

</head>

<body>

	<!-- header -->
	<div  id="header">
		<div class="header-wrap detail">
			<div class="detail_box">
				<a href="/">이전</a>
				<p>비밀번호 재설정</p>
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
					<input type="hidden" id="hd_kind" value="1">
					<input type="hidden" id="hd_idx" value="">
					<input type="hidden" id="userIP" value="<%=Request.ServerVariables("REMOTE_ADDR")%>">
					<input type="hidden" id="site_short_name" value="<%=site_short_name%>">

					<div id="memberPer" class="memberInfo per">
						<h4>
							회원정보 입력
							<span>본인 정보 확인 후 인증방법에 따라 초기화된 비밀번호를 전송해 드립니다.</span>
						</h4>

						<div class="tb_area">
							<table class="tb">
								<colgroup>
									<col style="width:8.5rem"/>
									<col />
								</colgroup>
								<tbody>
									<tr>
										<th class="req">아이디</th>
										<td>
											<div class="inp">
												<input type="text" id="user_id" class="txt placehd" name="user_id" placeholder="아이디 (5~12자 영문, 숫자 입력)" autocomplete="off">
												<p class="txt" id="id_box"></p>
											</div>
										</td>
									</tr>
									<tr>
										<th class="req">이름</th>
										<td>
											<div class="inp">
												<input type="text" id="user_nm" class="txt placehd" name="user_nm" placeholder="이름 (실명입력)">
												<p class="txt"></p>
											</div>
										</td>
									</tr>
								</tbody>
							</table>
						</div>


						<div class="certiTab">
							<label class="radiobox on" for="perCertiWay1">
								<input type="radio" id="perCertiWay1" class="rdi" name="perCertiWay" onclick="memberTabFnc(this,'#certiInfo1.per','#certiInfo2.per');return false;" checked=""><span>휴대폰으로 인증받기</span>
							</label>
							<label class="radiobox off" for="perCertiWay2">
								<input type="radio" id="perCertiWay2" class="rdi" name="perCertiWay" onclick="memberTabFnc(this,'#certiInfo2.per','#certiInfo1.per');return false;"><span>이메일로 인증받기</span>
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
													<th class="req">휴대폰 번호</th>
													<td>
														<div class="inp btn2">
															<div class="sec">
																<input type="text" id="hp_num" class="txt placehd" name="hp_num" placeholder="휴대폰 번호">
																<span class="num" id="hp_count">(00:00)</span>
																<button type="button" class="btn" id="aMobile" onclick="fnAuthSms();">인증번호 전송</button>
																<p class="txt"></p>
															</div>

															<div class="sec">
																<input type="text" id="mobileAuthNumber" class="txt placehd" name="mobileAuthNumber" placeholder="인증번호">
																<button type="button" class="btn" onclick="fnAuth();">인증확인</button>
																<p class="txt" id="alertBox_sms"></p>
															</div>
														</div>
													</td>
												</tr>
											</tbody>
										</table>
									</div>
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
													<th class="req">이메일</th>
													<td>
														<div class="inp btn2">
															<div class="sec">
															<input type="text" id="email" class="txt placehd" name="email" placeholder="이메일">
															<button type="button" class="btn" id="aEmail" onclick="fnAuthemail();">인증번호 전송</button>
															<p class="txt"></p>
															</div>
															<div class="sec">
															<input type="text" id="emailAuthNumber" class="txt placehd" name="emailAuthNumber" placeholder="인증번호">
															<button type="button" class="btn" onclick="fnAuth();">인증확인</button>
															<p class="txt" id="alertBox_email"></p>
															</div>
														</div>
													</td>
												</tr>
											</tbody>
										</table>
									</div>
								</div><!-- .tabInfo -->
							</div>

							<script type="text/javascript">
									function memberTabFnc(obj, obj1, obj2) {//탭메뉴
										var _this = $(obj);
										var _tab = _this.parent('li')
										var _index = _tab.index()
										var _areaN = $(obj1)
										var _area = $(obj2)
										_tab.addClass('on').siblings("li").removeClass("on")
										_areaN.css("display","block");
										_area.css("display","none");
									}//탭메뉴
							</script>
						</div>

						<div class="btnWrap">
							<a href="#addInfoPer" class="btn typeSky" onclick="onSubmit_PW('USER');">비밀번호 재설정</a>
						</div><!-- .btnWrap -->

						<div id="searchPW_rtn" class="sch_area" style="display:none;">
							<h4>비밀번호 재설정</h4>	
							
							<div class="tb_area">
								<table class="tb">
									<colgroup>
										<col style="width:13rem"/>
										<col />
									</colgroup>
									<tbody>
										<tr>
											<th class="req">새로운 비밀번호</th>
											<td>
												<input type="password" id="new_pw1" class="txt placehd" name="new_pw1" placeholder="새로운 비밀번호 입력">
											</td>
										</tr>
										<tr>
											<th class="req">새로운 비밀번호 확인</th>
											<td>
												<input type="password" id="new_pw2" class="txt placehd" name="new_pw2" placeholder="새로운 비밀번호 입력 확인">
											</td>
										</tr>
									</tbody>
								</table>
							</div>
							<div class="btnWrap">
								<a href="javascript:;" class="btn typeSky" onclick="PW_Modify('USER');">비밀번호 저장</a>
								<a href="/my/login.asp" class="btn typeSky">취소하기</a>
							</div><!-- .btnWrap -->

							<p class="sch_ment">영문, 숫자, 특수문자를 포함한 8~32자, 연속된 문자(a,b,c / 1,2,3) 사용 불가</p>
						</div>

						<div class="customCenter">
							<dl>
								<dd><%=site_name%> 운영사무국</dd>
								<dd class="tel">
									<span>TEL) <strong class="num"><%=site_callback_phone%></strong></span>
									<span>FAX) 02-2006-9594</span>
								</dd><!-- .tel -->
								<dd class="time">
									<em>상담운영시간 :</em> 평일 10시~18시 까지 (주말, 공휴일 휴무)
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


<!-- 하단 -->
<!--#include virtual = "/include/footer.asp"-->
<!-- 하단 -->

</body>
</html>