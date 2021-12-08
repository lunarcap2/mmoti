var pwdMsg = "�Է��Ͻ� ��й�ȣ�� ���Ȼ� �ſ� ����մϴ�.\n\n5~10�� ���� ����, ���� ���� ��������\n���̵�� ������ ���ڿ��� �Է����ּ���."; 
var blockWord = new Array();
blockWord.push("dfdf");
blockWord.push("asdf");
blockWord.push("123123");
	
PwdChecker = function() {
}

PwdChecker.prototype.mainProgress = function(id, pw) {
	if (pw.length < 5 || pw.length > 10) {
		alert("��й�ȣ�� 5~10�� �̻� ���˴ϴ�.");
		return false;
	}
	if (!this.step1Check(id, pw) 
		|| !this.step2Check(pw) 
		|| !this.step3Check(pw)
		|| !this.step4Check(id, pw)) {
		alert(pwdMsg);
		return false;
	}
	return true;
}

//ID�� ��ġ�� �˻�
PwdChecker.prototype.step1Check = function(id, pw) {
	if (id.indexOf(pw) != -1) {
		return false;
	}
	if (pw.indexOf(id) != -1) {
		return false;
	}
	return true;
}

//���Ӽ��� ���� �� ������ �˻�
PwdChecker.prototype.step2Check = function(pw) {
	if ("01234567890".indexOf(pw) != -1) {
		return false;
	}
	if ("abcdefghijklmnopqrstuvwxyz".indexOf(pw) != -1) {
		return false;
	}
	if ("ABCDEFGHIJKLMNOPQRSTUVWXYZ".indexOf(pw) != -1) {
		return false;
	}
	for (var i = 0; i < blockWord.length; i++) {
		if (pw.indexOf(blockWord[i]) != -1) {
			return false;
		}
	}
	return true;
}

//������ ��,�� ���ڰ� 4�� �̻󿩺� �˻�
PwdChecker.prototype.step3Check = function(pw) {
	var cnt = 1;
	for (var i = 0; i < pw.length-1; i++) {
		if (this.compare3(pw, i)) {
			++cnt;
		} else {
			cnt = 1;
		}
		if (cnt > 3) {
			return false;
		}
	}
	return true;
}

//�н����尡 ���̵� ���� �ܾ�� �˻�
PwdChecker.prototype.step4Check = function(id, pw) {
	return this.compare4(pw, 0, id, 0);
}

PwdChecker.prototype.compare3 = function(pw, i) {
	return pw.charAt(i) == pw.charAt(i+1);
}

PwdChecker.prototype.compare4 = function(pw, i, id, j) {
	if (i >= pw.length) return false;
	var _pw = pw.charAt(i);
	var _id = id.substring(j);
	var k = _id.indexOf(_pw);
	if (k == -1) return true;
	return this.compare4(pw, i+1, id, k+1);
}
