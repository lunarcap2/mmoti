/*
*	기본이력서 정보 가져오기
*/
function fn_get_info(uid) {

	uid = uid || '';
	if(uid=='') {

		alert('본 서비스를 이용하기 위해서는 개인회원 로그인이 필요합니다.\n로그인 후 이용해 주시기 바랍니다.');
		fn_login_redirect();
		return;
	} else {
		$.get("/wwwconf/include/tools/ajax_resumeinfo_get.asp?dummy="+Math.random()*99999+"&uid=" +uid, function(data) {
			var json = eval( "(" + data + ")" );
			if(json.ret_val=='1' && json.info[0].rsm_idx!='') {	// 기본이력서 존재
				var rid =  json.info[0].rsm_idx;
				$("#rid").val(rid);
				var rstep = json.info[0].rsm_step;
				$("#rstep").val(rstep);
				var regdate = json.info[0].regdate;
				var moddate = json.info[0].moddate;
				var arrdate1 = regdate.split("-");
				var arrdate2 = moddate.split("-");

				$(".basic_resume .year").each(function(idx) {
					$(this).text( (idx==0) ? arrdate1[0] : arrdate2[0] );
				});
				$(".basic_resume .month").each(function(idx) {
					$(this).text( (idx==0) ? arrdate1[1] : arrdate2[1] );
				});
				$(".basic_resume .day").each(function(idx) {
					$(this).text( (idx==0) ? arrdate1[2] : arrdate2[2] );
				});
				$(".basic_resume").show();

				fn_get_career(rid,rstep);

			} else {
				$("#rid").val("0");
				/* if(confirm("현재 등록하신 이력서가 없습니다.\n이력서를 새로 등록하시겠습니까?")) {
					window.open("/my/resume/resume_step1.asp");
				} */
			}
		});

	}
}


/*
*	세부 경력사항 가져오기
*/
function fn_get_career(rid,rstep) {

	var agree_chk = $("#daum_agree").val();
	if(document.domain.indexOf("career.co.kr") > 0) {
		agree_chk = "1";
	}

	if(agree_chk=="-1") {

		alert('본 서비스를 이용하기 위해서는 개인회원 로그인이 필요합니다.\n로그인 후 이용해 주시기 바랍니다.');
		fn_login_redirect();
		return;
	} else if(agree_chk=="0") {
		alert('먼저 개인정보 제공동의를 해주시기 바랍니다.');
		var newWin = window.open("/my/");
		if(newWin==null) {
			alert('팝업이 차단되었습니다.\n팝업차단을 해제하고 다시 시도해주시기 바랍니다.');
		}
		return;
	} else if(agree_chk=="1") {
//		alert("rid: "+rid + " / rstep: " + rstep);
		if(rid=='' || rstep=='') {
			if(rid=='0') {
				if(confirm("현재 등록하신 이력서가 없습니다.\n이력서를 새로 등록하시겠습니까?")) {
					window.open("/my/resume/resume_step1.asp");
				}
				return;
			} else {
				alert('본 서비스를 이용하기 위해서는 개인회원 로그인이 필요합니다.\n로그인 후 이용해 주시기 바랍니다.');
				fn_login_redirect();
				return;
			}
		} else {
			$.get("/wwwconf/include/tools/ajax_resumecareer_get.asp?dummy="+Math.random()*99999, {
				"rid" : rid,
				"step" : rstep
			}, function(data) {
				var json = eval( "(" + data + ")" );
				if(json.ret_val>0) {
					fn_reset();
					var career = json.career;
					career = career.reverse();
					var init_loop=0;
					for(init_loop=0;init_loop<career.length;init_loop++) {
						fn_add_career();

						var pidx = $(".group .term").length-1;

						$(".group .term:eq(" + pidx +") select").each(function(idx) {

							switch(idx) {
								case 0 : $(this).val(career[init_loop].st_year);  break;
								case 1 : $(this).val(career[init_loop].st_month);  break;
								case 2 : $(this).val(career[init_loop].ed_year);  break;
								case 3 : $(this).val(career[init_loop].ed_month);  break;
								case 4 :
									if(career[init_loop].c_type!='1') {
										$(this).children('option:eq(1)').attr('selected',true);
									}
									break;
							}

						});
						$(".sty:eq(" + pidx +")").text(career[init_loop].st_year);
						$(".stm:eq(" + pidx +")").text(career[init_loop].st_month);
						$(".edy:eq(" + pidx +")").text(career[init_loop].ed_year);
						$(".edm:eq(" + pidx +")").text(career[init_loop].ed_month);
						if(career[init_loop].c_type!='1') {
							$(".chst:eq(" + pidx +")").text("재직중");
						} else {
							$(".chst:eq(" + pidx +")").text("퇴사");
						}
					};

					alert("기본이력서의 세부경력사항이 반영되었습니다.");
				//	$(".fix img").hide();
				} else {
					alert("기본이력서에 세부경력사항이 등록되지 않았습니다.");
				//	$(".fix img").show();
				}
			});
		}
	}
}

