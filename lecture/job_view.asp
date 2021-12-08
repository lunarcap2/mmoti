<% option Explicit %>

<!--#include virtual = "/common/common.asp"-->
<!--#include virtual = "/include/header/header.asp"-->
<!--#include virtual = "/wwwconf/function/db/DBConnection.asp"-->

<%
	Dim lecture_no	: lecture_no	= Request("lecture_no")

	If lecture_no = "" Then
		Response.write "<script language=javascript>"&_
			"alert('�߸��� �����Դϴ�.');"&_
			"location.href='/lecture/list.asp';"&_
			"</script>"
		Response.End
	End If

	ConnectDB DBCon, Application("DBInfo_FAIR")

		ReDim Param(0)
		Param(0) = makeparam("@lecture_no",adInteger,adParamInput,4,lecture_no)

		Dim arrRs : arrRs = arrGetRsSP(DBcon, "asp_������_Ư��_��", Param, "", "")

		Dim rs_schoolId, rs_tit, rs_date, rs_shour, rs_smin, rs_ehour, rs_emin, rs_url, rs_img, rs_replay, rs_gubun
		rs_schoolId		= arrRs(0,0)
		rs_tit			= arrRs(1,0)
		rs_date			= Left(arrRs(3,0),10)					'Ư����
		rs_shour		= Split(Mid(arrRs(3,0),12,13),":")(0)	'Ư��_���۽�
		rs_smin			= Split(Mid(arrRs(3,0),12,13),":")(1)	'Ư��_���ۺ�
		rs_ehour		= Split(Mid(arrRs(4,0),12,13),":")(0)	'Ư��_�����
		rs_emin			= Split(Mid(arrRs(4,0),12,13),":")(1)	'Ư��_�����
		rs_url			= arrRs(5,0)
		rs_img			= arrRs(6,0)
		rs_replay		= arrRs(7,0)
		rs_gubun		= arrRs(8,0)	'Ư������(1:���Ư��, 2:ä�뼳��ȸ)

		' Ư���Ͻÿ� ������ ��
		Dim diff_date, diff_shour, diff_ehour, diff_smin, diff_emin
		diff_date	= CInt(DateDiff("d", rs_date, FormatDateTime(Now(), 2)))
		diff_shour	= CInt(DateDiff("h", rs_shour & ":" & rs_smin, FormatDateTime(Now(), 4)))
		diff_ehour	= CInt(DateDiff("h", rs_ehour & ":" & rs_emin, FormatDateTime(Now(), 4)))
		diff_smin	= CInt(DateDiff("n", rs_shour & ":" & rs_smin, FormatDateTime(Now(), 4)))
		diff_emin	= CInt(DateDiff("n", rs_ehour & ":" & rs_emin, FormatDateTime(Now(), 4)))


		Dim lcture_state
		If diff_date < 0 Or (diff_date = 0 And diff_shour < -1) Or (diff_date = 0 And (diff_shour = 0 Or diff_shour = -1) And diff_smin < -10) Then 'diff_smin 10���� ����
			lcture_state = "lcture_before"
		ElseIf diff_date > 0 Or (diff_date = 0 And diff_ehour > 0) Or (diff_date = 0 And diff_ehour = 0 And diff_emin >= 0) Then
			lcture_state = "lcture_end"
		Else
			lcture_state = "lcture_ing"
		End If

		'��Ʃ�꿵�� ������
		Dim youtube_code : youtube_code = Split(rs_url, "/")


		'��û����Ȯ��
		ReDim Param(7)
		Param(0) = makeparam("@KW",adVarWChar,adParamInput,400,"")
		Param(1) = makeparam("@LECTURE_NO",adInteger,adParamInput,4,lecture_no)
		Param(2) = makeparam("@LECTURE_SCHOOL_ID",adVarWChar,adParamInput,400,"")
		Param(3) = makeparam("@USER_ID",adVarWChar,adParamInput,20,user_id)
		Param(4) = makeparam("@PAGE",adInteger,adParamInput,4,1)
		Param(5) = makeparam("@PAGE_SIZE",adInteger,adParamInput,4,1)
		Param(6) = makeparam("@TOTAL_CNT",adInteger,adParamOutput,4,"")

		Param(7) = makeparam("@LECTURE_GUBUN",adChar,adParamInput,1,rs_gubun)

		Dim arrRs_my : arrRs_my = arrGetRsSP(DBcon, "asp_������_Ư��_��û_����Ʈ", Param, "", "")

		Dim applyChk, apply_quest
		If isArray(arrRs_my) Then
			applyChk = "Y"
			apply_quest	= arrRs_my(2,0)
		End If


		'����LOG
		Dim strSql2, strRemoteAddr, strUserAgent
		strRemoteAddr	= Request.ServerVariables("REMOTE_ADDR")
        strUserAgent	= Request.ServerVariables("HTTP_USER_AGENT")
		strSql2 = "INSERT INTO LOG_Ư���������� VALUES('" & user_id & "', " & lecture_no & ", '" & strRemoteAddr & "', '" & strUserAgent & "', GETDATE(), 'MOBILE')"
		DBCon.Execute(strSql2)

	DisconnectDB DBCon
