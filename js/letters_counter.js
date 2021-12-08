/*
*	기본이력서 정보 가져오기-자소서 불러오기
*/
function fn_get_info_self_resume_get(uid) {
	
	uid = uid || '';
	if(uid=='') {
	
		alert('본 서비스를 이용하기 위해서는 개인회원 로그인이 필요합니다.\n로그인 후 이용해 주시기 바랍니다.');
		fn_login_redirect();
		return;
	} else {
		$.get("/wwwconf/include/tools/ajax_resumeinfo_get.asp?dummy="+Math.random()*99999+"&uid=" +uid, function(data) {
			var json = eval( "(" + data + ")" );
			if(json.ret_val>0 && json.info[0].rsm_idx!='') {	// 기본이력서 존재
				var rid =  json.info[0].rsm_idx;
				$("#rid").val(rid);
				
				fn_get_introduce(rid)

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
*	기본이력서 정보 가져오기-자소서 적용하기
*/
function fn_get_info_self_resume_set(uid) {
	
	uid = uid || '';
	if(uid=='') {
	
		alert('본 서비스를 이용하기 위해서는 개인회원 로그인이 필요합니다.\n로그인 후 이용해 주시기 바랍니다.');
		fn_login_redirect();
		return;
	} else {
		$.get("/wwwconf/include/tools/ajax_resumeinfo_get.asp?dummy="+Math.random()*99999+"&uid=" +uid, function(data) {
			var json = eval( "(" + data + ")" );
			if(json.ret_val>0 && json.info[0].rsm_idx!='') {	// 기본이력서 존재
				var rid =  json.info[0].rsm_idx;
				$("#rid").val(rid);
				
				fn_set_introduce(rid)

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
*	자기소개서 가져오기
*/
function fn_get_introduce(rid) {
	rid = rid || '';

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
		
			$.get("/wwwconf/include/tools/ajax_resume_get.asp?dummy="+Math.random()*99999+"&rid=" +rid, function(data) {
				var json = eval( "(" + data + ")" );

				if(json.ret_val>0 && json.info[0].rsm_idx!='') {	// 기본이력서 존재
					var rid = json.info[0].rsm_idx;
					$("#rid").val(rid);
					var seq = json.info[0].rsm_seq;
					$("#seq").val(seq);
					var input_letters = json.info[0].content;
					$("#input_letters").val(input_letters);
					fn_letters_count($("#input_letters"));

//					alert("rid: "+rid+"</br>seq: "+seq+"</br>content: "+input_letters);
												
					if(input_letters.length < 1) {
						alert('작성된 자기소개서가 없습니다.');
						return false;
					}
					//fn_letters_count( input_letters );

				} else {
					if(confirm("현재 등록하신 이력서가 없습니다.\n이력서를 새로 등록하시겠습니까?")) {
						var newWin = window.open("/my/resume/resume_step1.asp");
						if(newWin==null) {
							alert('팝업이 차단되었습니다.\n팝업차단을 해제하고 다시 시도해주시기 바랍니다.');
						}
					}
				}
			});
		
	}
}

/*
*	내 이력서 적용하기
*/
function fn_set_introduce(rid) {
	if ($("#input_letters").val().trim()=="") {
		alert('자기소개서를 작성해 주십시오.');
		return;
	} else {
		var str_cnt = parseInt( $("span[class^=blank_] strong:eq(1)").text().replace(",","") );
		
		if(str_cnt <200 || str_cnt > 6000) {
			alert('커리어 자기소개서는 200bytes 이상 6000bytes 이하로 작성해주시기 바랍니다.');
			return;
		}
		if (rid==""|| $("#seq").val()=="") {
			if(confirm('반영할 자기소개서를 불러옵니다.')) {
				fn_get_introduce(rid,false);
			}
			return;
		} else {
			fn_set_proc(rid);
		}
	}
}

/*
*	이력서 반영 처리 부분
*/
function fn_set_proc(rid) {
	rid = rid || '';

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
		if(! (rid=='' ||  $("#seq").val()=='' || $("#input_letters").val().trim()=='') ) {
			var seq = $("#seq").val();
			var content = $("#input_letters").val();
//			alert(rid+" :: " + seq +" :: "+ content);
			content = escape(content);
			$.ajax({
				url : "/wwwconf/include/tools/ajax_resume_set.asp",
				dataType : "text",
				type : "POST",				
				data : ({ 
					"rid" : rid,
					"seq" : seq,
					"content" : content
				}),
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				success : function(data) {
					var json = eval( "(" + data + ")" );
					if(json.ret_val>0) {
						// alert('기본이력서에 반영되었습니다.');
						if(confirm('입력하신 내용이 기본이력서에 반영되었습니다.\n적용된 이력서를 확인하시겠습니까?')) {
							var newWin = window.open('/my/resume/resume_view.asp?rid='+rid);
							if(newWin==null) {
								alert('팝업이 차단되었습니다.\n팝업차단을 해제하고 다시 시도해주시기 바랍니다.');
							}
						}
						return;
					} else {
						alert('처리 도중 오류가 발생하였습니다.'+json.ret_val);
						return;
					}
				},
				error : function(req, status, err) {
					
					//alert("readyState: "+req.readyState+"\n status: "+req.status); 
					alert("readyState: "+req.readyState+"\n status: "+req.status+"\n 처리 도중 오류가 발생하였습니다.\n"+err);
					
				}
			});
		}
	}
}

/*
*	팝업 메뉴
*/
function fn_pop(num) {
	num = num || 1;
	if(num == 1) {
		var popWin1 = window.open(" http://speller.cs.pusan.ac.kr/","popWin2","width=437,height=543, scrollbars=yes");
		popWin1.focus();
	} else if(num==2) {
		var popWin2 = window.open("http://loanword.cs.pusan.ac.kr/","popWin1","width=437,height=585,scrollbars=yes");
		popWin2.focus();
	} else if(num==3) {
		var popWin3 = window.open("http://s.lab.naver.com/autospacing/","popWin3","width=823,height=662,scrollbars=yes");
		popWin3.focus();
	} else if(num==4) {
		window.open("/info/data/list_intro.asp");
	}
}

/*
*	모두 지우기
*/
function fn_reset() {
	$("#input_letters").val("");
	$("span[class^=blank_] strong").each(function(idx) {
		$(this).text("0");
	});
}


/*
*	글자수 체크
*/
function fn_letters_count(obj) {
	obj = obj || $("#input_letters").val();
	var str = $(obj).val();
	var strtrim = str.split(" ").join("");
	
	$("span[class^=blank_] strong:eq(0)").text(commify(str.length));
	$("span[class^=blank_] strong:eq(1)").text(commify(str.getbytes()));
	$("span[class^=blank_] strong:eq(2)").text(commify(strtrim.length));
	$("span[class^=blank_] strong:eq(3)").text(commify(strtrim.getbytes()));
}


/*
*	숫자 단위 comma 표시
*/
function commify(n) {
	var reg = /(^[+-]?\d+)(\d{3})/;	// 정규식
	n += '';									// 숫자를 문자열로 변환

	while (reg.test(n))
		n = n.replace(reg, '$1' + ',' + '$2');

	return n;
}


/*
*	내용 복사
*/
function fn_copy() {
	copyToClipboard($("#input_letters").val());
}


/*
*	클립보드 복사 함수
*/
function copyToClipboard(text) {
	if(text.trim()=="") {
		alert('복사할 내용이 없습니다.\n내용을 입력 후 이용해주시기 바랍니다.');
		return;
	}
	
	if (window.clipboardData) {
		window.clipboardData.setData("Text", text);
		alert('입력하신 내용이 복사되었습니다.\nCtrl+v 키를 사용하여, 붙여넣기를 사용하실 수 있습니다.');
	} else {
		try {
			netscape.security.PrivilegeManager.enablePrivilege('UniversalXPConnect');
			var clip = Components.classes['@mozilla.org/widget/clipboard;1'].createInstance(Components.interfaces.nsIClipboard);
			if (!clip) return;
			var trans = Components.classes['@mozilla.org/widget/transferable;1'].createInstance(Components.interfaces.nsITransferable);
			if (!trans) return;
			trans.addDataFlavor('text/unicode');
			var str = new Object();
			var len = new Object();
			var str = Components.classes["@mozilla.org/supports-string;1"].createInstance(Components.interfaces.nsISupportsString);
			var copytext=text;
			str.data=copytext;
			trans.setTransferData("text/unicode",str,copytext.length*2);
			var clipid=Components.interfaces.nsIClipboard;
			if (!clip) return false;
			clip.setData(trans,null,clipid.kGlobalClipboard);
			
			alert('입력하신 내용이 복사되었습니다.\nCtrl+v 키를 사용하여, 붙여넣기를 사용하실 수 있습니다.');
		} catch(e) {
			alert("브라우저가 클립보드 사용을 지원하지 않습니다."+e);
			return false;
		}
	}
 
	return true;
}


/*
*	파일 저장하기(다운로드)
*/
function fn_download() {
	var fileName = "자기소개서.txt";
	var content = document.getElementById("input_letters").value;
	
	if (isIE())
	{
		saveToFile_IE(fileName, content);
	}
	else
	{
		saveToFile(fileName, content);
	}
}

function saveToFile(fileName, content) {
	var element = document.createElement('a');
	element.setAttribute("href", "data:text/plain;charset=euc-kr," + encodeURIComponent(content));
	element.setAttribute("download", fileName);

	element.style.display = "none";
	document.body.appendChild(element);
	element.click();
	document.body.removeChild(element);
}

function saveToFile_IE(fileName, content) {
    var blob = new Blob([content], { type: "text/plain", endings: "native" });
    window.navigator.msSaveBlob(blob, fileName);
	//window.navigator.msSaveOrOpenBlob(blob, fileName);
}
	
function isIE() {
    return (navigator.appName === 'Netscape' && navigator.userAgent.search('Trident') !== -1) || 
		navigator.userAgent.toLowerCase().indexOf("msie") !== -1;
}