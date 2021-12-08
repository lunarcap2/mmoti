<!--#include virtual = "/common/common.asp"-->
<!--#include virtual = "/include/header/header.asp"-->
<!--#include virtual = "/wwwconf/function/db/DBConnection.asp"-->
<!--#include virtual = "/inc/function/paging.asp"-->

<script type="text/javascript">
	$(document).ready(function () {
		fn_salary_area_show(1,100,'tbody1');
	});

	function fn_salary_area_show(_sRank, _eRank, _body) {
		$.ajax({
			type: 'POST'
			, url: 'ajax_sales_list.asp'
			, data: { sRank : _sRank, eRank : _eRank}
			, success: function (data) {
				$('#' + _body).html(data);
			}
			, error: function (XMLHttpRequest, textStatus, errorThrown) {
				alert(textStatus);
			}
		});
	}

	function fn_sel(obj) {
		var sRank, eRank

		if(obj.value == '1') {
			sRank = '1';
			eRank = '100';
		}
		else if(obj.value == '2') {
			sRank = '101';
			eRank = '200';
		}
		else if(obj.value == '3') {
			sRank = '201';
			eRank = '300';
		}
		else if(obj.value == '4') {
			sRank = '301';
			eRank = '400';
		}
		else if(obj.value == '5') {
			sRank = '401';
			eRank = '500';
		}

		fn_salary_area_show(sRank, eRank, 'tbody1');
	}

	//상세보기
	function FN_view(val) {
		$('#hdn_biz_code').val(val);
		$('#frm_view').attr('action', 'sales_view.asp');
		$('#frm_view').submit();
	}
</script>

</head>

<body>

<!-- 상단 -->
<!--#include virtual = "/include/gnb/topMenu.asp"-->
<!-- //상단 -->

<form method="post" id="frm_view" name="frm_view" action="">
	<input type="hidden" id="hdn_biz_code" name="hdn_biz_code" value="">
</form>

