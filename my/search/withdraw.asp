<!--#include virtual = "/common/common.asp"-->
<!--#include virtual = "/include/header/header.asp"-->

<!--#include virtual = "/wwwconf/function/db/DBConnection.asp"-->

<%
	Call FN_LoginLimit("1")    '����ȸ���� ���ٰ���

	ConnectDB DBCon, Application("DBInfo_FAIR")
	
	Dim strSql, site_gubun
	strSql = "SELECT ���Ի���Ʈ�����ڵ� FROM ����ȸ������ WITH(NOLOCK) WHERE ���ξ��̵� = '"& user_id &"'"
	site_gubun = arrGetRsSql(DBCon, strSql, "", "")(0, 0)


	' my ī��Ʈ
	Dim resume_cnt, apply_cnt, scrap_cnt, att_company_cnt, rtn_value3
	ReDim param(0)
	param(0) = makeParam("@i_user_id", adVarChar, adParamInput, 20, user_id)
	rtn_value3		= arrGetRsSP(DBCon, "USP_MY_RESUME_STAT", param, "", "")
	
	resume_cnt			= rtn_value3(1,0) + rtn_value3(2,0) + rtn_value3(9,0)	' �̷¼�
	apply_cnt			= rtn_value3(3,0) + rtn_value3(4,0)						' �Ի����� ����
	scrap_cnt			= rtn_value3(5,0) + rtn_value3(6,0)						' ��ũ�� ����
	att_company_cnt		= rtn_value3(7,0)										' ���� ���»�
	
	DisconnectDB DBCon
%>

<script type="text/javascript">	

	$(document).ready(function () {
		var site_gubun = "<%=site_gubun%>";
		if (site_gubun == "31" || site_gubun == "32" || site_gubun == "33" || site_gubun == "34") {
			$('#confirm').css("display","block");
		}
	});


	function fn_keyup() {
		if (event.keyCode == 13) {
			fn_pwchk();
		}
	}

	function fn_pwchk() {
		if($('#user_pw').val() == "") {
			alert("��й�ȣ�� �Է��� �ּ���");
			$('#user_pw').focus();
            return;	
		}
		else {
			$.ajax({
				type: "POST"
				, url: "/my/search/withdraw_confirm.asp"
				, data: { user_pw: $("#user_pw").val() }
				, dataType: "html"
				, async: true
				, success: function (data) {
					if (data.trim() != '') {
						$('#confirm').css("display","block");	
					}
					else {
						alert("�Է��� ��й�ȣ�� ��ġ���� �ʽ��ϴ�.");
						$('#user_pw').focus();
			            return;
					}
				}
				, error: function (XMLHttpRequest, textStatus, errorThrown) {
					//alert(XMLHttpRequest.responseText);
				}
			});
		}
	}

	function fn_submit() {
		if ($('#user_nm').val() == "") {
			alert("�ʼ� �Է°��� �Է��� �ּ���");
			$('#user_nm').focus();
			return;
		}
		if ($('#hp_num').val() == "") {
			alert("�ʼ� �Է°��� �Է��� �ּ���");
			$('#hp_num').focus();
			return;
		}
		if ($('#user_reason').val() == "") {
			alert("�ʼ� �Է°��� �Է��� �ּ���");
			$('#user_reason').focus();
			return;
		}

		if (confirm("���� Ż���Ͻðڽ��ϱ�?")) {
			$("#frm").attr("action", "/my/search/withdraw_complet.asp");
			$('#frm').submit();
		}

	}
</script>
</head>