/*
*	추가
*/
function fn_add_career() {
	if($(".group .term").length==20) {
		alert('세부경력 기간 추가를 20개까지 하실 수 있습니다.');
		return;
	}

	var date = new Date();
	var now_year = date.getFullYear();

	var html =  '<div class="term">\n'
		+ ' <span class="selectbox s1">\n'
		+ '		<span class="sty">'+now_year+'</span>\n '
		+ '		<select onchange="fn_chng_month(0);$(this).prev().html(this.value);" id="st_year" name ="st_year">\n'
		+			fn_get_cal('year')
		+ '		</select>\n'
		+ '	</span>\n'
		+ ' <span class="txt">년</span>\n'
		+ '	<span class="selectbox s2">\n'
		+ '		<span class="stm">1</span>\n '
		+ '		<select onchange="fn_chng_month(1);$(this).prev().html(this.value);" id="st_month" name ="st_month">\n'
		+			fn_get_cal('month')
		+ '		</select>\n '
		+ '	</span>\n '
		+ '	<span class="txt">월 입사 ~</span>\n'
		+ ' <span class="selectbox s1">\n'
		+ '		<span class="edy">'+now_year+'</span>\n '
		+ '		<select onchange="fn_chng_month(2);$(this).prev().html(this.value);" id="ed_year" name ="ed_year">\n'
		+			fn_get_cal('year')
		+ '		</select>\n '
		+ ' </span>\n '
		+ ' <span class="txt">년</span>\n '
		+ ' <span class="selectbox s2">\n'
		+ '		<span class="edm">1</span>\n '
		+ '		<select onchange="fn_chng_month(3);$(this).prev().html(this.value);" id="ed_month" name ="ed_month">\n'
		+			fn_get_cal('month')
		+ '		</select>\n '
		+ ' </span>\n '
		+ ' <span class="txt">월</span>\n '
		+ ' <span class="selectbox s2">\n '
		+ '		<span class="chst">퇴사</span>\n '
		+ '		<select onchange="$(this).prev().html(this.value);">\n '
		+ '			<option value="퇴사" selected="selected">퇴사</option>\n'
		+ '			<option value="재직중">재직중</option>\n'
		+ '		</select>\n '
		+ ' </span>'
		+ ' <span class="addBtn"></span> '
		+ '</term>\n';
	if($(".group").is('.fnCustomUiGroupWrapping')){
		var $html = $(html);
		$(".group").append($html);
		if(window.customTags){
			$(".group.fnCustomUiGroupWrapping").customTags($html);
		}
	}else{
		$(".group").append(html);
	}
	fn_button_render();

}

/*
*	버튼 표시 및 이벤트 할당
*/
function fn_button_render() {

	$(".group .addBtn").each(function(idx) {
		var html = '';
		if(idx==0) {
			if($(".group .addBtn").length==1) {

				html = '<a class="txt add" href="javascript:void(0);" onclick="fn_add_career();"><span>추가</span></a>';
			}
			else {

				html += '<a class="txt add" href="javascript:void(0);" onclick="fn_add_career();"><span>추가</span></a>';

			}
		}
		else {

			html = ' <a class="txt add" href="javascript:void(0);" onclick="fn_add_career();"><span>추가</span></a>';

			if(idx == ($(".group .addBtn").length-1)) {

				html += ' <a class="txt del" href="javascript:void(0);" onclick="fn_remove_career(this);"><span>삭제</span></a>';
			}
			else {
				html = ' <a class="txt add" href="javascript:void(0);" onclick="fn_add_career();"><span>추가</span></a>';
				html += ' <a class="txt del" href="javascript:void(0);" onclick="fn_remove_career(this);"><span>삭제</span></a>';
			}
		}

		$(this).html(html);
	});

}

