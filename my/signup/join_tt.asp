<%@codepage="949" language="VBScript"%>

<!--#include virtual = "/common/common.asp"-->
<!--#include virtual = "/include/header/header.asp"-->

<%
'--------------------------------------------------------------------
'   Comment		: ����ȸ�� ����
' 	History		:
'---------------------------------------------------------------------
Session.CodePage  = 949			'�ѱ�
Response.CharSet  = "euc-kr"	'�ѱ�
Response.AddHeader "Pragma","no-cache"
Response.AddHeader "cache-control", "no-staff"
Response.Expires  = -1

If Request.ServerVariables("HTTPS") = "off" Then
	Response.redirect "https://"& Request.ServerVariables("HTTP_HOST") & Request.ServerVariables("URL")
End If

If request.Cookies(site_code & "WKP_F")("id") <>"" Then
	Response.Write "<script language=javascript>"&_
		"alert('�α��� ���¿����� �ش� �������� ������ �� �����ϴ�.\n�α׾ƿ� �� �̿� �ٶ��ϴ�.');"&_
		"location.href='/';"&_
		"</script>"
	response.End
End If
%>
<script type="text/javascript">
	// SMS ���� ��ȣ ����
	/* start */
	function fnAuthSms() {
		if ($("#mobileAuthNumChk").val() == "4") {
			alert("������ �Ϸ�Ǿ����ϴ�.");
			return;
		}

		$("#hd_idx").val("");

		var strEmail;
		var contact = $("#txtPhone").val();

		if (Authchk_ing) {
			alert("ó���� �Դϴ�. ��ø� ��ٷ� �ּ���.");
		} else {
			if(contact=="��-�� �����ϰ� ���ڸ� �Է��� �ּ���."){
				contact="";
			}

			if(contact==""){
				alert("����ó�� �Է��� �ּ���.");
				$("#txtPhone").focus();
				return;
			}

			if(contact.length<10){
				alert("��Ȯ�� ����ó�� �Է��� �ּ���.");
				$("#txtPhone").focus();
				return;
			}
			else {
				Authchk_ing = true;

				var strUrl = "https://app.career.co.kr/sms/career/Authentication";

				var parm = {};

				parm.authCode	= "1";		// sms:1 | email:2
				parm.authvalue	= $("#txtPhone").val();		// �ڵ��� no( - �� �Է� �ص� �ǰ� ���ص� �˴ϴ�.)
				parm.sitename	= "<%=site_short_name%>";	// sms �߼۽� �ش� �������� �Է� �˴ϴ�.
				parm.sitecode	= "37";		// sitecode(�� �ش� ����Ʈ �ڵ带 �Է��ϼ���) �߼� log �� email �߼۽� �����մϴ�. => �ڵ� ����(Ŀ���� : 2, �ڶ�ȸ : 37)
				parm.memkind	= "����";
				parm.ip			= "";		// ���� IP
				parm.callback	= "jsonp_sms_callback";

				$("#aMobile").text("������ȣ ������");
				$.ajax({
					url: strUrl
					, dataType: "jsonp"
					, type: "post"
					, data: parm
					, success: function (data) {
						//alert("sccess : " + data.length);
					}
					, error: function (jqXHR, textStatus, errorThrown) {
						//alert(textStatus + ", " + errorThrown);
					}
				});
			}
		}
	}

	// Result ó���� �̰����� �մϴ�.
	function jsonp_sms_callback(data) {
		Authchk_ing = false;
		if ($.trim(data.result) == "true") {
			$("#mobileAuthNumChk").val("1");

			$("#phone_box").hide();
			$("#timeCntdown").show();
			fnDpFirst();
			fncDpTm(); //ī��Ʈ

			$("#hd_idx").val(data.result_idx);
			alert("������ȣ�� �߼۵Ǿ����ϴ�.");
			$("#rsltAuthArea").show();
			$("#mobileAuthNumber").val("");
			$("#mobileAuthNumber").focus();
			$("#hd_kind").val("1");
		} else {
			$("#timeCntdown").hide();
			$("#rsltAuthArea").hide();
			$("#emailAuthNumChk").val("0");
			alert("������ȣ �߼��� �����Ͽ����ϴ�.");
		}
	}
	/* end */

	// ������ȣ Ȯ��
	/* start */
	function fnAuth() {
		if ($("#hd_kind").val() == "1" && $("#mobileAuthNumChk").val() == "4") {
			alert("������ �Ϸ�Ǿ����ϴ�.");
			return;

		} else if ($.trim($("#hd_idx").val()) == "") {
			alert("������ȣ�� ���� �ʽ��ϴ�. ������ȣ�� Ȯ���� �ּ���.");
			return;
		}

		$("#mobileAuthNumber").val($.trim($("#mobileAuthNumber").val()));
		if  ($("#hd_kind").val() == "1") {
			if ($.trim($("#mobileAuthNumber").val()) == "") {
				alert("������ȣ�� �Է��� �ּ���.");
				$("#mobileAuthNumber").focus();
				return;
			}
		}

		var strUrl	= "https://app.career.co.kr/sms/career/AuthenticationResult";
		var parms	= {};

		var strAuthKey = "";
		if ($("#hd_kind").val() == "2") {
			strAuthKey = $("#emailAuthNumber").val();
		} else if ($("#hd_kind").val() == "1") {
			strAuthKey = $("#mobileAuthNumber").val();
		} else {
			return;
		}

		if ($.trim($("#hd_idx").val()) == "" || ($.trim($("#emailAuthNumber").val()) == "" && $.trim($("#mobileAuthNumber").val()) == "")) {
			return;
		}

		parms.authCode	= $("#hd_kind").val();	// sms:1 | email:2

		parms.authvalue	= strAuthKey;			// �߼۵� ���� KEY Value

		parms.idx		= $("#hd_idx").val();	// �߼۵� ���� ��ȣ
		parms.callback	= "jsonp_result_callback";
		$.ajax({
			url: strUrl
				, dataType: "jsonp"
				, type: "post"
				, data: parms
				, success: function (data) {
					//alert("sccess : " + data.length);
				}
				, error: function (jqXHR, textStatus, errorThrown) {
					//alert(textStatus + ", " + errorThrown);
				}
		});
	}

	//Result ó���� �̰����� �մϴ�.
	function jsonp_result_callback(data) {
		if ($("#hd_kind").val() == "1") {
			if ($.trim(data.result_idx) == "Y") {
				$("#mobileAuthNumChk").val("4");
				$("#rsltMsg1").show();
				$("#authproc").val("1");
				$("#timeCntdown").hide();
				$("#rsltMsg2").hide();
			} else {
				$("#mobileAuthNumChk").val("3");
				$("#rsltMsg1").hide();
				$("#timeCntdown").show();
				$("#rsltMsg2").show();
			}
		}
	}
	/* end */

	var emailchk_ing	= false;
	var Authchk_ing		= false;

	var min = 60;
	var sec = 60;
	var ctm;			// ǥ�� �ð�
	var inputtime = 3;	// �Էº�
	var tstop;			// Ÿ�̸� ����

	Number.prototype.dptm = function () { return this < 10 ? '0' + this : this; } //�п� "0" �ֱ�

	function fnDpFirst() {
		clearTimeout(tstop);
		ctm = sec * inputtime;
	}

	function fncDpTm() {
		var cmi = Math.floor((ctm % (min * sec)) / sec).dptm();
		var csc = Math.floor(ctm % sec).dptm();

		//document.getElementById("ctm1").innerText = cmi + ' : ' + csc; //�� ������
		//document.getElementById("").innerText = '�����ð� ' + cmi + ' : ' + csc; //�� ������
		$("#timeCntdown").text('(' + cmi + ' : ' + csc + ")");
		if ((ctm--) <= 0) {
			ctm = sec * inputtime;
			clearTimeout(tstop);
			//�����۹�ư
			//�����ð� �ʰ� meassage
		}
		else {
			tstop = setTimeout("fncDpTm()", 1000);
		}
	}

	// ������ȣ ���� �Լ� ȣ��
	function fnAuthNoChk(){
		fnAuth();
	}

	// �޴�����ȣ �ߺ� ���� ����
	function fn_chkJoin(){
		if($("#txtPhone").val()=="��-�� �����ϰ� ���ڸ� �Է��� �ּ���."){
			$("#txtPhone").val("");
		}

		if($("#txtPhone").val()==""){
			alert("����ó�� �Է��� �ּ���.");
			$("#txtPhone").focus();
			return;
		}

		if($("#txtPhone").val().length<10){
			alert("��Ȯ�� ����ó�� �Է��� �ּ���.");
			$("#txtPhone").focus();
			return;
		} else {
			$.ajax({
				type: "POST"
				, url: "phone_CheckAll.asp"
				, data: { user_phone: $("#txtPhone").val() }
				, dataType: "text"
				, async: true
				, success: function (data) {
					// ���� ��ϵ� �޴�����ȣ�� �����ϸ� X, ������ O
					if (data.trim() == "X") {
						alert("�Է��Ͻ� �޴�����ȣ�� ȸ�� ���Ե� ������ �����մϴ�.\n���̵� ã�⸦ �̿��Ͽ� ���� �����Ͻ� ������ Ȯ���� �ּ���.");
						return;
					} else {
						fnAuthSms();
					}
				}
				, error: function (XMLHttpRequest, textStatus, errorThrown) {
					alert(XMLHttpRequest.responseText);
				}

			});
		}
	}

	// �Է� �� üũ
	function fn_sumbit(){
		var txtId					= $("#txtId").val();								// ���̵�
		var txtPass					= $("#txtPass").val();								// ���
		var txtPassChk				= $("#txtPassChk").val();							// ���Ȯ��
		var	txtName					= $("#txtName").val();								// �̸�
		var txtBirth				= $('#txtBirth').val();								// �������
		var gender					= $('input[name="gender"]:checked').val();			// ����(1:����, 2:����)
		var selFinalSchType			= $('#sel_finalSchType option:selected').val();		// �����з�(1:����, 2:�ʴ���, 3:����, 4:����, 5:���п���)
		var txtEmail				= $("#txtEmail").val();								// �̸���
		var txtPhone				= $("#txtPhone").val();								// �޴���
		var chkMilitaryPersonnel	= $('#chk_military_personnel').is(':checked');		//true: ������, false: �������ƴ�

		/*�������϶� �Է��� ��-S*/
		var militaryPersonnelCorps	= $('#military_personnel_corps').val();		//�ҼӺδ��
		var militaryPersonnelNumber	= $('#military_personnel_number').val();	//����
		/*�������϶� �Է��� ��-E*/

		/*�������� �ƴҶ� �Է��� ��-S*/
		var militaryGroup	= $('#military_group option:selected').val();		//����(1:����, 2:�ر�, 3:����, 4:�غ���)
		var militaryCorps	= $('#military_corps').val();						//�ҼӺδ��
		var militaryRank	= $('input[name="military_rank"]:checked').val();	//��޹� ��å(1:�̺�, 2:�Ϻ�, 3:��, 4:����, 5:�ϻ�, 6:�߻�, 7:���, 8:����, 9:����, 10:����, 11:����, 12:����, 13:�ҷ�, 14:�߷�, 15:���)
		var militaryNumber	= $('#military_number').val();						//����
		var militaryEndDT	= $('#military_end_date').val();					//������
		/*�������� �ƴҶ� �Է��� ��-E*/

		/*�������,������ ������� �߰�-S*/
		var hopearea	= $('input[name="hope_area"]:checked').val();	//�������
																		//���� ��õ��	- 1:����(����), 34:����(����), 2:����(����), 6:���� ����, 3:���� �Ϻ�, 4:���� ����, 5:���� ����, 41:����(���ſ���), 71:��õ �־�
																		//����		- 36:��� ���, 50:��� ����, 27:��� �Ȼ�, 7:��� �Ⱦ�, 26:��� ��õ, 9:��� ����
																		//��û��		- 35:õ�� 
																		//������		- 43:�뱸 ����, 42:�뱸, 31:�λ�, 11:�λ� ����, 70:�λ� ����
		var hopeCheck	= $('input[name="hopeCheck"]:checked').val();	//��� ��� �������
		/*�������,������ ������� �߰�-E*/

		var agreeCheck	= $('input[name="agreeCheck"]:checked').val();	// �̿��� �� �������� ���� ����


		if(txtId==""){
			alert("���̵� �Է��� �ּ���.");
			$("#txtId").focus();
			return;
		}

		if($("#id_box").text()!="��� ������ ���̵��Դϴ�."){
			alert("���̵� �ٽ� Ȯ���� �ּ���.");
			$("#txtId").focus();
			return;
		}

		if(txtPass==""){
			alert("��й�ȣ�� �Է��� �ּ���.");
			$("#txtPass").focus();
			return;
		}

		if($("#pw_box").text()!=""){
			alert("�Է��Ͻ� ��й�ȣ�� ���Ȼ� �ſ� ����մϴ�.\n8~32�ڱ��� ����, ����, Ư������ ���� ��������\n���̵�� ������ ���ڿ��� �Է��� �ּ���.");
			$("#txtPass").focus();
			return;
		}

		if(txtPassChk==""){
			alert("��й�ȣ Ȯ�ζ��� �Է��� �ּ���.");
			$("#txtPassChk").focus();
			return;
		}

		if(txtPassChk!=txtPass){
			alert("��й�ȣ�� ��й�ȣ Ȯ�ζ��� �Է��� ������\n��ġ���� �ʽ��ϴ�. �ٽ� Ȯ���� �ּ���.");
			$("#txtPassChk").focus();
			return;
		}

		if(txtName==""){
			alert("�̸��� �Է��� �ּ���.");
			$("#txtName").focus();
			return;
		}

		if(txtBirth == '') {
			alert('��������� �Է����ּ���.');
			$('#txtBirth').focus();
			return;
		}
		else {
			if(txtBirth.length < 8) {
				alert('��������� ��Ȯ�ϰ� �Է��� �ּ���.\n(ex: ������� = 2002�� 1�� 3�� �� 20020103)');
				$('#txtBirth').focus();
				return;
			}

			var chkBirth		= txtBirth;
			chkBirth			= chkBirth.replace(".", "");
			chkBirth			= chkBirth.replace(".", "");
			var rxDatePattern	= /^(\d{4})(\d{1,2})(\d{1,2})$/;	// Declare Regex
			var dtArray			= chkBirth.match(rxDatePattern);	// is format OK?

			// Checks for yyyymmdd format.
			dtYear	= dtArray[1];
			dtMonth = dtArray[2];
			dtDay	= dtArray[3];

			var today = new Date();
			var year  = today.getFullYear(); // ���翬��
			var month = today.getMonth()+1;  // �����

			/*if (dtYear < 1940 || dtYear > year){
				alert("�Է��Ͻ� ��������� ���� ������ ��ȿ���� �ʽ��ϴ�.\n(1940~"+year+"�⵵ ������ ���ڸ� �Է� ����)");
				return false;
			}

			if (dtYear < 1970 || dtYear > 2006){
				alert("�Է��Ͻ� ��������� ���� ������ ��ȿ���� �ʽ��ϴ�.\n(1970~2006�⵵ ������ ���ڸ� �Է� ����)");
				$('#txtBirth').focus();
				return false;
			}
			*/

			if (dtYear == year && dtMonth > month){
				alert("�������ں��� �̷��� ��¥�� ������� ������ �ԷµǾ����ϴ�.\n�ٽ� Ȯ���� �ּ���.");
				$('#txtBirth').focus();
				return false;
			}

			if (dtMonth < 1 || dtMonth > 12){
				alert("�Է��Ͻ� ��������� �� ���� ������ ��ȿ���� �ʽ��ϴ�.");
				$('#txtBirth').focus();
				return false;
			}

			if (dtDay < 1 || dtDay > 31){
				alert("�Է��Ͻ� ��������� ���� ������ ��ȿ���� �ʽ��ϴ�.");
				$('#txtBirth').focus();
				return false;
			}

			if (dtMonth == 2) {
				var isleap = (dtYear % 4 == 0 && (dtYear % 100 != 0 || dtYear % 400 == 0));
				if (dtDay > 29 || (dtDay == 29 && !isleap)){
					var strFebDay;
					if (isleap == true){
						strFebDay = "29";
					}else{
						strFebDay = "28";
					}

					alert(dtYear+"�� 2���� ������ ��¥�� "+strFebDay+"�� �Դϴ�.");
					$('#txtBirth').focus();
					return false;
				}
			}
		}

		if(typeof gender == 'undefined' || gender == '' || gender == null) {
			alert('������ �������ּ���.');
			$('[name="gender"]').focus();
			return;
		}

		if(selFinalSchType == '') {
			alert('�����з��� �������ּ���.');
			$('#sel_finalSchType').focus();
			return;
		}

		if($("#txtEmail").val() == "") {
			alert("�̸����� �Է��� �ּ���.");
			$("#txtEmail").focus();
			return;
		}

		if($("#mail_box").text()=="�߸��� �̸��� �����Դϴ�."){
			alert("�̸����� �ٽ� Ȯ���� �ּ���.");
			$("#mail_box").focus();
			return;
		}

		if(txtPhone==""){
			alert("�޴�����ȣ�� �Է��� �ּ���.");
			$("#txtPhone").focus();
			return;
		}

		if ($("#mobileAuthNumChk").val() != "4") {
			alert("���� Ȯ���� ���� �޴�����ȣ�� ������ �ּ���.");
			$("#txtPhone").focus();
			return;
		}

		//������ ���ý�
		if(chkMilitaryPersonnel) {
			if(militaryPersonnelCorps == '') {
				alert('�ҼӺδ���� �Է��� �ּ���.');
				$('#military_personnel_corps').focus();
				return;
			}

			if(militaryPersonnelNumber == '') {
				alert('������ �Է��� �ּ���.');
				$('#military_personnel_number').focus();
				return;
			}

			//������ �Է°� üũ(0: �߸��ԷµȰ�, 1: �����Է�)
			var chk_val = 0;

			$.ajax({
				type: "POST"
				, url: "militaryPersonnel_chk.asp"
				, data: { txtPhone: txtPhone, txtName: escape(txtName), militaryPersonnelNumber: militaryPersonnelNumber }
				, dataType: "text"
				, async: false
				, success: function (data) {
					chk_val = data;
				}
				, error: function (XMLHttpRequest, textStatus, errorThrown) {
					//alert(XMLHttpRequest.responseText);
				}
			});

			if(chk_val == 0) {
				alert('�߸��� ���� �Է��Ͽ����ϴ�.\n�̸�, �޴��� ��ȣ, ������ Ȯ���� �ּ���.');
				return false;
			}
		}
		//������ ���þƴҶ�
		else {
			if(militaryGroup == '') {
				alert('������ ������ �ּ���.');
				$('#military_group').focus();
				return;
			}

			if(militaryCorps == '') {
				alert('�ҼӺδ���� �Է��� �ּ���.');
				$('#military_corps').focus();
				return;
			}

			if(typeof militaryRank == 'undefined' || militaryRank == '' || militaryRank == null) {
				alert('��� �� ��å�� ������ �ּ���.');
				$('#military_rank').focus();
				return;
			}

			if(militaryNumber == '') {
				alert('������ �Է��� �ּ���.');
				$('#military_number').focus();
				return;
			}

			if(militaryEndDT == '') {
				alert('�������� �Է��� �ּ���.');
				$('#military_end_date').focus();
				return;
			}
		}

		if(typeof hopearea == 'undefined' || hopearea == '' || hopearea == null) {
			alert('���Ȱ�� ��� ������ ������ �ּ���.');
			$('input[name="hope_area"]').focus();
			return;
		}

		if(typeof hopeCheck == 'undefined' || hopeCheck == '' || hopeCheck == null) {
			alert('��� ���(���İ���) ��� ���θ� ������ �ּ���.');
			$('input[name="hopeCheck"]').focus();
			return;
		}

		if (agreeCheck != "1"){
			alert('�������� �����ø� �ڶ�ȸ ����Ʈ �̿��� �Ұ��մϴ�.');
			$('[name=agreeCheck]').focus();
			return;
		}

		var obj=document.frm1;
		if(confirm('�Է��Ͻ� ������ ȸ�� ���� �Ͻðڽ��ϱ�?')) {
			obj.method = "post";
			obj.action = "join_individual_proc.asp";
			obj.submit();
		}
	}

	function onlyNumber(event){
		event = event || window.event;
		var keyID = (event.which) ? event.which : event.keyCode;
		if ( (keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105) || keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 )
			return;
		else
			return false;
	}

	function removeChar(event) {
		event = event || window.event;
		var keyID = (event.which) ? event.which : event.keyCode;
		if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 )
			return;
		else
			event.target.value = event.target.value.replace(/[^0-9]/g, "");
	}

	/*���̵� �ߺ� üũ ����*/
	function fn_checkID() {
		$("#txtId").val($("#txtId").val().toLowerCase());

		$("#id_box").text("");
		$("#id_check").val("0");

		var checkNumber		= $("#txtId").val().search(/[0-9]/g);	// ���� �Է� üũ
		var checkEnglish	= $("#txtId").val().search(/[a-z]/ig);	// ���� �Է� üũ

		if($("#txtId").val() == ""){
			$("#id_box").text("���̵� �Է��� �ּ���.");
			$("#txtId").focus();
			return;
		}else if(!Validchar($("#txtId").val(), num + alpha)){
			$("#id_box").text("���̵�� �ѱ� �� Ư�����ڸ� �������� �ʽ��ϴ�. �ٽ� �Է��� �ּ���.");
			$("#txtId").focus();
			return;
		}else if($("#txtId").val().length < 5){
			$("#id_box").text("���̵�� �ּ� 5�� �̻��̾�� �մϴ�.");
			return;
		}else if(checkNumber <0 || checkEnglish <0){
			$("#id_box").text("������ ���ڸ� ȥ���Ͽ� �Է��� �ּ���.");
			return;
		}else{
			if (/(\w)\1\1\1/.test($("#txtId").val())){	// �������� ���� 4���� �̻� ��� ����
				$("#id_box").text("������ ���� ���� 4���� �̻��� ��� �����մϴ�.");
				return;
			} else {
				$.ajax({
					type: "POST"
					, url: "Id_CheckAll.asp"
					, data: { user_id: $("#txtId").val() }
					, dataType: "text"
					, async: true
					, success: function (data) {
						// ���� ��ϵ� ���̵� �����ϸ� X, ������ O
						if (data.trim() == "X") {
							$("#id_box").addClass('bad').removeClass('good');
							$("#id_box").text("Ż���� ���̵� �Ǵ� �̹� ������� ���̵��, �̿��Ͻ� �� �����ϴ�.");
							return;
						} else {
							$("#id_check").val("1");
							$("#chk_id").val($("#txtId").val());
							$("#id_box").addClass('good').removeClass('bad');
							$("#id_box").text("��� ������ ���̵��Դϴ�.");
							return;
						}
					}
					, error: function (XMLHttpRequest, textStatus, errorThrown) {
						alert(XMLHttpRequest.responseText);
					}

				});
			}
		}
	}
	/*���̵� �ߺ� üũ ��*/

	/*��й�ȣ üũ ����*/
	function fn_checkPW() {
		var chk = false;
		var id	= $("#txtId").val();

		if ($('#txtPass').val().length == 0 ) {
			return;
		} else {
			if ($('#txtPass').val().length < 8 || $('#txtPass').val().length > 32) {
				$("#pw_box").text("��й�ȣ�� 8~32�� ������ ���˴ϴ�.");
				return false;
			}

			/*if (id != "" && $('#txtPass').val().search(id) > -1) {
				$("#pw_box").text("��й�ȣ�� ���̵� ���ԵǾ� �ֽ��ϴ�.");
				return false;
			}*/

			var pattern1 = /[0-9]/;		// ����
			var pattern2 = /[a-zA-Z]/;	// ����
			var pattern3 = /[~!@#$%^&*()_+|<>?:{}]/; // Ư������

			//if (!$('#txtPass').val().match(/([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~])|([!,@,#,$,%,^,&,*,?,_,~].*[a-zA-Z0-9])/)) {
			//if (!$('#txtPass').val().match(/^.*(?=.{6,20})(?=.*[0-9])(?=.*[a-zA-Z]).*$/)) {
			//if (!/^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,25}$/.test($('#txtPass').val())) {
			if(!pattern1.test($('#txtPass').val()) || !pattern2.test($('#txtPass').val()) || !pattern3.test($('#txtPass').val())) {
				$("#pw_box").text("��й�ȣ�� ����, ���� �� Ư�������� �������� �����ؾ� �մϴ�");
				return;
			}else{
				if($('#txtPass').val().search(id) > -1) {
					$("#pw_box").text("��й�ȣ�� ���̵� ���ԵǾ� �ֽ��ϴ�.");
					return false;
				}else{
					$("#pw_box").text("");
				}
			}
		}

		if ($('#txtPassChk').val().split(" ").join("") == "") {
			$("#pw_box2").text("��й�ȣ Ȯ���� �Է��� �ּ���.");
			return;
		}

		if ($('#txtPass').val() != $('#txtPassChk').val()) {
			$("#pw_box2").text("��й�ȣ�� ��ġ���� �ʽ��ϴ�.");
			return;
		} else {
			$("#pw_box").text("");
			$("#pw_box2").text("");
		}
		return chk;
	}
	/*��й�ȣ üũ ��*/

	/*�̸��� üũ ����*/
	function email_check( email ) {
		var regex=/([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
		return (email != '' && email != 'undefined' && regex.test(email));
	}

	// check when email input lost foucus
	function fn_checkMail() {
	  var email = $("#txtEmail").val();

	  // if value is empty then exit
	  if( email == '' || email == 'undefined') return;

	  // valid check
	  if(! email_check(email) ) {
		$("#mail_box").text("�߸��� �̸��� �����Դϴ�.");
		return false;
	  }
	  else {
		$("#mail_box").text("");
		return false;
	  }
	}
	/*�̸��� üũ ��*/

	// �Է°� üũ
	$(document).ready(function () {
		//$("#txtPass").val("");
		//$("#frm1")[0].reset();

		//���̵� �ߺ� üũ
		$("#txtId").bind("keyup keydown", function () {
			fn_checkID();
		});

		// ��� ��ȿ�� üũ
		$("#txtPass").bind("keyup keydown", function () {
			$(this).attr('type', 'password');
			fn_checkPW();
		});

		// ��� ��Ȯ�� ��ȿ�� üũ
		$("#txtPassChk").bind("keyup keydown", function () {
			fn_checkPW();
		});

		// �̸��� �ּ� ��ȿ�� üũ
		$("#txtEmail").bind("keyup keydown", function () {
			fn_checkMail();
		});
	});


	//�������� ��� ���ý� �Է��� ����
	function FN_chk_military_personnel(obj) {
		var v_bool = $(obj).is(':checked');

		/*�Է°� �ʱ�ȭ-S*/
		$('#contents').find('input[id^="military"]').val('');
		$('#military_group option:eq(0)').attr('selected',true);
		$('[name="military_rank"]').attr('checked',false);

		selectboxFnc();
		radioboxFnc();
		/*�Է°� �ʱ�ȭ-E*/

		if(v_bool) {
			$('#military_personnel').attr('style','display:block;');
			$('#military').attr('style','display:none;');
		}
		else {
			$('#military_personnel').attr('style','display:none;');
			$('#military').attr('style','display:block;');
		}
	}
</script>
</head>

<body>
	<!-- header -->
	<div id="header">
		<div class="header-wrap detail">
			<div class="detail_box">
				<a href="/">����</a>
				<p>ȸ������</p>
			</div>

		</div>
	</div>
	<!-- //header -->

	<!-- container -->
	<div id="contents" class="sub_page">
		<div class="contents">
			<form method="post" name="frm1" autocomplete="off">
				<input type="hidden" name="id_check" id="id_check" value="" /><!-- ���̵� ���� ����(0/1) -->
				<input type="hidden" name="chk_id" id="chk_id" value=""><!-- ���(�Է�) ���̵� -->
				<input type="hidden" name="hd_idx" id="hd_idx" value="" /><!-- ��ȣ���� idx -->
				<input type="hidden" name="mobileAuthNumChk" id="mobileAuthNumChk" value="0" />
				<input type="hidden" name="hd_kind" id="hd_kind" value="2" />
				<input type="hidden" name="authproc" id="authproc" value="" />

				<div class="signup_area">
					<div class="inputArea">
						<h4>ȸ������ �Է� <span class="req">(�ʼ��Է�)</span></h4>
						<div class="tb_area">
							<table class="tb">
								<colgroup>
									<col style="width:8.5rem"/>
									<col />
								</colgroup>
								<tbody>
									<tr>
										<th class="req">���̵�</th>
										<td>
											<div class="inp">
												<input type="text" id="txtId" name="txtId" class="txt placehd" placeholder="���̵� (5~12�� ����, ���� �Է�)" autocomplete="off" maxlength="12">
												<p class="txt" id="id_box"></p>
											</div>
										</td>
									</tr>
									<tr>
										<th class="req">��й�ȣ</th>
										<td>
											<div class="inp">
												<input type="password" id="txtPass" name="txtPass" class="txt placehd" maxlength="32" placeholder="��й�ȣ (8~32�� ����, ����, Ư������ �Է�)" autocomplete="new-password">
												<p class="txt" id="pw_box"></p>
												<input type="password" id="txtPassChk" name="txtPassChk" class="txt placehd" placeholder="��й�ȣ Ȯ��" autocomplete="new-password">
												<p class="txt" id="pw_box2"></p>
											</div>
										</td>
									</tr>
									<tr>
										<th class="req">�̸�</th>
										<td>
											<div class="inp">
												<input type="text" id="txtName" name="txtName" class="txt placehd" maxlength="10" placeholder="�̸� (�Ǹ��Է�)" autocomplete="off">
											</div>
										</td>
									</tr>
									<tr>
										<th class="req">�������</th>
										<td>
											<div class="inp">
												<input type="text" id="txtBirth" name="txtBirth" class="txt placehd" maxlength="8" placeholder="�������(YYYYMMDD)" autocomplete="off">
											</div>
										</td>
									</tr>
									<tr>
										<th class="req">����</th>
										<td>
											<div class="rdi_box">
												<label class="radiobox">
													<input class="rdi" name="gender" value="1" type="radio" style=""><span>����</span>
												</label>
												<label class="radiobox">
													<input class="rdi" name="gender" value="2" type="radio" style=""><span>����</span>
												</label>
											</div>
										</td>
									</tr>
									<tr>
										<th class="req">�����з�</th>
										<td>
											<div class="birth">
												<span class="selectbox" style="width:100%;">
													<span style="font-size:1rem; padding:0 0 0 0.5rem">�����з�</span>
													<select id="sel_finalSchType" name="sel_finalSchType" title="�����з�">
														<option value="">�����з�</option>
														<option value="1">����</option>
														<option value="2">�ʴ���</option>
														<option value="3">����</option>
														<option value="4">����</option>
														<option value="5">���п���</option>
													</select>
												</span><!-- .selectbox -->
											</div><!-- .birth -->
										</td>
									</tr>
									<tr>
										<th class="req">�̸���</th>
										<td>
											<div class="inp">
												<input type="text" id="txtEmail" name="txtEmail" class="txt placehd" maxlength="100" onchange="fn_checkMail();" placeholder="�̸��� �ּ� �Է�" autocomplete="off">
												<p class="txt" id="mail_box"></p>
											</div>
										</td>
									</tr>
									<tr>
										<th class="req">�޴��� ��ȣ</th>
										<td>
											<div class="inp btn2">
												<div class="sec">
													<input type="text" id="txtPhone" name="txtPhone" class="txt placehd" maxlength="11" placeholder="�޴��� ��ȣ �Է�" style="width:65%; padding:0;">
													<span class="num" id="timeCntdown" style="display:none;">(2:59)</span>
													<button type="button" id="aMobile" class="btn" onclick="fn_chkJoin(); return false;">������ȣ ����</button>
													<p class="txt" id="phone_box"></p>
												</div>
												<div id="rsltAuthArea" class="sec" style="display:none;">
													<input type="text" id="mobileAuthNumber" name="mobileAuthNumber" class="txt placehd" maxlength="6" placeholder="������ȣ�� �Է��� �ּ���" onkeyup="removeChar(event)" onkeydown="return onlyNumber(event)">
													<button type="button" class="btn blue" onclick="fnAuthNoChk(); return false;">Ȯ��</button>
													<p class="txt" id="rsltMsg1" style="display:none;">������ȣ�� ���� �Է� �ƽ��ϴ�.</p>
													<p class="txt" id="rsltMsg2" style="display:none;">������ȣ�� Ʋ���ϴ�.</p>
												</div>
											</div>
										</td>
									</tr>
								</tbody>
							</table>

							<label class="checkbox off checkbox1" for="chk_military_personnel">
								<input type="checkbox" id="chk_military_personnel" name="chk_military_personnel" class="chk" onclick="FN_chk_military_personnel(this);">
								<span>�������� ��� ����</span>
							</label>

							<!--������ ����-S-->
							<div id="military_personnel" style="display:none;">
								<h4>������ ��Ÿ���� �Է� <span class="req">(�ʼ��Է�)</span></h4>
								<table class="tb">
									<colgroup>
										<col style="width:8.5rem"/>
										<col />
									</colgroup>
									<tbody>
										<tr>
											<th class="req">�ҼӺδ��</th>
											<td>
												<div class="inp">
													<input type="text" class="txt placehd" id="military_personnel_corps" name="military_personnel_corps" placeholder="�ҼӺδ��" maxlength="100" style="width:100%;">
												</div>
											</td>
										</tr>

										<tr>
											<th class="req">����</th>
											<td>
												<div class="inp">
													<input type="text" class="txt placehd" id="military_personnel_number" name="military_personnel_number" placeholder="������ �Է��� �ּ���" maxlength="6" onkeyup="removeChar(event)" onkeydown="return onlyNumber(event)">
												</div>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
							<!--������ ����-E-->

							<!--������ ������ �ƴҶ�-S-->
							<div id="military">
								<h4>�� ���� �Է� <span class="req">(�ʼ��Է�)</span></h4>
								<table class="tb">
									<colgroup>
										<col style="width:8.5rem;"/>
										<col/>
									</colgroup>

									<tbody>
										<tr>
											<th class="req"><span style="">��������</span></th>
											<td>
												<div class="birth" id="birth">
													<span class="selectbox" style="width:100%;">
														<span style="font-size:1rem; padding:0 0 0 0.5rem">����</span>
														<select id="military_group" name="military_group" title="���� ����">
															<option value="">��������</option>
															<option value="1">����</option>
															<option value="2">�ر�</option>
															<option value="3">����</option>
															<option value="4">�غ���</option>
														</select>
													</span><!-- .selectbox -->
												</div><!-- .birth -->
											</td>
										</tr>
										<tr>
											<th class="req">�ҼӺδ��</th>
											<td>
												<div class="inp">
													<input type="text" class="txt placehd" id="military_corps" name="military_corps" placeholder="�ҼӺδ��" maxlength="100">
												</div>
											</td>
										</tr>
									</tbody>
								</table>

								<div class="sch_area">
									<h4>��� �� ��å����</h4>
									<table class="tb">
										<caption>��� �� ��å����</caption>
										<colgroup>
											<col style="width:8.5rem;" />
											<col />
										</colgroup>

										<tbody>
											<tr>
												<th class="th2 th2"><strong>�� ��</strong></th>
												<td class="td2 td2">
													<div class="rdi_box">
														<label class="radiobox">
															<input class="rdi" name="military_rank" value="1" type="radio"><span>�̺�</span>
														</label>
														<label class="radiobox">
															<input class="rdi" name="military_rank" value="2" type="radio"><span>�Ϻ�</span>
														</label>
														<label class="radiobox">
															<input class="rdi" name="military_rank" value="3" type="radio"><span>��</span>
														</label>
														<label class="radiobox">
															<input class="rdi" name="military_rank" value="4" type="radio"><span>����</span>
														</label>
													</div>
												</td>
											</tr>
											<tr>
												<th class="th3"><strong>�� ��</strong></th>
												<td class="td3">
													<div class="rdi_box">
														<label class="radiobox">
															<input class="rdi" name="military_rank" value="5" type="radio"><span>�ϻ�</span>
														</label>
														<label class="radiobox">
															<input class="rdi" name="military_rank" value="6" type="radio"><span>�߻�</span>
														</label>
														<label class="radiobox">
															<input class="rdi" name="military_rank" value="7" type="radio"><span>���</span>
														</label>
														<label class="radiobox">
															<input class="rdi" name="military_rank" value="8" type="radio"><span>����</span>
														</label>
														<label class="radiobox">
															<input class="rdi" name="military_rank" value="9" type="radio"><span>����</span>
														</label>
														<label class="radiobox">
															<input class="rdi" name="military_rank" value="10" type="radio"><span>����</span>
														</label>
														<label class="radiobox">
															<input class="rdi" name="military_rank" value="11" type="radio"><span>����</span>
														</label>
														<label class="radiobox">
															<input class="rdi" name="military_rank" value="12" type="radio"><span>����</span>
														</label>
														<label class="radiobox">
															<input class="rdi" name="military_rank" value="13" type="radio"><span>�ҷ�</span>
														</label>
														<label class="radiobox">
															<input class="rdi" name="military_rank" value="14" type="radio"><span>�߷�</span>
														</label>
														<label class="radiobox">
															<input class="rdi" name="military_rank" value="15" type="radio"><span>���</span>
														</label>
													</div>
												</td>
											</tr>
										</tbody>
									</table>
								</div><!-- sch_area -->

								<div class="sch_area">
									<table class="tb">
										<caption>����,�������Է� ���̺�</caption>
										<colgroup>
											<col style="width:8.5rem" />
											<col />
										</colgroup>

										<tbody>
											<tr>
												<th class="req">����</th>
												<td>
													<div class="inp">
														<input type="text" class="txt placehd" id="military_number" name="military_number" placeholder="������ �Է��� �ּ���" onkeyup="removeChar(event)" onkeydown="return onlyNumber(event)">
													</div>
												</td>
											</tr>
											<tr>
												<th class="req"><span>������</span></th>
												<td>
													<div class="datePick">
														<span>
															<input type="text" style="width:80%;" class="datepicker" id="military_end_date" name="military_end_date" placeholder="�������� ������ �ּ���" readonly>
															<button type="button" class="btncalendar dateclick">�������Է�</button>
														</span>
													</div>
												</td>
											</tr>
										</tbody>
									</table>
								</div><!-- sch_area -->
							</div>
							<!--������ ������ �ƴҶ�-S-->

							<div class="sch_area">
								<h4>���Ȱ�� ��� ����</h4>
								<table class="tb">
									<caption>���Ȱ�� ��� ����</caption>
									<colgroup>
										<col style="width:8.5rem;" />
										<col />
									</colgroup>

									<tbody>
										<tr>
											<th class="th2 th2"><strong>���� �� ��õ</strong></th>
											<td class="td2 td2">
												<div class="rdi_box">
													<label class="radiobox">
														<input class="rdi" name="hope_area" value="1" type="radio"><span>��������</span>
													</label>
													<label class="radiobox">
														<input class="rdi" name="hope_area" value="34" type="radio"><span>���� ����</span>
													</label>
													<label class="radiobox">
														<input class="rdi" name="hope_area" value="2" type="radio"><span>���� ����</span>
													</label>
													<label class="radiobox">
														<input class="rdi" name="hope_area" value="6" type="radio"><span>���� ����</span>
													</label>
													<label class="radiobox">
														<input class="rdi" name="hope_area" value="3" type="radio"><span>���� �Ϻ�</span>
													</label>
													<label class="radiobox">
														<input class="rdi" name="hope_area" value="4" type="radio"><span>���� ����</span>
													</label>
													<label class="radiobox">
														<input class="rdi" name="hope_area" value="5" type="radio"><span>���� ����</span>
													</label>
													<label class="radiobox">
														<input class="rdi" name="hope_area" value="41" type="radio"><span>����(���ſ���)</span>
													</label>
													<label class="radiobox">
														<input class="rdi" name="hope_area" value="71" type="radio"><span>��õ �־�</span>
													</label>
												</div>
											</td>
										</tr>
										<tr>
											<th class="th3"><strong>����</strong></th>
											<td class="td3">
												<div class="rdi_box">
													<label class="radiobox">
														<input class="rdi" name="hope_area" value="36" type="radio"><span>��� ���</span>
													</label>
													<label class="radiobox">
														<input class="rdi" name="hope_area" value="50" type="radio"><span>��� ����</span>
													</label>
													<label class="radiobox">
														<input class="rdi" name="hope_area" value="27" type="radio"><span>��� �Ȼ�</span>
													</label>
													<label class="radiobox">
														<input class="rdi" name="hope_area" value="7" type="radio"><span>��� �Ⱦ�</span>
													</label>
													<label class="radiobox">
														<input class="rdi" name="hope_area" value="26" type="radio"><span>��� ��õ</span>
													</label>
													<label class="radiobox">
														<input class="rdi" name="hope_area" value="9" type="radio"><span>��� ����</span>
													</label>
												</div>
											</td>
										</tr>
										<tr>
											<th class="th3"><strong>��û��</strong></th>
											<td class="td3">
												<div class="rdi_box">
													<label class="radiobox">
														<input class="rdi" name="hope_area" value="35" type="radio"><span>õ��</span>
													</label>
												</div>
											</td>
										</tr>
										<tr>
											<th class="th3"><strong>������</strong></th>
											<td class="td3">
												<div class="rdi_box">
													<label class="radiobox">
														<input class="rdi" name="hope_area" value="43" type="radio"><span>�뱸 ����</span>
													</label>
													<label class="radiobox">
														<input class="rdi" name="hope_area" value="42" type="radio"><span>�뱸</span>
													</label>
													<label class="radiobox">
														<input class="rdi" name="hope_area" value="31" type="radio"><span>�λ�</span>
													</label>
													<label class="radiobox">
														<input class="rdi" name="hope_area" value="11" type="radio"><span>�λ� ����</span>
													</label>
													<label class="radiobox">
														<input class="rdi" name="hope_area" value="70" type="radio"><span>�λ� ����</span>
													</label>
												</div>
											</td>
										</tr>
									</tbody>
								</table>
							</div><!-- sch_area -->

							<div class="sch_area as_hope">
								<h4 style="border-bottom:2px solid #000;">��� ���(���İ���) ��� ����</h4>
								<p>�� ���Ȱ�� ��� ���� �� ��� ���(���İ���) ��� ���δ� �Ѵ޿� �ִ� 2ȸ���� ���� �����մϴ�.
									������ ���θ� ����� �Ͻô��� �¶��� ��� �Խ����� ���� ���� ���� �ֽø� ��� ���簡 �亯�� �帳�ϴ�.</p>
									<div class="privacy">
										<dl style="">
											<dt>* ���� ��� ���(���İ���)�̳� ���� ������ �ޱ⸦</dt>
											<dd>

											</dd>
										</dl>

										<!--���� ���� btn  -->
										<label class="radiobox" style="padding-right:1%">
											<input class="rdi" name="hopeCheck" value="1" type="radio"><span style="font-size:1.2rem;">����մϴ�.</span>
										</label>
										<label class="radiobox">
											<input class="rdi" name="hopeCheck" value="2" type="radio"><span style="font-size:1.2rem;">����� �մϴ�.</span>
										</label>
									</div>
							</div><!-- sch_area -->

							<div class="privacy">
								<dl>
									<dt>�������� ���� �� �̿뵿��</dt>
									<dd>
										<strong>�������� ��������</strong> : <%=site_name%> �α��� �� ������ ���� �ĺ�, �����ǻ� Ȯ��, �Ի������� ����, �������� ����, �Ի� �����ڿ��� ��Ȱ�� �ǻ����, �����̷� Ȯ��, �̺�Ʈ ������ ��÷�� ��ǥ �� ������ Ȱ�� ����<br>
										<strong>�������� �����׸�</strong> : �̸�, �̸���, �޴��� ��ȣ, ����, �ҼӺδ��, ���, ����, ����������, ����<br />
										<strong>�������� �̿�Ⱓ</strong> : ��� �Ⱓ<br>(����Ʈ ���� �� ���� ��� ����ñ��� - ���� ������ ���� ������� ��� ������ �Ϸ��ϱ� ���� ȸ���� �̿������� ������ �ʿ䰡 ����)<br>
										<strong>�������� �ı�</strong> : ��� ���� �� ��� ������� ���� ���� �� �ı� (���� ���� ��)<br />
										<p style="font-weight:bold; margin-top:10px;">	* �������� ���� �� �̿뿡 ���ؼ��� �ź��� �� ������, �ź� �ÿ��� �ڶ�ȸ ����Ʈ �̿��� �Ұ��մϴ�. </p>
									</dd>
								</dl>

								<!--���� ���� btn  -->
								<label class="radiobox" style="padding-right:1%">
									<input class="rdi" name="agreeCheck" value="1" type="radio"><span style="font-size:1.2rem;">�����մϴ�.</span>
								</label>
								<label class="radiobox">
									<input class="rdi" name="agreeCheck" value="2" type="radio"><span style="font-size:1.2rem;">�������� �ʽ��ϴ�.</span>
								</label>
							</div>
						</div>
					</div>

					<div class="btnWrap" style="margin:30px 0 -20px 0;">
						<button class="btn_login" type="button" onclick="javascript:fn_sumbit();">
							<span>ȸ������ �ϱ�</span>
						</button>
					</div>
				</div><!-- signup_area-->
			</form>
		</div><!-- contents -->
	</div><!-- contents -->
	<!-- //container -->

<!-- �ϴ� -->
<!--#include virtual = "/include/footer.asp"-->
<!-- �ϴ� -->

</body>
</html>