<body>
	<!-- header -->
	<div  id="header">
		<div class="header-wrap detail">
			<div class="detail_box">
				<a href="/">����</a>
				<p>ȸ��Ż��</p>
			</div>
			
		</div>
	</div>
	<!-- //header -->

	<!-- container -->
	<div id="contents" class="sub_page">
		<div class="contents">
			<div class="signup_area">
				<div class="layoutBox">
					<div class="titArea">
						<h3>
							ȸ��Ȯ��<br>
							<% If site_gubun = "31" Then %>
							<span class="txt">���̹���(��) ���� ������ ȸ���Դϴ�.</span>
							<% ElseIf site_gubun = "32" Then %>
							<span class="txt">īī����(��) ���� ������ ȸ���Դϴ�.</span>
							<% ElseIf site_gubun = "33" Then %>
							<span class="txt">������(��) ���� ������ ȸ���Դϴ�.</span>
							<% ElseIf site_gubun = "34" Then %>
							<span class="txt">���̽�����(��) ���� ������ ȸ���Դϴ�.</span>
							<% Else %>
							<span class="txt">���� Ȯ���� ���� ��й�ȣ�� �ٽ� �ѹ� �Է� ��Ź�帳�ϴ�.</span>
							<% End If %>
						</h3>
					</div><!-- .titArea -->

					<div class="inputArea">
						<div class="inp bgNone">
							<label for="user_id">���̵�</label>
							<input type="text" id="user_id" class="txt tahoma" name="user_id" value="<%=Replace(user_id, "_wk", "")%>" disabled="">
						</div><!-- .inp -->
						
						<% If site_gubun <> "31" And site_gubun <> "32" And site_gubun <> "33" And site_gubun <> "34" Then %>
						<div class="inp bgNone btn">
							<label for="user_pw">��й�ȣ</label>
							<input type="password" id="user_pw" class="txt" name="user_pw" placeholder="��й�ȣ �Է�" onkeyup="FC_ChkTextLen(this,32); fn_keyup();">
							<div class="rt">
								<button type="button" class="btn typeSky" onclick="fn_pwchk();">Ȯ��</button>
							</div><!-- .rt -->
						</div><!-- .inp -->
						<% End If %>
					</div><!-- .inputArea -->
			
					<!-- ����ȸ�� -->
					<div id="memberPer" class="memberInfo">
						<div class="currentArea">
							<strong class="tit">ȸ��Ż�� �� <em>������ ������ �����Ǿ� �̿��� �� ���� �˴ϴ�.</em></strong>
							<ul class="spl4">
								<li>
									<dl>
										<dt>������</dt>
										<dd><a><%=resume_cnt%></a></dd>
									</dl>
								</li>
								<li>
									<dl>
										<dt>�Ի����� ����</dt>
										<dd><a><%=apply_cnt%></a></dd>
									</dl>
								</li>
								<li>
									<dl>
										<dt>��ũ�� ����</dt>
										<dd><a><%=scrap_cnt%></a></dd>
									</dl>
								</li>
								<li>
									<dl>
										<dt>���� ���»�</dt>
										<dd><a><%=att_company_cnt%></a></dd>
									</dl>
								</li>
							</ul>
						</div><!-- .currentArea -->

						<form name="frm" id="frm" method="post" action="">
							<input type="hidden" name="site_gubun" value="<%=site_gubun%>">
							
							<div id="confirm" style="display:none;">
								
								<% If site_gubun <> "31" And site_gubun <> "32" And site_gubun <> "33" And site_gubun <> "34" Then %>
								<div class="inputArea">
									<div class="inp">
										<label for="user_nm">�̸�</label>
										<input type="txt" id="user_nm" class="txt placehd" name="user_nm" placeholder="�̸� (�Ǹ��Է�)" />
									</div><!-- .inp -->
									<div class="inp">
										<label for="hp_num">�޴��� ��ȣ</label>
										<input type="txt" id="hp_num" class="txt placehd" name="hp_num" placeholder="�޴��� ��ȣ" maxlength="13" />
									</div><!-- .inp -->
									<div class="inp">
										<label for="user_reason">Ż�����</label>
										<input type="txt" id="user_reason" class="txt placehd" name="user_reason" placeholder="Ż�����" />
									</div><!-- .inp -->
								</div><!-- .inputArea -->
								<% End If %>

								<div class="btnWrap">
									<button type="button" class="btn typeSky" onclick="fn_submit()">ȸ��Ż�� ��û</button>
								</div>
							</div>
						</form>

						<div class="notiArea">
							<strong class="tit">ȸ��Ż�� ��û�� �� <em>������ ������ �ݵ�� Ȯ���Ͻñ� �ٶ��ϴ�.</em></strong>
							<ul>
								<li>�� �����ڵ����׷� ���»� ����ä�� ���翡 �α����� �� �� �����ϴ�.</li>
								<li>�� ���� �簡���ϴ��� ������ ���̵�� �簡���� �Ұ����մϴ�.</li>
								<li>�� �ڶ�ȸ ���� �ҽ��� ���� �� �����ϴ�.</li>
							</ul>
						</div><!-- .notiArea -->
					</div><!-- .memberInfo -->
				 </div><!-- layoutBox -->
			</div><!-- signup_area-->
		</div><!-- contents -->
	</div><!-- contents -->
	<!-- //container -->


<!-- �ϴ� -->
<!--#include virtual = "/include/footer.asp"-->
<!-- �ϴ� -->

</body>
</html>