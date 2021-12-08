<% option Explicit %>

<!--#include virtual = "/common/common.asp"-->
<!--#include virtual = "/include/header/header.asp"-->
<!--#include virtual = "/wwwconf/function/db/DBConnection.asp"-->

<%
	Dim lecture_no	: lecture_no	= Request("lecture_no")

	If lecture_no = "" Then
		Response.write "<script language=javascript>"&_
			"alert('잘못된 접근입니다.');"&_
			"location.href='/lecture/list.asp';"&_
			"</script>"
		Response.End
	End If

	ConnectDB DBCon, Application("DBInfo_FAIR")

		ReDim Param(0)
		Param(0) = makeparam("@lecture_no",adInteger,adParamInput,4,lecture_no)

		Dim arrRs : arrRs = arrGetRsSP(DBcon, "asp_관리자_특강_뷰", Param, "", "")

		Dim rs_schoolId, rs_tit, rs_date, rs_shour, rs_smin, rs_ehour, rs_emin, rs_url, rs_img, rs_replay, rs_gubun
		rs_schoolId		= arrRs(0,0)
		rs_tit			= arrRs(1,0)
		rs_date			= Left(arrRs(3,0),10)					'특강일
		rs_shour		= Split(Mid(arrRs(3,0),12,13),":")(0)	'특강_시작시
		rs_smin			= Split(Mid(arrRs(3,0),12,13),":")(1)	'특강_시작분
		rs_ehour		= Split(Mid(arrRs(4,0),12,13),":")(0)	'특강_종료시
		rs_emin			= Split(Mid(arrRs(4,0),12,13),":")(1)	'특강_종료분
		rs_url			= arrRs(5,0)
		rs_img			= arrRs(6,0)
		rs_replay		= arrRs(7,0)
		rs_gubun		= arrRs(8,0)	'특강구분(1:취업특강, 2:채용설명회)

		' 특강일시와 현재일 비교
		Dim diff_date, diff_shour, diff_ehour, diff_smin, diff_emin
		diff_date	= CInt(DateDiff("d", rs_date, FormatDateTime(Now(), 2)))
		diff_shour	= CInt(DateDiff("h", rs_shour & ":" & rs_smin, FormatDateTime(Now(), 4)))
		diff_ehour	= CInt(DateDiff("h", rs_ehour & ":" & rs_emin, FormatDateTime(Now(), 4)))
		diff_smin	= CInt(DateDiff("n", rs_shour & ":" & rs_smin, FormatDateTime(Now(), 4)))
		diff_emin	= CInt(DateDiff("n", rs_ehour & ":" & rs_emin, FormatDateTime(Now(), 4)))


		Dim lcture_state
		If diff_date < 0 Or (diff_date = 0 And diff_shour < -1) Or (diff_date = 0 And (diff_shour = 0 Or diff_shour = -1) And diff_smin < -10) Then 'diff_smin 10분전 까지
			lcture_state = "lcture_before"
		ElseIf diff_date > 0 Or (diff_date = 0 And diff_ehour > 0) Or (diff_date = 0 And diff_ehour = 0 And diff_emin >= 0) Then
			lcture_state = "lcture_end"
		Else
			lcture_state = "lcture_ing"
		End If

		'유튜브영상 고유값
		Dim youtube_code : youtube_code = Split(rs_url, "/")


		'신청여부확인
		ReDim Param(7)
		Param(0) = makeparam("@KW",adVarWChar,adParamInput,400,"")
		Param(1) = makeparam("@LECTURE_NO",adInteger,adParamInput,4,lecture_no)
		Param(2) = makeparam("@LECTURE_SCHOOL_ID",adVarWChar,adParamInput,400,"")
		Param(3) = makeparam("@USER_ID",adVarWChar,adParamInput,20,user_id)
		Param(4) = makeparam("@PAGE",adInteger,adParamInput,4,1)
		Param(5) = makeparam("@PAGE_SIZE",adInteger,adParamInput,4,1)
		Param(6) = makeparam("@TOTAL_CNT",adInteger,adParamOutput,4,"")

		Param(7) = makeparam("@LECTURE_GUBUN",adChar,adParamInput,1,rs_gubun)

		Dim arrRs_my : arrRs_my = arrGetRsSP(DBcon, "asp_관리자_특강_신청_리스트", Param, "", "")

		Dim applyChk, apply_quest
		If isArray(arrRs_my) Then
			applyChk = "Y"
			apply_quest	= arrRs_my(2,0)
		End If


		'접속LOG
		Dim strSql2, strRemoteAddr, strUserAgent
		strRemoteAddr	= Request.ServerVariables("REMOTE_ADDR")
        strUserAgent	= Request.ServerVariables("HTTP_USER_AGENT")
		strSql2 = "INSERT INTO LOG_특강접속정보 VALUES('" & user_id & "', " & lecture_no & ", '" & strRemoteAddr & "', '" & strUserAgent & "', GETDATE(), 'MOBILE')"
		DBCon.Execute(strSql2)

	DisconnectDB DBCon
