//�����ð� radio disable
function fn_interview_time_disable() {
	$('input[name="set_interview_time"]').each(function() {
		//$(this).attr('disabled', true);
		$(this).parent().attr('disabled', true);
		$(this).parent().attr('readonly', true);	
		$(this).parent().addClass('disable');
		$(this).parent().removeClass('sel');
	});

	radioboxFnc();//�����ڽ�
}

//�����ð� disable reset
function fn_interview_time_disable_reset(_val) {
	var time_val = _val.split(",");

	$('input[name="set_interview_time"]').each(function() {
		for (var i=0; i<time_val.length; i++) {
			if (time_val[i] == this.value) {
				$(this).parent().attr('disabled', false);
				$(this).parent().attr('readonly', false);
				$(this).parent().removeClass('disable');
				$(this).parent().removeClass('sel');
			}
		}
		//this.checked = false;
	});

	radioboxFnc();
}

//���� ��û�� �����ð� üũ
function fn_chk_user_interview_time() {
	var consultant_id = $('#set_consultant_id').val();
	var consultant_day = $('#set_consultant_day').val();

	if (consultant_id == "" || consultant_day == "") {
		return;
	}

	$.ajax({
		url: "./ajax_get_consulting_apply.asp",
		type: "POST",
		dataType: "text",
		data: ({
			"consultant_id": consultant_id,
			"consultant_day": consultant_day,
		}),
		success: function (data) {
			var time_val = data.split(",");

			$('input[name="set_interview_time"]').each(function() {
				for (var i=0; i<time_val.length; i++) {
					if (time_val[i] == this.value) {
						$(this).parent().attr('disabled', true);
						$(this).parent().attr('readonly', true);
						$(this).parent().removeClass('disable');
						$(this).parent().addClass('sel');
					}
				}
				//this.checked = false;
			});

			radioboxFnc();
		},
		error: function (req, status, err) {
			alert("ó�� ���� ������ �߻��Ͽ����ϴ�.\n" + err);
		}
	});

}

//�����ð� radio ���� �ʱ�ȭ
function fn_interview_time_reset() {
	$('input[name="set_interview_time"]').each(function() {
		this.checked = false;
	});

	radioboxFnc();//�����ڽ�
}

//�����ð� ����Ŭ��
function fn_time_set(_obj) {
	var set_day = $('#set_consultant_day').val();
	var set_time = $(_obj).parent().next().html().substring(0, 5);

	if (set_day == "") {
		return;
	} else {
		var today_date = new Date();
		var set_date = new Date(set_day.split("-")[0], set_day.split("-")[1] -1, set_day.split("-")[2], set_time.split(":")[0], set_time.split(":")[1]);

		if (set_date < today_date) {			
			alert("����ð� ������ �ð��� ������ �Ұ����մϴ�.");
			fn_interview_time_reset();
		}
	}
}

/*
----------------------------------------------------------------
ä�������»� ����
----------------------------------------------------------------
*/

//ä���� �����ð� disable �ʱ�ȭ
function fn_consult_time_disable_reset() {
	$('input[name="set_interview_time"]').each(function() {
		//$(this).attr('disabled', true);
		$(this).parent().attr('disabled', false);
		$(this).parent().attr('readonly', false);
		$(this).parent().removeClass('disable');
		$(this).parent().removeClass('sel');
	});
	radioboxFnc();//�����ڽ�
}

// ���� ��û�� ��� �ð� üũ
function fn_chk_user_consult_time() {
	var consultant_id = $('#set_interview_id').val();
	var consultant_day = $('#set_interview_day').val();

	if (consultant_id == "" || consultant_id == null || consultant_day == "" || consultant_day == null) {
		return;
	}

	$.ajax({
		url: "./ajax_get_consult_cnt.asp",
		type: "POST",
		dataType: "text",
		data: ({
			"gubun": "U",
			"consultant_id": consultant_id,
			"consultant_day": consultant_day,
		}),
		success: function (data) {
			var time_val = data.split(",");
			$('input[name="set_interview_time"]').each(function() {
				for (var i=0; i<time_val.length; i++) {
					if (time_val[i] == this.value) {
						$(this).parent().removeClass('disable');
						$(this).parent().addClass('sel');
					}
				}
			});
			radioboxFnc();
		},
		error: function (req, status, err) {
			//alert("ó�� ���� ������ �߻��Ͽ����ϴ�.\n" + err);
		}
	});
}

// ȸ�� ��� ���� �ð� üũ
function fn_chk_com_consult_time() {
	var consultant_id = $('#set_interview_id').val();
	var consultant_day = $('#set_interview_day').val();
	
	if (consultant_id == "" || consultant_id == null || consultant_day == "" || consultant_day == null) {
		return;
	}

	$.ajax({
		url: "./ajax_get_consult_cnt.asp",
		type: "POST",
		dataType: "text",
		data: ({
			"gubun": "C",
			"consultant_id": consultant_id,
			"consultant_day": consultant_day,
		}),
		success: function (data) {
			var time_val = data.split(",");

			$('input[name="set_interview_time"]').each(function() {
				for (var i=0; i<time_val.length; i++) {
					if (time_val[i] == this.value) {
						$(this).parent().attr('disabled', true);
						$(this).parent().attr('readonly', true);
						$(this).parent().addClass('disable');
						$(this).parent().removeClass('sel');
					}
				}
			});
			radioboxFnc();
		},
		error: function (req, status, err) {
			alert("ó�� ���� ������ �߻��Ͽ����ϴ�.\n" + err);
		}
	});
}

//�����ð� ����Ŭ��
function fn_com_time_set(_obj) {
	var set_day = $('#set_interview_day').val();
	var set_time = $(_obj).parent().next().html().substring(0, 5);

	if (set_day == "") {
		return;
	} else {
		var today_date = new Date();
		var set_date = new Date(set_day.split("-")[0], set_day.split("-")[1] -1, set_day.split("-")[2], set_time.split(":")[0], set_time.split(":")[1]);

		if (set_date < today_date) {			
			alert("����ð� ������ �ð��� ������ �Ұ����մϴ�.");
			fn_interview_time_reset();
		}
	}
}