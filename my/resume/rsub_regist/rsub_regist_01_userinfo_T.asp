<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">
	function fn_userphone_div(obj) {
		if (obj.value.length >= 12) {
			var split_val = obj.value.split('-');
			if (split_val.length == 3) {
				$('#contents').find("#user_cell1").val(split_val[0]);
				$('#contents').find("#user_cell2").val(split_val[1]);
				$('#contents').find("#user_cell3").val(split_val[2]);
			}
		} else {
			$('#contents').find("#user_cell1").val("");
			$('#contents').find("#user_cell2").val("");
			$('#contents').find("#user_cell3").val("");
		}
	}

	function fn_useremail_div(obj) {
		if (obj.value.indexOf("@") >= 0) {
			var split_val = obj.value.split('@');
			$("#email1").val(split_val[0]);
			$("#email2").val(split_val[1]);
		} else {
			$("#email1").val("");
			$("#email2").val("");
		}
	}

	function fn_userbirth_div(obj) {
		if (obj.value.length == 10) {
			var split_val = obj.value.split('.');
			$("#birthYY").val(split_val[0]);
			$("#birthMM").val(split_val[1]);
			$("#birthDD").val(split_val[2]);
			if (split_val[0] < 2000) {
				$("#jumin_code").val("1");
			} else {
				$("#jumin_code").val("3");
			}
		} else {
			$("#birthYY").val("");
			$("#birthMM").val("");
			$("#birthDD").val("");
			$("#jumin_code").val("");
		}
	}

	// ���� ���/����
	function fn_photo(val){
		if(val == 'reg') {
			$('#frm_resume').attr('action', '/my/resume/photo_write_T.asp');
			$('#frm_resume').submit();
		}
		else {
			if(confirm('�Ի����� �Ϸ�� �������� ������\n��� �������� ��ϵ� ������ �ϰ� �����˴ϴ�.\n��ϵ� ������ ������ �����Ͻðڽ��ϱ�?')) {
				$('#frm_resume').attr('action', '/my/resume/photo_del.asp');
				$('#frm_resume').submit();
			}
		}
	}
</script>