%>

<script type="text/javascript">
	//사전질문 등록 팝업
	function fn_question_save(_val) {
		$("#set_lecture_no").val(_val);

		view_layer_hide("edit");
		view_layer("reg");
		fn_question_save_view_pop(_val);
	}

	//사전질문 등록 팝업
	function fn_question_save_view_pop(_val) {
		$("#set_lecture_no").val(_val);

		$.ajax({
			url: "inc_pop_question_reg.asp",
			type: "POST",
			dataType: "html",
			data: ({
				"lecture_no": _val
			}),
			success: function (data) {
				$("#pop_area_question_reg").html(data);
			},
			error: function (req, status, err) {
				alert("처리 도중 오류가 발생하였습니다.\n" + err);
			}
		});
	}

	//사전질문 등록
	function fn_apply_quest() {
		if($('#quest_cont').val() == '') {
			alert('질문을 작성해 주세요.');
			return;
		}

		$.ajax({
			url: "proc_apply_quest_insert.asp",
			type: "POST",
			dataType: "html",
			data: ({
				"lecture_no": $("#set_lecture_no").val(),
				"quest_cont": escape($("#quest_cont").val().trim())
			}),
			success: function (data) {
				if (data == "1") {
					view_layer_hide("reg");
					view_layer_hide("list");
					view_layer_hide("edit");

					alert("질문 등록이 완료되었습니다.");
					location.href = "/my/lecture_list.asp";
				} else {
					alert("처리 도중 오류가 발생하였습니다.");
				}
			},
			error: function (req, status, err) {
				alert("처리 도중 오류가 발생하였습니다.\n" + err);
				return false;
			}
		});
	}

	//로그인
	function fn_login() {
		alert("개인 로그인 후 신청이 가능합니다.");
		location.href = '/my/login.asp';
	}

	//특강신청
	function fn_apply(_val) {
		$("#set_lecture_no").val(_val);

		$.ajax({
			url: "proc_apply_insert.asp",
			type: "POST",
			dataType: "html",
			data: ({
				"lecture_no": $("#set_lecture_no").val()
			}),
			success: function (data) {
				if (data == "1") {
					alert("특강 신청이 완료되었습니다.");
					location.reload();
				} else {
					alert("처리 도중 오류가 발생하였습니다.");
				}
			},
			error: function (req, status, err) {
				alert("처리 도중 오류가 발생하였습니다.\n" + err);
				return false;
			}
		});
	}
</script>

</head>

<body>

<!-- header -->
<div  id="header">
	<div class="header-wrap detail">
		<div class="detail_box">
			<a href="./job_list.asp">이전</a>
			<p>채용설명회</p>
		</div>
		</div>
	</div>
</div>
<!-- //header -->

