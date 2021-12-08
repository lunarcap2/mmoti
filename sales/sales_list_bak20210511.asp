<!--#include virtual = "/common/common.asp"-->
<!--#include virtual = "/include/header/header.asp"-->
<!--#include virtual = "/wwwconf/function/db/DBConnection.asp"-->
<!--#include virtual = "/inc/function/paging.asp"-->

<script type="text/javascript">
	$(document).ready(function () {
		fn_salary_area_show(1,100,'tbody1');
	});

	function fn_salary_area_show(_sRank, _eRank, _body) {
		$.ajax({
			type: 'POST'
			, url: 'ajax_sales_list.asp'
			, data: { sRank : _sRank, eRank : _eRank}
			, success: function (data) {
				$('#' + _body).html(data);
			}
			, error: function (XMLHttpRequest, textStatus, errorThrown) {
				alert(textStatus);
			}
		});
	}

	function fn_sel(obj) {
		var sRank, eRank

		if(obj.value == '1') {
			sRank = '1';
			eRank = '100';
		}
		else if(obj.value == '2') {
			sRank = '101';
			eRank = '200';
		}
		else if(obj.value == '3') {
			sRank = '201';
			eRank = '300';
		}
		else if(obj.value == '4') {
			sRank = '301';
			eRank = '400';
		}
		else if(obj.value == '5') {
			sRank = '401';
			eRank = '500';
		}

		fn_salary_area_show(sRank, eRank, 'tbody1');
	}

	//�󼼺���
	function FN_view(val) {
		$('#hdn_biz_code').val(val);
		$('#frm_view').attr('action', 'sales_view.asp');
		$('#frm_view').submit();
	}
</script>

</head>

<body>

<!-- ��� -->
<!--#include virtual = "/include/gnb/topMenu.asp"-->
<!-- //��� -->

<form method="post" id="frm_view" name="frm_view" action="">
	<input type="hidden" id="hdn_biz_code" name="hdn_biz_code" value="">
</form>