/*
*	년월 정보 가져오기
*/
function fn_get_cal(type) {
	type = type || 'year';
	var options = '';

	if(type=='year') {
		var date = new Date();
		var start_year = 1954;
		var end_year = date.getFullYear();
		for(i=end_year;i>=start_year;i--) {
			options += '		<option value="' + i + '"'
				+ (i==end_year?' selected':'')
				+ '>' + i + '</option>\n';
		}
	} else if(type=='month') {
		for(i=1;i<13;i++) {
			options += '		<option value="' + i + '">' + i  + '</option>\n';
		}
	}

	return options;
}


/*
*	삭제
*/
function fn_remove_career(obj) {
	if($(".group").is('.fnCustomUiGroupWrapping')){
		var parentobj = $(obj).closest('.term');
	}else{
		var parentobj = $(obj).parent().parent();
	}
	$(parentobj).children().remove();
	$(parentobj).remove();

	fn_button_render();
}


/*
*	모두 지우기
*/
function fn_reset() {
	$(".group").children().remove();
	$("#result_year").val("");
	$("#result_month").val("");
}

/*
*	계산하기
*/
function fn_calculate() {
	var ret_month = 0;
	ret_month = fn_chk_month();

	if(ret_month>0) {
		$("#result_year").val( Math.floor(ret_month / 12) );
		$("#result_month").val( parseInt(ret_month%12) );

	} else {
		$("#result_year").val("");
		$("#result_month").val("");
	}
}

/*
*	선택 기간 계산
*/
function fn_chk_month() {
	var ret_month = 0;
	var chk_month = 0;
	var st_year, st_month, ed_year, ed_month, bf_year, bf_month;
	var bool = true;

	$(".group .term").each(function(idx,item) {
		st_year = parseInt($(this).find("select[name=st_year] option:selected").val());
		st_month = parseInt($(this).find("select[name=st_month] option:selected").val());
		ed_year = parseInt($(this).find("select[name=ed_year] option:selected").val());
		ed_month = parseInt($(this).find("select[name=ed_month] option:selected").val());

//		alert(idx + " / " + st_year+ " / " +st_month+ " / " +ed_year+ " / " +ed_month);
//		return false;

		ret_month += ( (ed_year-st_year)*12 + (ed_month-st_month) );

		if(ret_month < 0) {
			alert('기간선택이 잘못되었습니다.');
			bool = false;
			return false;
		}

		if(idx > 0) {
			chk_month = ( (st_year-bf_year)*12 + (st_month-bf_month) );
			if(chk_month < 0) {
				alert('재직기간은 중복선택이 불가합니다.\n재설정 하신 후, 변환하시기 바랍니다.');
				bool = false;
				return false;
			}
		}

		if(idx==0 || (idx>0 && !(bf_year==st_year && bf_month==st_month))) {
			ret_month += 1;
		}
		bf_year = ed_year;
		bf_month = ed_month;
	});

	return ret_month;
}


/*
*	선택 기간 입력 체크
*/
function fn_chng_month(chkidx) {
	chkidx = chkidx || 0;

	var chk_month = 0;
	var st_year, st_month, ed_year, ed_month, bf_year, bf_month;

	$(".group .term").each(function(idx) {
		st_year = parseInt($(this).find("select[id=st_year] option:selected").val());
		st_month = parseInt($(this).find("select[id=st_month] option:selected").val());
		ed_year = parseInt($(this).find("select[id=ed_year] option:selected").val());
		ed_month = parseInt($(this).find("select[id=ed_month] option:selected").val());

		//console.log(st_year + "-" + st_month + " ~ " + ed_year + "-" + ed_month);

		chk_month = ( (ed_year-st_year)*12 + (ed_month-st_month) );
		if(chk_month < 0) {
			alert('기간선택이 잘못되었습니다.');
			if(chkidx==0 || chkidx==1) {
				$(this).find("select[id=st_year] option:selected").val(st_year);
				$(this).find("select[id=st_month] option:selected").val(st_month);
			} else {
				$(this).find("select[id=ed_year] option:selected").val(ed_year);
				$(this).find("select[id=ed_month] option:selected").val(ed_month);
			}
			return false;
		}

		if(idx > 0) {
			chk_month = ( (st_year-bf_year)*12 + (st_month-bf_month) );
			if(chk_month < 0) {
				alert('재직기간은 중복선택이 불가합니다.\n재설정 하신 후, 변환하시기 바랍니다.');
				$(this).find("span.selectbox:eq(0)").val(bf_year);
				$(this).find("span.selectbox:eq(1)").val(bf_month);
				return false;
			}
		}

		//bf_year = ed_year;
		//bf_month = ed_month;

	});
}