<!-- container -->
<div id="contents" class="sub_page">
	<div class="contents">
		<div class="visual_area lecture2">
			<h2>채용설명회</h2>
		</div><!-- visual_area -->

		<div class="employment_area view">
			<ul>
				<li>
					<dl class="employment_box">
						<dt><%=rs_tit%></dt>
						<!--<dd>
							<ul class="info">
								<li><span>일시 :</span> <%=rs_date%>&nbsp;<em><%=rs_shour%>:<%=rs_smin%></em></li>
							</ul>
						</dd>-->
						<dd class="img">
							<div class="box">
								<!--특강 시작-->
								<% If lcture_state = "lcture_ing" Then %>
									<!--<img src="http://img.youtube.com/vi/<%=youtube_code(UBound(youtube_code))%>/sddefault.jpg" alt="유튜브 실시간 이미지">
									<span>실시간</span>-->
								<% Else %>
									<!--<img src="<%=g_partner_wk%>/files/lecture/<%=rs_img%>" alt="이미지">-->
								<% End If %>
							</div>
						</dd>
					</dl>
				</li>
			</ul>

			<div class="movie_area">
				<div class="preparing">
					<!--특강 시작 전-->
					<% If lcture_state = "lcture_before" Then %>
						<img src="/images/landing/landing_preparing5.jpg" style="padding:10px 0px 0px;">
						<!--사전질문-->
						<input type="hidden" id="set_lecture_no" value="">

						<% If g_LoginChk <> "1" Then %>
							<div class="btn_area2" style="position: absolute; left: 8%; top:42%; width:60%">
								<img src="/images/landing/landing_img2.png" alt="btn_area2" style="width:94%">
								<a href="javascript:;" style="background: rgba(0,0,0,0); position: absolute; left: 13%; bottom: 0; width: 72%; height: 48%;" onclick="fn_login();"></a>
							</div>
						<% Else %>
							<!--신청여부체크-->
							<% If applyChk = "" Then %>
								<div class="btn_area2" style="position: absolute; left: 8%; top:42%; width:60%">
									<img src="/images/landing/landing_img2.png" alt="btn_area2" style="width:94%">
									<a href="javascript:;" style="background: rgba(0,0,0,0); position: absolute; left: 13%; bottom: 0; width: 72%; height: 48%;" onclick="fn_apply('<%=lecture_no%>');"></a>
								</div>
							<% Else %>
								<% If IsNull(apply_quest) = True Then %>
									<div class="btn_area1" style="position: absolute; left: 8%; top:22%; width:60%;">
										<img src="/images/landing/landing_img1.png" alt="btn_area1" style="width:100%">
										<a href="#layer1" class="pop" style="background: rgba(0,0,0,0); position: absolute; left: 13%; bottom: 0; width: 72%; height: 48%;" onclick="fn_question_save('<%=lecture_no%>')"></a>
									</div>
								<% End If %>
							<% End If %>
						<% End If %>

					<!--특강 시작-->
					<% ElseIf lcture_state = "lcture_ing" Then %>
						<div class="movie">
							<iframe width="100%" height="100%" src="https://www.youtube.com/embed/<%=youtube_code(UBound(youtube_code))%>" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
						</div>
					<!--특강 종료-->
					<% ElseIf lcture_state = "lcture_end" Then %>
						<img src="/images/landing/landing_preparing4.jpg" style="padding:10px 0px 0px;">
					<% End If %>
				</div>

				<!--
				<div class="btn_area">
					특강 시작 전
					<% If lcture_state = "lcture_before" Then %>
						신청여부체크
						<% If applyChk <> "" Then %>
							<a href="javaScript:alert('입장은 특강 시작일 기준 10분 전부터 가능합니다.');" class="btn">Youtube에서 보기</a>
						<% Else %>
							사전질문
							<input type="hidden" id="set_lecture_no" value="">

							<% If g_LoginChk <> "1" Then %>
								<a href="#layer1" class="btn lg" onclick="fn_login();">사전질문 하러가기</a>
							<% Else %>
								<a href="#layer1" class="btn lg pop" onclick="fn_question_save('<%=lecture_no%>');">사전질문 하러가기</a>
							<% End If %>
						<% End If %>
					특강 시작
					<% ElseIf lcture_state = "lcture_ing" Then %>
						<a href="https://youtu.be/<%=youtube_code(UBound(youtube_code))%>" class="btn lg" target="_blank">Youtube에서 보기</a>
					특강 종료
					<% ElseIf lcture_state = "lcture_end" Then %>
						<% If rs_replay = "Y" Then %>
							<a href="https://youtu.be/<%=youtube_code(UBound(youtube_code))%>" class="btn lg" target="_blank">다시보기</a>
						<% End If %>
					<% End If %>
				</div>


				<div class="btn_area">
					특강 시작 전
					<% If lcture_state = "lcture_before" Then %>
						신청여부체크
						<% If applyChk <> "" Then %>
							<a href="javaScript:alert('입장은 특강 시작일 기준 10분 전부터 가능합니다.');" class="btn">Youtube에서 보기</a>
						<% End If %>
					특강 시작
					<% ElseIf lcture_state = "lcture_ing" Then %>
						<a href="https://youtu.be/<%=youtube_code(UBound(youtube_code))%>" class="btn lg" target="_blank">Youtube에서 보기</a>
					<% End If %>
				</div>
				-->
			</div>

		</div><!-- lecture_area -->

	</div><!--contents -->