<!-- container -->
<div id="contents" class="sub_page">
	<input type="hidden" id="user_photo" name="user_photo" value="<%=Replace(p_userPhoto, "/files/mypic/", "")%>">
	<input type="hidden" id="birthYY" name="birthYY" value="<%=p_birthYY%>">
	<input type="hidden" id="birthMM" name="birthMM" value="<%=p_birthMM%>">
	<input type="hidden" id="birthDD" name="birthDD" value="<%=p_birthDD%>">
	<input type="hidden" id="jumin_code" name="jumin_code" value="<%=p_jumin_code%>">
	<input type="hidden" id="user_cell1" name="user_cell1" value="<%=p_phone1%>">
	<input type="hidden" id="user_cell2" name="user_cell2" value="<%=p_phone2%>">
	<input type="hidden" id="user_cell3" name="user_cell3" value="<%=p_phone3%>">
	<input type="hidden" id="email1" name="email1" value="<%=p_email1%>">
	<input type="hidden" id="email2" name="email2" value="<%=p_email2%>">
	<!-- <input type="hidden" id="resume_title" name="resume_title" value="<%=p_userName%>���� �̷¼��Դϴ�."> -->
	<input type="hidden" id="address" name="address" value="<%=p_address%>">

	<div class="contents">
		<!-- �̷¼���ϼ�������:S -->
		<div class="mmResumeWrap">
			<div class="profileCreate MT50">
				<div class="innerWrap">

					<div class="profileCreateTop TXTC">
						<div class="mmThumb lg marginAuto">
							<div class="mmThumbInner">
								<img src="<%=p_userPhotoURL%>" alt="">
							</div>
						</div>
						<a href="javascript:;" class="mmBtns blue2 md bold MT20" onclick="fn_photo('reg');"><small class="MR10">+</small><%=p_imgbtn%></a>

						<% If p_userPhoto <>"" Then %>
						<a href="javascript:;" class="mmBtns gray md outline bold MT20" onclick="fn_photo('del');">��������</a>
						<% End If %>
					</div>
					<div class="profileCreateCont MT30">

						<div class="mmLstArea tp2">
							<ul class="mmlstUl">

								<li class="mmLstTp ">
									<div class="inner">
										<a href="javascript:;" class="txts">
											<span class="lb">����</span>
											<div class="tt">
												<div class="mmCmmInput">
													<div class="ip">
														<input type="text" id="resume_title" name="resume_title" placeholder="������ �Է��� �ּ���." value="<%=p_resumeTitle%>">
													</div>
												</div>
											</div>
										</a>
									</div>
								</li>
								<li class="mmLstTp ">
									<div class="inner">
										<a href="javascript:;" class="txts">
											<span class="lb">�̸�</span>
											<div class="tt">
												<div class="mmCmmInput">
													<div class="ip">
														<input type="text" id="userName" name="userName" placeholder="�̸��� �Է��� �ּ���." value="<%=p_userName%>">
													</div>
												</div>
											</div>
										</a>
									</div>
								</li>
								<li class="mmLstTp ">
									<div class="inner">
										<a href="javascript:;" class="txts">
											<span class="lb">�޴���</span>
											<div class="tt">
												<div class="mmCmmInput">
													<div class="ip">
														<input type="text" id="user_cell" name="user_cell" placeholder="�޴����� �Է��� �ּ���." value="<%=p_phone%>" onkeyup="numCheck(this, 'int'); changePhoneType(this); fn_userphone_div(this);" maxlength="13">
													</div>
												</div>
											</div>
										</a>
									</div>
								</li>
								<li class="mmLstTp ">
									<div class="inner">
										<a href="javascript:;" class="txts">
											<span class="lb">�̸���</span>
											<div class="tt">
												<div class="mmCmmInput">
													<div class="ip">
														<input type="text" id="email" name="email" placeholder="�̸����� �Է��� �ּ���." value="<%=p_email%>" onkeyup="fn_useremail_div(this);" maxlength="50">
													</div>
												</div>
											</div>
										</a>
									</div>
								</li>
								<!--
								<li class="mmLstTp ">
									<div class="inner">
										<div class="txts">
											<span class="lb">����</span>
											<div class="tt">
												<select class="fnCustomSelect">
													<option selected value="">�������ּ���</option>
													<option value="����">����</option>
													<option value="����">����</option>
												</select>
											</div>
										</div>
									</div>
								</li>
								-->
								<li class="mmLstTp ">
									<div class="inner">
										<a href="javascript:;" class="txts">
											<span class="lb">�������</span>
											<div class="tt">
												<div class="mmCmmInput">
													<div class="ip">
														<input type="text" id="birth" name="birth" placeholder="��������� �Է��� �ּ���.(ex. YYYYMMDD)" value="<%=p_birth%>" onkeyup="numCheck(this, 'int'); changeBirthType(this); fn_userbirth_div(this);" maxlength="10">
													</div>
												</div>
											</div>
										</a>
									</div>
								</li>
								<li class="mmLstTp paddingRight">
									<div class="inner">
										<a href="javascript:;" class="txts">
											<span class="lb">�ּ�</span>
											<div class="tt">
												<div class="mmCmmInput">
													<div class="ip">
														<input type="text" id="address_main" name="address_main" placeholder="�ּҸ� �Է��� �ּ���." value="<%=p_address%>" readonly>
													</div>
												</div>
											</div>
											<a href="javascript:;" class="mmBtns gray sm normalRadius bold" onclick="openPostCode('','address', 'address_main');">�˻�</a>
										</a>
									</div>
								</li>
								<li class="mmLstTp ">
									<div class="inner">
										<a href="javascript:;" class="txts">
											<span class="lb">�����Ұ�</span>
											<div class="tt">
												<div class="mmCmmInput">
													<div class="ip">
														<textarea class="resume_tt" id="self_intro" name="self_intro" placeholder="�λ������� ������ �� �� �ִ� ������ �ڱ�Ұ��� �ۼ��غ����� (5�� �̳��� ����)"><%=p_selfIntro%></textarea>
													</div>
												</div>
											</div>
										</a>
									</div>
								</li>
							</ul>
						</div>

						<div class="mmBtnsWrap TXTC MT60">
							<% If rtype = "C" Then %>
							<a href="javascript:;" class="mmBtns navy FWB" onclick="fn_resume_save2();">�����ϱ�</a>
							<% Else %>
							<a href="javascript:;" class="mmBtns navy FWB" onclick="fn_resume_save_imsi();">�����ϱ�</a>
							<% End If %>
						</div>

					</div>

				</div>
			</div>
		</div>
		<!-- �̷¼���ϼ�������:S -->
	</div>
</div>
<!-- //container -->
