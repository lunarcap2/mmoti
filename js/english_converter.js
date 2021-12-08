/*
*	안내문구 변경
*/
function fn_type_change(val) {
	$("#remark_toeic").attr("style", "display:none");
	$("#remark_toeic_s").attr("style", "display:none");
	$("#remark_teps").attr("style", "display:none");
	$("#remark_teps_s").attr("style", "display:none");
	$("#remark_ibt").attr("style", "display:none");
	$("#remark_newteps").attr("style", "display:none"); // new teps 관련 문구 추가 [2020-03-27 edit by star]

	$("#remark_" + val.toLowerCase()).attr("style", "display:block");
}

/*
*	어학점수 변환
*/
function fn_english_convert() {
	var exam_type = $("select[id=exam_type] option:selected").val().toLowerCase();
	var default_point = $("#cur_point").val();
	
	if(fn_chk_numeric($("#cur_point"))) {
		$("input[id^=result_point]").val("");
	}
	
	var cur_point = $("#cur_point").val();
	cur_point = Number(cur_point); 
	var str_point_last = cur_point.toString().substring(cur_point.toString().length -1);
	var min_point = 0; var max_point = 0;
	/*
	min_point = (exam_type=="toeic") ? 320 : min_point;
	max_point = (exam_type=="toeic") ? 990 : max_point;
	*/

	if (default_point != "어학점수를 입력해 주세요."){
		switch(exam_type) {
			case "toeic" :
				min_point = 320;
				max_point = 990;
				
				if(cur_point < min_point) {
					alert(min_point+'점 미만으로는 변환 불가하오니, 점수를 다시한번 확인해 주세요.');
					return;
				} else if(cur_point > max_point) {
					alert(max_point+'점 초과로는 변환 불가하오니, 점수를 다시한번 확인해 주세요.');
					return;
				} else if(!(str_point_last == '0' || str_point_last == '5')) {
					alert("입력하신 점수로는 변환 불가하오니, 점수를 다시한번 확인해 주세요.");
					return;
				}
				break;
			
			case "toeic_s" :
				min_point = 50;
				max_point = 200;

				if(cur_point < min_point) {
					alert(min_point+'점 미만으로는 변환 불가하오니, 점수를 다시한번 확인해 주세요.');
					return;
				} else if(cur_point > max_point) {
					alert(max_point+'점 초과로는 변환 불가하오니, 점수를 다시한번 확인해 주세요.');
					return;
				} else if(!(str_point_last == '0')) {
					alert("입력하신 점수로는 변환 불가하오니, 점수를 다시한번 확인해 주세요.");
					return;
				}
				break;
		
			case "teps" :
				min_point = 280;
				max_point = 990;

				if(cur_point < min_point) {
					alert(min_point+'점 미만으로는 변환 불가하오니, 점수를 다시한번 확인해 주세요.');
					return;
				} else if(cur_point > max_point) {
					alert(max_point+'점 초과로는 변환 불가하오니, 점수를 다시한번 확인해 주세요.');
					return;
				} else if( eval(exam_type+"Array["+cur_point+"]") == null ) {
					alert("입력하신 점수로는 변환 불가하오니, 점수를 다시한번 확인해 주세요.");
					return;
				}
				break;

			// new teps 환산 점수 입력값 제어 조건 추가 [2020-03-23 edit by star]
			case "newteps" :
				min_point = 150;
				max_point = 600;

				if(cur_point < min_point) {
					alert(min_point+'점 미만으로는 변환 불가하오니, 점수를 다시한번 확인해 주세요.');
					return;
				} else if(cur_point > max_point) {
					alert(max_point+'점 초과로는 변환 불가하오니, 점수를 다시한번 확인해 주세요.');
					return;
				} else if( eval(exam_type+"Array["+cur_point+"]") == null ) {
					alert("입력하신 점수로는 변환 불가하오니, 점수를 다시한번 확인해 주세요.");
					return;
				}
				break;

			case "teps_s" :
				min_point = 8;
				max_point = 99;

				if(cur_point < min_point) {
					alert(min_point+'점 미만으로는 변환 불가하오니, 점수를 다시한번 확인해 주세요.');
					return;
				} else if(cur_point > max_point) {
					alert(max_point+'점 초과로는 변환 불가하오니, 점수를 다시한번 확인해 주세요.');
					return;
				}
				break;

			case "ibt" :
				min_point = 17;
				max_point = 120;

				if(cur_point < min_point) {
					alert(min_point+'점 미만으로는 변환 불가하오니, 점수를 다시한번 확인해 주세요.');
					return;
				} else if(cur_point > max_point) {
					alert(max_point+'점 초과로는 변환 불가하오니, 점수를 다시한번 확인해 주세요.');
					return;
				}
				break;

			default :
				break;
		}
	}

	var arrtemp = eval(exam_type+"Array["+cur_point+"]");
	var arrlist = arrtemp.split(",");
	if($.isArray(arrlist)) {
		$("input[id^=result_point]").each(function(idx,item) {
			var arridx = $(this).attr("arridx");
			if(arridx!="") {
				$(this).val( arrlist[ parseInt(arridx) ] );
			}
		});
	}
	
	var speaking_level	= fn_convert_speaking(arrlist[0]);
	var writing_level	= fn_convert_writing(arrlist[0]);
	
	$("#result_point_speaking").val(speaking_level);
	$("#result_point_writing").val(writing_level);
}

/*
*	Toeic Speaking 점수 변환
*/
function fn_convert_speaking(toeic_point) {
	var speaking_level = "3↓";
	if(toeic_point < 350) {
		speaking_level = "3↓";
	} else if(toeic_point < 535) {
		speaking_level = "4";
	} else if(toeic_point < 675) {
		speaking_level = "5";
	} else if(toeic_point < 880) {
		speaking_level = "6";
	} else if(toeic_point > 875) {
		speaking_level = "7↑";
	}
	return speaking_level;
}

/*
*	Toeic Writing 점수 변환
*/
function fn_convert_writing(toeic_point) {
	var writing_level = "4↓";
	if(toeic_point < 350) {
		writing_level = "4↓";
	} else if(toeic_point < 495) {
		writing_level = "5";
	} else if(toeic_point < 695) {
		writing_level = "6";
	} else if(toeic_point < 890) {
		writing_level = "7";
	} else if(toeic_point > 885) {
		writing_level = "8↑";
	}
	return writing_level;
}

/*
*	숫자만 입력되도록
*/
function fn_chk_numeric(obj) {
	var str = $(obj).val();
	var var_normalize = /[^\d$]/gi;
	
	if (var_normalize.test(str)) {
		alert("숫자만 입력하실 수 있습니다.");
		$(obj).val(str.replace(var_normalize,""));
		return false;
	} else {
		return true;
	}
}