<!-- 본문 -->
<div id="contents" class="sub_page contents">
	<div class="visual_area yenbo">
		<h2>매출500대 기업자료</h2>
	</div>

	<div class="contents">
		<div class="con_box">
			<div class="innerWrap">
				<div class="salary_area MT45">
					<span class="selectbox">
						<span id="">매출500대기업 기업자료</span>
						<select id="" name=""  onchange="fn_sel(this);">
							<option value="1">1위~100위</option>
							<option value="2">101위~200위</option>
							<option value="3">201위~300위</option>
							<option value="4">301위~400위</option>
							<option value="5">401위~500위</option>
						</select>
					</span>

				</div><!--//salary_area-->
			</div>
		</div><!--//con_box-->


			<form id="frm" name="frm" method="get">
				<input type="hidden" id="schArea" name="schArea" value="">
			</form>

			<div class="tab_container">
				<div id="list1" class="tab_content">
					<div class="list_area">
						<div class="list_info">
							<div class="left_box">
								<p><span>기업명을 클릭하시면 상세 페이지로 이동합니다.</span></p>
							</div>
						</div>

						<div class="partners_wrap">

							<a href="./view.asp?bizNum=5038506378">
								<dl>
									<dt>
										(주)커리어넷
										<!--<div class="comp_type">

											<span class="blue">중견기업</span>

											<span>코스피</span>

										</div>-->
									</dt>
									<dd>
										<div class="partners_info">
											<dl>
												<dt>설립년도</dt>
												<dd>1974년</dd>
												<dt>임직원수</dt>
												<dd>270명</dd>
											</dl>
											<dl>
												<dt>매출액</dt>
												<dd>2,022억 7,591만원 (2020년 기준)</dd>
											</dl>
											<dl>
												<dt>매출순위</dt>
												<dd>1위</dd>
											</dl>
										</div>
									</dd>
								</dl>
							</a>

							<a href="./view.asp?bizNum=1068669145">
								<dl>
									<dt>
										(주)삼기
										<!--<div class="comp_type">

											<span class="blue">중견기업</span>

											<span>코스닥</span>

										</div>-->
									</dt>
									<dd>
										<div class="partners_info">
											<dl>
												<dt>설립년도</dt>
												<dd>2009년</dd>
												<dt>임직원수</dt>
												<dd>495명</dd>
											</dl>
											<dl>
												<dt>매출액</dt>
												<dd>2,916억 2,343만원 (2020년 기준)</dd>
											</dl>
											<dl>
												<dt>주요사업</dt>
												<dd>자동차부품 제조</dd>
											</dl>
										</div>
									</dd>
								</dl>
							</a>

							<a href="./view.asp?bizNum=6038103047">
								<dl>
									<dt>
										(주)유니크
										<!--<div class="comp_type">

											<span class="blue">중견기업</span>

											<span>코스닥</span>

										</div>-->
									</dt>
									<dd>
										<div class="partners_info">
											<dl>
												<dt>설립년도</dt>
												<dd>1976년</dd>
												<dt>임직원수</dt>
												<dd>639명</dd>
											</dl>
											<dl>
												<dt>매출액</dt>
												<dd>2,170억 7,457만원 (2020년 기준)</dd>
											</dl>
											<dl>
												<dt>주요사업</dt>
												<dd>자동차부품(유압솔레노이드밸브) 제조,...</dd>
											</dl>
										</div>
									</dd>
								</dl>
							</a>

							<a href="./view.asp?bizNum=5148157898">
								<dl>
									<dt>
										평화산업(주)
										<!--<div class="comp_type">

											<span class="blue">중견기업</span>

											<span>코스피</span>

										</div>-->
									</dt>
									<dd>
										<div class="partners_info">
											<dl>
												<dt>설립년도</dt>
												<dd>2006년</dd>
												<dt>임직원수</dt>
												<dd>785명</dd>
											</dl>
											<dl>
												<dt>매출액</dt>
												<dd>3,520억 2,605만원 (2020년 기준)</dd>
											</dl>
											<dl>
												<dt>주요사업</dt>
												<dd>자동차부품(방진고무,방류고무(COVE...</dd>
											</dl>
										</div>
									</dd>
								</dl>
							</a>

							<a href="./view.asp?bizNum=5148120917">
								<dl>
									<dt>
										(주)카펙발레오
										<!--<div class="comp_type">

											<span class="blue">중견기업</span>

											<span>외감</span>

										</div>-->
									</dt>
									<dd>
										<div class="partners_info">
											<dl>
												<dt>설립년도</dt>
												<dd>1993년</dd>
												<dt>임직원수</dt>
												<dd>669명</dd>
											</dl>
											<dl>
												<dt>매출액</dt>
												<dd>6,714억 7,284만원 (2020년 기준)</dd>
											</dl>
											<dl>
												<dt>주요사업</dt>
												<dd>자동차부품,변속장치 제조</dd>
											</dl>
										</div>
									</dd>
								</dl>
							</a>

							<a href="./view.asp?bizNum=5058106702">
								<dl>
									<dt>
										플라스틱옴니엄(주)
										<!--<div class="comp_type">

											<span>외감</span>

										</div>-->
									</dt>
									<dd>
										<div class="partners_info">
											<dl>
												<dt>설립년도</dt>
												<dd>1992년</dd>
												<dt>임직원수</dt>
												<dd>243명</dd>
											</dl>
											<dl>
												<dt>매출액</dt>
												<dd>1,713억 113만원 (2020년 기준)</dd>
											</dl>
											<dl>
												<dt>주요사업</dt>
												<dd>자동차부품(신소재 플라스틱 연료탱크)...</dd>
											</dl>
										</div>
									</dd>
								</dl>
							</a>

							<a href="./view.asp?bizNum=5038110156">
								<dl>
									<dt>
										(주)평화발레오
										<!--<div class="comp_type">

											<span class="blue">중견기업</span>

											<span>외감</span>

										</div>-->
									</dt>
									<dd>
										<div class="partners_info">
											<dl>
												<dt>설립년도</dt>
												<dd>1988년</dd>
												<dt>임직원수</dt>
												<dd>725명</dd>
											</dl>
											<dl>
												<dt>매출액</dt>
												<dd>7,189억 5,106만원 (2020년 기준)</dd>
											</dl>
											<dl>
												<dt>주요사업</dt>
												<dd>자동차클러치,마찰재,기계금형 제조,도...</dd>
											</dl>
										</div>
									</dd>
								</dl>
							</a>

							<a href="./view.asp?bizNum=5038106628">
								<dl>
									<dt>
										평화정공(주)
										<!--<div class="comp_type">

											<span class="blue">중견기업</span>

											<span>코스닥</span>

										</div>-->
									</dt>
									<dd>
										<div class="partners_info">
											<dl>
												<dt>설립년도</dt>
												<dd>1985년</dd>
												<dt>임직원수</dt>
												<dd>680명</dd>
											</dl>
											<dl>
												<dt>매출액</dt>
												<dd>6,267억 1,157만원 (2020년 기준)</dd>
											</dl>
											<dl>
												<dt>주요사업</dt>
												<dd>자동차용 도어모듈시스템,도어랫치,선박...</dd>
											</dl>
										</div>
									</dd>
								</dl>
							</a>

							<a href="./view.asp?bizNum=4108158130">
								<dl>
									<dt>
										(주)현대하이텍
										<!--<div class="comp_type">

											<span>외감</span>

										</div>-->
									</dt>
									<dd>
										<div class="partners_info">
											<dl>
												<dt>설립년도</dt>
												<dd>2000년</dd>
												<dt>임직원수</dt>
												<dd>91명</dd>
											</dl>
											<dl>
												<dt>매출액</dt>
												<dd>471억 6,476만원 (2020년 기준)</dd>
											</dl>
											<dl>
												<dt>주요사업</dt>
												<dd>자동차부품</dd>
											</dl>
										</div>
									</dd>
								</dl>
							</a>

							<a href="./view.asp?bizNum=4108148267">
								<dl>
									<dt>
										(유)동명정공
										<!--<div class="comp_type">

											<span>일반</span>

										</div>-->
									</dt>
									<dd>
										<div class="partners_info">
											<dl>
												<dt>설립년도</dt>
												<dd>1990년</dd>
												<dt>임직원수</dt>
												<dd>58명</dd>
											</dl>
											<dl>
												<dt>매출액</dt>
												<dd>199억 7,790만원 (2020년 기준)</dd>
											</dl>
											<dl>
												<dt>주요사업</dt>
												<dd>자동차부품,기계부품 제조</dd>
											</dl>
										</div>
									</dd>
								</dl>
							</a>


							<!--페이징-->
							<div class="paging_area"><li><strong>1</strong></li><li><a href='/partner/list.asp?page=2&schKw=&schArea='>2</a></li><li><a href='/partner/list.asp?page=3&schKw=&schArea='>3</a></li><li><a href='/partner/list.asp?page=4&schKw=&schArea='>4</a></li><li><a href='/partner/list.asp?page=5&schKw=&schArea='>5</a></li><li class="btn next"><a href='/partner/list.asp?page=6&schKw=&schArea='><span></span></a></li></div>

						</div><!-- partners_wrap -->

					</div><!-- list_area -->
				</div><!--tab_content -->

			</div><!-- tab_container -->

			<!--
			<div class="pc_btn">
				<a href="https://www.hmgpartnerjob.co.kr:444/partner/list.asp">PC버전보기</a>
			</div>-->
		</div><!--contents -->

</div>
<!-- //본문 -->

<!-- 하단 -->
<!--#include virtual = "/include/footer.asp"-->
<!-- 하단 -->
</body>
</html>