%>

<script type="text/javascript">
	//�������� ��� �˾�
	function fn_question_save(_val) {
		$("#set_lecture_no").val(_val);

		view_layer_hide("edit");
		view_layer("reg");
		fn_question_save_view_pop(_val);
	}

	//�������� ��� �˾�
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
				alert("ó�� ���� ������ �߻��Ͽ����ϴ�.\n" + err);
			}
		});
	}

	//�������� ���
	function fn_apply_quest() {
		if($('#quest_cont').val() == '') {
			alert('������ �ۼ��� �ּ���.');
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

					alert("���� ����� �Ϸ�Ǿ����ϴ�.");
					location.href = "/my/lecture_list.asp";
				} else {
					alert("ó�� ���� ������ �߻��Ͽ����ϴ�.");
				}
			},
			error: function (req, status, err) {
				alert("ó�� ���� ������ �߻��Ͽ����ϴ�.\n" + err);
				return false;
			}
		});
	}

	//�α���
	function fn_login() {
		alert("���� �α��� �� ��û�� �����մϴ�.");
		location.href = '/my/login.asp';
	}

	//Ư����û
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
					alert("Ư�� ��û�� �Ϸ�Ǿ����ϴ�.");
					location.reload();
				} else {
					alert("ó�� ���� ������ �߻��Ͽ����ϴ�.");
				}
			},
			error: function (req, status, err) {
				alert("ó�� ���� ������ �߻��Ͽ����ϴ�.\n" + err);
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
			<a href="./job_list.asp">����</a>
			<p>ä�뼳��ȸ</p>
		</div>
		</div>
	</div>
</div>
<!-- //header -->

<!-- container -->
<div id="contents" class="sub_page">
	<div class="contents">
		<div class="visual_area lecture2">
			<h2>ä�뼳��ȸ</h2>
		</div><!-- visual_area -->

		<div class="employment_area view">
			<ul>
				<li>
					<dl class="employment_box">
						<dt><%=rs_tit%></dt>
						<!--<dd>
							<ul class="info">
								<li><span>�Ͻ� :</span> <%=rs_date%>&nbsp;<em><%=rs_shour%>:<%=rs_smin%></em></li>
							</ul>
						</dd>-->
						<dd class="img">
							<div class="box">
								<!--Ư�� ����-->
								<% If lcture_state = "lcture_ing" Then %>
									<!--<img src="http://img.youtube.com/vi/<%=youtube_code(UBound(youtube_code))%>/sddefault.jpg" alt="��Ʃ�� �ǽð� �̹���">
									<span>�ǽð�</span>-->
								<% Else %>
									<!--<img src="<%=g_partner_wk%>/files/lecture/<%=rs_img%>" alt="�̹���">-->
								<% End If %>
							</div>
						</dd>
					</dl>
				</li>
			</ul>

			<div class="movie_area">
				<div class="preparing">
					<!--Ư�� ���� ��-->
					<% If lcture_state = "lcture_before" Then %>
						<img src="/images/landing/landing_preparing5.jpg" style="padding:10px 0px 0px;">
						<!--��������-->
						<input type="hidden" id="set_lecture_no" value="">

						<% If g_LoginChk <> "1" Then %>
							<div class="btn_area2" style="position: absolute; left: 8%; top:42%; width:60%">
								<img src="/images/landing/landing_img2.png" alt="btn_area2" style="width:94%">
								<a href="javascript:;" style="background: rgba(0,0,0,0); position: absolute; left: 13%; bottom: 0; width: 72%; height: 48%;" onclick="fn_login();"></a>
							</div>
						<% Else %>
							<!--��û����üũ-->
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

					<!--Ư�� ����-->
					<% ElseIf lcture_state = "lcture_ing" Then %>
						<div class="movie">
							<iframe width="100%" height="100%" src="https://www.youtube.com/embed/<%=youtube_code(UBound(youtube_code))%>" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
						</div>
					<!--Ư�� ����-->
					<% ElseIf lcture_state = "lcture_end" Then %>
						<img src="/images/landing/landing_preparing4.jpg" style="padding:10px 0px 0px;">
					<% End If %>
				</div>

				<!--
				<div class="btn_area">
					Ư�� ���� ��
					<% If lcture_state = "lcture_before" Then %>
						��û����üũ
						<% If applyChk <> "" Then %>
							<a href="javaScript:alert('������ Ư�� ������ ���� 10�� ������ �����մϴ�.');" class="btn">Youtube���� ����</a>
						<% Else %>
							��������
							<input type="hidden" id="set_lecture_no" value="">

							<% If g_LoginChk <> "1" Then %>
								<a href="#layer1" class="btn lg" onclick="fn_login();">�������� �Ϸ�����</a>
							<% Else %>
								<a href="#layer1" class="btn lg pop" onclick="fn_question_save('<%=lecture_no%>');">�������� �Ϸ�����</a>
							<% End If %>
						<% End If %>
					Ư�� ����
					<% ElseIf lcture_state = "lcture_ing" Then %>
						<a href="https://youtu.be/<%=youtube_code(UBound(youtube_code))%>" class="btn lg" target="_blank">Youtube���� ����</a>
					Ư�� ����
					<% ElseIf lcture_state = "lcture_end" Then %>
						<% If rs_replay = "Y" Then %>
							<a href="https://youtu.be/<%=youtube_code(UBound(youtube_code))%>" class="btn lg" target="_blank">�ٽú���</a>
						<% End If %>
					<% End If %>
				</div>


				<div class="btn_area">
					Ư�� ���� ��
					<% If lcture_state = "lcture_before" Then %>
						��û����üũ
						<% If applyChk <> "" Then %>
							<a href="javaScript:alert('������ Ư�� ������ ���� 10�� ������ �����մϴ�.');" class="btn">Youtube���� ����</a>
						<% End If %>
					Ư�� ����
					<% ElseIf lcture_state = "lcture_ing" Then %>
						<a href="https://youtu.be/<%=youtube_code(UBound(youtube_code))%>" class="btn lg" target="_blank">Youtube���� ����</a>
					<% End If %>
				</div>
				-->
			</div>

		</div><!-- lecture_area -->

	</div><!--contents -->

</div>
<!-- //container -->

<!-- �ϴ� -->
<!--#include virtual = "/include/footer.asp"-->
<!-- �ϴ� -->

<!--�������� �˾�����-->
<!--#include file = "./inc_popup.asp"-->

<!-- ���� ������ -->
<div id="layer_pop18" class="layer_popup">
	<div class="popup_dim"></div>
	<div class="popup">
		<div class="pop_wrap">
			<div class="pop_head">
				<h3>���� ������</h3>
				<a href="javascript:void(0)" class="close">�ݱ�</a>
			</div>
			<div class="pop_con">
				<div class="porfile_area">
					<p class="name">���� : �� �� </p>
					<dl>
						<dt>�ֿ��̷�</dt>
						<dd>
							��) ������ ����<br>
							��) ����� ���ڸ� ī�� ����<br>
							��) �츮���� ������� ���
						</dd>
						<dt>�ֿ�Ȱ��</dt>
						<dd>
							�����Ѹ��� (���뵿��å����)<br>
							����ó��� (������������)<br>
							���������� (������ȸ��å����)<br>
							û�������� ����<br>
							�ѱ�������� �г�
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
				<h3>���� ������</h3>
				<a href="javascript:void(0)" class="close">�ݱ�</a>
			</div>
			<div class="pop_con">
				<div class="porfile_area">
					<p class="name">���� : �����</p>
					<dl>
						<dt>�ֿ��̷�</dt>
						<dd>
							��) Ʈ����Ʈ�������� ������Ʈ (���б���/������� �ְ� û�ⱳ��)<br>
							��) CJ ENM -  ������ �ι� �λ��� / ��ü����� (2012.01~2017.02)<br>
							��) �����ڵ��� �ε����� �Ǹű�ȹ��
						</dd>
						<dt>�ֿ�Ȱ��</dt>
						<dd>
							����ø����б� �濵���п�  MBA ���� (�λ����� ����, ����. 2020.02)<br>
							�ѱ��ܱ�����б� �۷ι� ķ�۽� �ε��а� �л�<br>
							�ѱ�������� JOB��������, ������ JOBS �⿬<br>
							������� TV (�̽��÷���) �⿬
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
				<h3>���� ������</h3>
				<a href="javascript:void(0)" class="close">�ݱ�</a>
			</div>
			<div class="pop_con">
				<div class="porfile_area">
					<p class="name">���� : ���ع�</p>
					<dl>
						<dt>�ֿ��̷�</dt>
						<dd>
							��) �ֽ�ȸ�� ������ ������ ������� ������<br>
							��) �ֽ�ȸ�� ���� IoT ����� ����<br>
							��) �ֽ�ȸ�� ������̿�Ƽ �����ȹ�� ����

						</dd>
						<dt>�ֿ�Ȱ��</dt>
						<dd>
							LG CNS | MI�ý��� ������,  Elasticsearch�� �̿��� IR��ȭ<br>
							���� ���信�� | GAPM ASP�ý��� ���� ������Ʈ, Elasticsearch Developer������<br>
							�����ڵ����׷� | Elasticsearch Platinum ������ ���� �̻�¡�� Ȯ�� (Renewal)<br>
							�Ｚ���� | Elasticsearch Platinum �˻����� ���� (Renewal)<br>
							�ѱ����ͳ������ | ������ ����� �ΰ����� ���������м� �ַ��
						</dd>
					</dl>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- //���� ������ -->

</body>
</html>