<!-- ���� -->
<div id="contents" class="sub_page contents">
	<div class="visual_area yenbo">
		<h2>����500�� ����ڷ�</h2>
	</div>

	<div class="contents">
		<div class="con_box">
			<div class="innerWrap">
				<div class="salary_area MT45">
					<span class="selectbox">
						<span id="">����500���� ����ڷ�</span>
						<select id="" name=""  onchange="fn_sel(this);">
							<option value="1">1��~100��</option>
							<option value="2">101��~200��</option>
							<option value="3">201��~300��</option>
							<option value="4">301��~400��</option>
							<option value="5">401��~500��</option>
						</select>
					</span>

				</div><!--//salary_area-->
			</div>
		</div><!--//con_box-->


			<form id="frm" name="frm" method="get">
				<input type="hidden" id="schArea" name="schArea" value="">
			</form>

			<div class="tab_container">
				<div id="list1" class="tab_content">
					<div class="list_area">
						<div class="list_info">
							<div class="left_box">
								<p><span>������� Ŭ���Ͻø� �� �������� �̵��մϴ�.</span></p>
							</div>
						</div>

						<div class="partners_wrap">

							<a href="./view.asp?bizNum=5038506378">
								<dl>
									<dt>
										(��)Ŀ�����
										<!--<div class="comp_type">

											<span class="blue">�߰߱��</span>

											<span>�ڽ���</span>

										</div>-->
									</dt>
									<dd>
										<div class="partners_info">
											<dl>
												<dt>�����⵵</dt>
												<dd>1974��</dd>
												<dt>��������</dt>
												<dd>270��</dd>
											</dl>
											<dl>
												<dt>�����</dt>
												<dd>2,022�� 7,591���� (2020�� ����)</dd>
											</dl>
											<dl>
												<dt>�������</dt>
												<dd>1��</dd>
											</dl>
										</div>
									</dd>
								</dl>
							</a>

							<a href="./view.asp?bizNum=1068669145">
								<dl>
									<dt>
										(��)���
										<!--<div class="comp_type">

											<span class="blue">�߰߱��</span>

											<span>�ڽ���</span>

										</div>-->
									</dt>
									<dd>
										<div class="partners_info">
											<dl>
												<dt>�����⵵</dt>
												<dd>2009��</dd>
												<dt>��������</dt>
												<dd>495��</dd>
											</dl>
											<dl>
												<dt>�����</dt>
												<dd>2,916�� 2,343���� (2020�� ����)</dd>
											</dl>
											<dl>
												<dt>�ֿ���</dt>
												<dd>�ڵ�����ǰ ����</dd>
											</dl>
										</div>
									</dd>
								</dl>
							</a>

							<a href="./view.asp?bizNum=6038103047">
								<dl>
									<dt>
										(��)����ũ
										<!--<div class="comp_type">

											<span class="blue">�߰߱��</span>

											<span>�ڽ���</span>

										</div>-->
									</dt>
									<dd>
										<div class="partners_info">
											<dl>
												<dt>�����⵵</dt>
												<dd>1976��</dd>
												<dt>��������</dt>
												<dd>639��</dd>
											</dl>
											<dl>
												<dt>�����</dt>
												<dd>2,170�� 7,457���� (2020�� ����)</dd>
											</dl>
											<dl>
												<dt>�ֿ���</dt>
												<dd>�ڵ�����ǰ(���мַ����̵���) ����,...</dd>
											</dl>
										</div>
									</dd>
								</dl>
							</a>

							<a href="./view.asp?bizNum=5148157898">
								<dl>
									<dt>
										��ȭ���(��)
										<!--<div class="comp_type">

											<span class="blue">�߰߱��</span>

											<span>�ڽ���</span>

										</div>-->
									</dt>
									<dd>
										<div class="partners_info">
											<dl>
												<dt>�����⵵</dt>
												<dd>2006��</dd>
												<dt>��������</dt>
												<dd>785��</dd>
											</dl>
											<dl>
												<dt>�����</dt>
												<dd>3,520�� 2,605���� (2020�� ����)</dd>
											</dl>
											<dl>
												<dt>�ֿ���</dt>
												<dd>�ڵ�����ǰ(������,�����(COVE...</dd>
											</dl>
										</div>
									</dd>
								</dl>
							</a>

							<a href="./view.asp?bizNum=5148120917">
								<dl>
									<dt>
										(��)ī��߷���
										<!--<div class="comp_type">

											<span class="blue">�߰߱��</span>

											<span>�ܰ�</span>

										</div>-->
									</dt>
									<dd>
										<div class="partners_info">
											<dl>
												<dt>�����⵵</dt>
												<dd>1993��</dd>
												<dt>��������</dt>
												<dd>669��</dd>
											</dl>
											<dl>
												<dt>�����</dt>
												<dd>6,714�� 7,284���� (2020�� ����)</dd>
											</dl>
											<dl>
												<dt>�ֿ���</dt>
												<dd>�ڵ�����ǰ,������ġ ����</dd>
											</dl>
										</div>
									</dd>
								</dl>
							</a>

							<a href="./view.asp?bizNum=5058106702">
								<dl>
									<dt>
										�ö�ƽ�ȴϾ�(��)
										<!--<div class="comp_type">

											<span>�ܰ�</span>

										</div>-->
									</dt>
									<dd>
										<div class="partners_info">
											<dl>
												<dt>�����⵵</dt>
												<dd>1992��</dd>
												<dt>��������</dt>
												<dd>243��</dd>
											</dl>
											<dl>
												<dt>�����</dt>
												<dd>1,713�� 113���� (2020�� ����)</dd>
											</dl>
											<dl>
												<dt>�ֿ���</dt>
												<dd>�ڵ�����ǰ(�ż��� �ö�ƽ ������ũ)...</dd>
											</dl>
										</div>
									</dd>
								</dl>
							</a>

							<a href="./view.asp?bizNum=5038110156">
								<dl>
									<dt>
										(��)��ȭ�߷���
										<!--<div class="comp_type">

											<span class="blue">�߰߱��</span>

											<span>�ܰ�</span>

										</div>-->
									</dt>
									<dd>
										<div class="partners_info">
											<dl>
												<dt>�����⵵</dt>
												<dd>1988��</dd>
												<dt>��������</dt>
												<dd>725��</dd>
											</dl>
											<dl>
												<dt>�����</dt>
												<dd>7,189�� 5,106���� (2020�� ����)</dd>
											</dl>
											<dl>
												<dt>�ֿ���</dt>
												<dd>�ڵ���Ŭ��ġ,������,������ ����,��...</dd>
											</dl>
										</div>
									</dd>
								</dl>
							</a>

							<a href="./view.asp?bizNum=5038106628">
								<dl>
									<dt>
										��ȭ����(��)
										<!--<div class="comp_type">

											<span class="blue">�߰߱��</span>

											<span>�ڽ���</span>

										</div>-->
									</dt>
									<dd>
										<div class="partners_info">
											<dl>
												<dt>�����⵵</dt>
												<dd>1985��</dd>
												<dt>��������</dt>
												<dd>680��</dd>
											</dl>
											<dl>
												<dt>�����</dt>
												<dd>6,267�� 1,157���� (2020�� ����)</dd>
											</dl>
											<dl>
												<dt>�ֿ���</dt>
												<dd>�ڵ����� ������ý���,���ġ,����...</dd>
											</dl>
										</div>
									</dd>
								</dl>
							</a>

							<a href="./view.asp?bizNum=4108158130">
								<dl>
									<dt>
										(��)����������
										<!--<div class="comp_type">

											<span>�ܰ�</span>

										</div>-->
									</dt>
									<dd>
										<div class="partners_info">
											<dl>
												<dt>�����⵵</dt>
												<dd>2000��</dd>
												<dt>��������</dt>
												<dd>91��</dd>
											</dl>
											<dl>
												<dt>�����</dt>
												<dd>471�� 6,476���� (2020�� ����)</dd>
											</dl>
											<dl>
												<dt>�ֿ���</dt>
												<dd>�ڵ�����ǰ</dd>
											</dl>
										</div>
									</dd>
								</dl>
							</a>

							<a href="./view.asp?bizNum=4108148267">
								<dl>
									<dt>
										(��)��������
										<!--<div class="comp_type">

											<span>�Ϲ�</span>

										</div>-->
									</dt>
									<dd>
										<div class="partners_info">
											<dl>
												<dt>�����⵵</dt>
												<dd>1990��</dd>
												<dt>��������</dt>
												<dd>58��</dd>
											</dl>
											<dl>
												<dt>�����</dt>
												<dd>199�� 7,790���� (2020�� ����)</dd>
											</dl>
											<dl>
												<dt>�ֿ���</dt>
												<dd>�ڵ�����ǰ,����ǰ ����</dd>
											</dl>
										</div>
									</dd>
								</dl>
							</a>


							<!--����¡-->
							<div class="paging_area"><li><strong>1</strong></li><li><a href='/partner/list.asp?page=2&schKw=&schArea='>2</a></li><li><a href='/partner/list.asp?page=3&schKw=&schArea='>3</a></li><li><a href='/partner/list.asp?page=4&schKw=&schArea='>4</a></li><li><a href='/partner/list.asp?page=5&schKw=&schArea='>5</a></li><li class="btn next"><a href='/partner/list.asp?page=6&schKw=&schArea='><span></span></a></li></div>

						</div><!-- partners_wrap -->

					</div><!-- list_area -->
				</div><!--tab_content -->

			</div><!-- tab_container -->

			<!--
			<div class="pc_btn">
				<a href="https://www.hmgpartnerjob.co.kr:444/partner/list.asp">PC��������</a>
			</div>-->
		</div><!--contents -->

</div>
<!-- //���� -->

<!-- �ϴ� -->
<!--#include virtual = "/include/footer.asp"-->
<!-- �ϴ� -->
</body>
</html>