</div>
<!-- //container -->

<!-- 하단 -->
<!--#include virtual = "/include/footer.asp"-->
<!-- 하단 -->

<!--사전질문 팝업관련-->
<!--#include file = "./inc_popup.asp"-->

<!-- 강사 프로필 -->
<div id="layer_pop18" class="layer_popup">
	<div class="popup_dim"></div>
	<div class="popup">
		<div class="pop_wrap">
			<div class="pop_head">
				<h3>강사 프로필</h3>
				<a href="javascript:void(0)" class="close">닫기</a>
			</div>
			<div class="pop_con">
				<div class="porfile_area">
					<p class="name">강사 : 이 건 </p>
					<dl>
						<dt>주요이력</dt>
						<dd>
							현) 더빅스쿨 멘토<br>
							현) 서울시 일자리 카페 멘토<br>
							전) 우리은행 기업금융 담당
						</dd>
						<dt>주요활동</dt>
						<dd>
							국무총리상 (고용노동정책제안)<br>
							법제처장상 (개인정보법안)<br>
							제경부장관상 (공정사회정책제안)<br>
							청년희망재단 멘토<br>
							한국직업방송 패널
						</dd>
					</dl>
				</div>
			</div>
		</div>
	</div>
</div>
<div id="layer_pop16" class="layer_popup">
	<div class="popup_dim"></div>
	<div class="popup">
		<div class="pop_wrap">
			<div class="pop_head">
				<h3>강사 프로필</h3>
				<a href="javascript:void(0)" class="close">닫기</a>
			</div>
			<div class="pop_con">
				<div class="porfile_area">
					<p class="name">강사 : 차재원</p>
					<dl>
						<dt>주요이력</dt>
						<dd>
							현) 트러스트원컨설팅 컨설턴트 (대학교육/공공기관 주관 청년교육)<br>
							전) CJ ENM -  오쇼핑 부문 인사담당 / 매체사업팀 (2012.01~2017.02)<br>
							전) 현대자동차 인도법인 판매기획팀
						</dd>
						<dt>주요활동</dt>
						<dd>
							서울시립대학교 경영대학원  MBA 석사 (인사조직 전공, 졸업. 2020.02)<br>
							한국외국어대학교 글로벌 캠퍼스 인도학과 학사<br>
							한국직업방송 JOB정보센터, 투데이 JOBS 출연<br>
							서울경제 TV (이슈플러스) 출연
						</dd>
					</dl>
				</div>
			</div>
		</div>
	</div>
</div>
<div id="layer_pop17" class="layer_popup">
	<div class="popup_dim"></div>
	<div class="popup">
		<div class="pop_wrap">
			<div class="pop_head">
				<h3>강사 프로필</h3>
				<a href="javascript:void(0)" class="close">닫기</a>
			</div>
			<div class="pop_con">
				<div class="porfile_area">
					<p class="name">강사 : 조준범</p>
					<dl>
						<dt>주요이력</dt>
						<dd>
							현) 주식회사 이지팜 빅데이터 사업본부 본부장<br>
							전) 주식회사 펀진 IoT 사업팀 팀장<br>
							전) 주식회사 수산아이엔티 사업기획팀 팀장

						</dd>
						<dt>주요활동</dt>
						<dd>
							LG CNS | MI시스템 구축사업,  Elasticsearch를 이용한 IR고도화<br>
							현대 오토에버 | GAPM ASP시스템 개편 프로젝트, Elasticsearch Developer컨설팅<br>
							현대자동차그룹 | Elasticsearch Platinum 차세대 보안 이상징후 확대 (Renewal)<br>
							삼성전자 | Elasticsearch Platinum 검색엔진 개편 (Renewal)<br>
							한국인터넷진흥원 | 빅데이터 기반의 인공지능 영상정보분석 솔루션
						</dd>
					</dl>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- //강사 프로필 -->

</body>
</html>
