/*
-----------------------------------------------------------------------
-- ��ũ��
-----------------------------------------------------------------------
*/
function fn_scrap(loginChk, id_num, obj) {
	if (loginChk != "1") {
		var result = confirm("����ȸ�� �α��� �� �̿밡���մϴ�. �α����Ͻðڽ��ϱ�?");

		if(result) {
			location.href = '/my/login.asp?redir=' + location.pathname;
		}
	}
	else {
		$.ajax({
			type: "POST"
			, url: "/jobs/scrap.asp"
			, data: { id_num: id_num }
			, dataType: "html"
			, async: true
			, success: function (data) {
				if (data == "1") {
					alert("��ũ���Ǿ����ϴ�.");
					$(obj).addClass('on');
				}
				else if (data == "2") {
					alert("��ũ���� �����߽��ϴ�.");
					$(obj).removeClass('on');
				}
				else if (data == "0") {
					alert("��ũ�� �����߽��ϴ�.");
					return false;
				}
			}
			, error: function (XMLHttpRequest, textStatus, errorThrown) {
				alert(textStatus);
			}
		});
	}
}

/*
-----------------------------------------------------------------------
-- ���ɱ��
-----------------------------------------------------------------------
*/
function fn_attention(loginChk, com_idnum, company_name, company_id, obj) {
	if (loginChk != "1") {
		var result = confirm("����ȸ�� �α��� �� �̿밡���մϴ�. �α����Ͻðڽ��ϱ�?");

		if(result) {
			location.href = '/my/login.asp?redir=' + location.pathname;
		}
	}
	else {
		$.ajax({
			type: "POST"
			, url: "/jobs/attention.asp"
			, data: { com_idnum: com_idnum, company_name: escape(company_name), company_id: company_id }
			, dataType: "html"
			, async: true
			, success: function (data) {
				if (data == "1") {
					alert("���ɱ���� �߰��Ǿ����ϴ�.");
					$(obj).addClass('on');
				}
				else if (data == "2") {
					alert("���ɱ���� �����߽��ϴ�.");
					$(obj).removeClass('on');
				}
				else if (data == "0") {
					alert("���ɱ���߰� �����߽��ϴ�.");
					return false;
				}
			}
			, error: function (XMLHttpRequest, textStatus, errorThrown) {
				alert(textStatus);
			}
		});
	}
}

/*
-----------------------------------------------------------------------
-- �α���
-----------------------------------------------------------------------
*/
function goLogin(loginChk, isTargetObj, isSelfClose, location_url, popupName)
{	
	var loginUrl = '';
	var redir = escape(location.href);
	if(isTargetObj) redir = escape(isTargetObj.location.href);
	if(location_url) redir = escape(location_url);
	//alert(loginChk)
	switch (loginChk)
	{
		case 1 :
			loginUrl = '/login/login.asp?redir=';
			break;

		case 2 :
			loginUrl = '/login/login.asp?redir=';
			break;

		default :
			loginUrl = '/my/login.asp?redir=';
			break;
	}

	if(popupName){
		var pop = window.open(loginUrl + redir, popupName);
		pop.focus();
	}else{
		if(loginUrl && !isTargetObj) location.href = loginUrl + redir;
		if(loginUrl && isTargetObj) isTargetObj.location.href = loginUrl + redir;
		if(isSelfClose) self.close();
	}
}