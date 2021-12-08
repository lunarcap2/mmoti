
//������ �о� ����
function fn_sel_consultant(_val) {

	//��¥ �� �ð� �ʱ�ȭ
	$('#set_consultant_day').val("");
	$('#sel_consDay').val("");
	$('#set_consDay_txt').text("������ ���� ����");	
	$("#comp_cmmt").hide();

	fn_interview_time_reset();

	// ������ ��û�� ���� �Է� ���� ���� ó�� 
	$("#pop_request_consulting").hide();

	$.ajax({
		url: "./ajax_get_schedule.asp",
		type: "POST",
		dataType: "text",
		data: ({
			"consultant_id": _val,
		}),
		success: function (data) {
			$('#set_consultant_id').val(_val);
			fn_interview_time_disable();

			if (data == null || data == "") {
				$('#set_consultant_id').val("");
				alert("�ش� �������� ��û ������ ��¥�� �����ϴ�.");
			}
		},
		error: function (req, status, err) {
			alert("ó�� ���� ������ �߻��Ͽ����ϴ�.\n" + err);
		}
	});
}


//��¥����
function day_btn_click(obj) {
	var day_value	= $(obj).val();

	if (day_value <= todayToString) {
		alert("������ ������ ���� ��¥�� ������ �Ұ����մϴ�.");
		return false;
	}

	var consultant_id = $('#set_consultant_id').val();
	if (consultant_id == "") {
		alert("��� �� �߿��� ��û�Ͻ� �������� ���� ������ �ּ���.");
		return false;
	}

	//���� Ŭ����
	$(obj).addClass('on');
	$('.day_btn').not(obj).removeClass('on');

	//���ó�¥ ������
	$('#set_consultant_day').val(day_value);

	//�ð� �ʱ�ȭ
	fn_interview_time_reset();
	
	//�ش� ��¥�� �ð��� ��������
	$.ajax({
		url: "./ajax_get_schedule_time.asp",
		type: "POST",
		dataType: "text",
		data: ({
			"consultant_id": consultant_id,
			"consultant_day": day_value,
		}),
		success: function (data) {
			$('#str_set_interview_time').val(data);
			fn_interview_time_disable();
			fn_interview_time_disable_reset(data);
			fn_chk_user_interview_time();
		},
		error: function (req, status, err) {
			alert("ó�� ���� ������ �߻��Ͽ����ϴ�.\n" + err);
		}
	});
}


//���� ��û�� �����ð� üũ
function fn_chk_user_interview_time() {
	var consultant_id	= $('#set_consultant_id').val();
	var consultant_day	= $('#set_consultant_day').val();

	if (consultant_id == "" || consultant_id == null || consultant_day == "" || consultant_day == null) {
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
						$(this).parent().addClass('sel');
						//$(this).parent().next().children("p").text("����");
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


//�����ð� disable reset
function fn_interview_time_disable_reset(_val) {
	var time_val = _val.split(",");
	$('input[name="set_interview_time"]').each(function() {
		for (var i=0; i<time_val.length; i++) {
			if (time_val[i] == this.value) {
				$(this).parent().attr('disabled', false);
				$(this).parent().attr('readonly', false);
				$(this).parent().removeClass('disable');
				$(this).attr('disabled', false);
			}
		}
	});

	radioboxFnc();
}


//�����ð� radio ���� �ʱ�ȭ
function fn_interview_time_reset() {
	$('input[name="set_interview_time"]').each(function() {
		this.checked = false;
		$(".sel_area").children("p").text("���� �� �ð��� ������ �ּ���.");
	});
	radioboxFnc();//�����ڽ�
}


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


//�����ð� ����Ŭ��
function fn_time_set(_obj) {
	var set_day			= $('#set_consultant_day').val();
	var set_time		= $(_obj).parent().next().html().substring(0, 5);
	var set_time_full	= $(_obj).parent().next().html();

	if (set_day == "") {
		return;
	} else {
		var today_date	= new Date();
		var set_date	= new Date(set_day.split("-")[0], set_day.split("-")[1] -1, set_day.split("-")[2], set_time.split(":")[0], set_time.split(":")[1]);

		if (set_date < today_date) {
			alert("����ð� ������ �ð��� ������ �Ұ����մϴ�.");
			fn_interview_time_reset();
			$(".sel_area").children("p").text("���� �� �ð��� ������ �ּ���.");
		}else{
			$(".sel_area").children("p").text("��û�� : "+set_day+" / �ð� : "+set_time_full+"");
		}
	}
}
