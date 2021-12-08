<script type="text/javascript">
	function fn_set_area_change(obj, _i) {
		$('[name="area_ul_list1"]').attr('class', 'mmtpBtns'); //1������ class off
		$(obj).attr('class', 'mmtpBtns on'); //������ 1������ class on

		$('[name="area_ul_list2"]').hide(); //2������ ��ü����
		$("#area_ul_list2_" + _i).show(); //������ 1�������� 2������ ����Ʈ ����

		// ����2�� üũ�ڽ�(�ε�� �� �������)
		if ($('[name="resume_area_sub"]').length > 0) {
			var resume_area_sub_val = "";

			$('[name="resume_area_sub"]').each(function(index, item) {
				resume_area_sub_val = this.value

				$('[name="area_check2_val"]').each(function() {
					if (this.value == resume_area_sub_val) {
						this.checked = true;
					}
				});
			});			
		}
	}

	// 2������ ����
	function fn_set_area2(obj, _area1_cd, _area1_nm) {
		var area2_cd, area2_nm, area2_checked
		area2_cd = $(obj).val();
		area2_nm = $(obj).next().html();
		area2_checked = $(obj).is(":checked");

		if (area2_checked) {
			var area_check2_cnt = $('input:checkbox[name="area_check2_val"]:checked').length;

			if (area_check2_cnt > 10) {
				alert("��� �ٹ����� �ִ� 10������ ������ �����մϴ�.");
				fn_set_area2_del(area2_cd);
				return;
			}
			else {
				fn_area2_html(_area1_cd, _area1_nm, area2_cd, area2_nm);
			}
		}
		else {
			fn_set_area2_del(area2_cd);
		}
	}
	
	//���ð� �ϴܿ� ����
	function fn_area2_html(_area1_cd, _area1_nm, _area2_cd, _area2_nm) {
		var up_html = '';

		up_html += '<div class="tt">';
		up_html += '	<input type="hidden" name="view_resume_area" value="' + _area1_cd + '">'
		up_html += '	<input type="hidden" name="view_resume_area_nm" value="' + _area1_nm + '">'
		up_html += '	<input type="hidden" name="view_resume_area_sub" value="' + _area2_cd + '">'
		up_html += '	<input type="hidden" name="view_resume_area_sub_nm" value="' + _area2_nm + '">'
		up_html += 		_area1_nm
		up_html += '	<span class="mmColorBlue2">></span> ' + _area2_nm
		up_html += '	<a href="javascript:;" class="clBtn" title="����" onclick="fn_set_area2_del(\'' + _area2_cd + '\')"></a>';
		up_html += '</div>';

		$('#btm_item_list').append(up_html);
	}

	// ������ ��������, üũ����
	function fn_set_area2_del(_val) {
		// �ϴܺ� ���õ� ����ǥ�� ����
		$('input[name="view_resume_area_sub"]').each(function() {
			if (this.value == _val) {
				$(this).parents(".tt").remove();
			}
		});

		// ����2�� ���õ� üũ�ڽ� ����
		$('input:checkbox[name="area_check2_val"]').each(function() {
			if (this.value == _val) {
				this.checked = false;
			}
		});
	}

	// ������ ��������
	function fn_save_area() {
		var out_html = '';
		var set_area_cnt = $('[name="view_resume_area"]').length;
		
		for (i=0; i<set_area_cnt; i++) {
			var resume_area			= $('[name="view_resume_area"]').eq(i).val();
			var resume_area_nm		= $('[name="view_resume_area_nm"]').eq(i).val();
			var resume_area_sub		= $('[name="view_resume_area_sub"]').eq(i).val();
			var resume_area_sub_nm	= $('[name="view_resume_area_sub_nm"]').eq(i).val();

			out_html += '<input type="hidden" name="resume_area" value="'+ resume_area +'">';
			out_html += '<input type="hidden" name="resume_area_nm" value="'+ resume_area_nm +'">';
			out_html += '<input type="hidden" name="resume_area_sub" value="'+ resume_area_sub +'">';
			out_html += '<input type="hidden" name="resume_area_sub_nm" value="'+ resume_area_sub_nm +'">';
			out_html += '<input type="text" value="' + resume_area_nm + ' > ' + resume_area_sub_nm + '" readonly />';
		}

		$('#div_hope_area').html(out_html);
	}
</script>

<div class="contents" style="padding-bottom: 0;">
	<!-- �̷¼���ϼ�������:S -->
	<div class="mmResumeWrap">
		<div class="resumCreateWrap">
			<div class="mmScrArea">
				<!--
				<style>
					html,body,#contents,.contents,.mmResumeWrap,.resumCreateWrap,.mmScrArea{height: 100%;}
					html,body,#contents{height: 100%; height: calc(100% - (4.2rem + 0.6111rem + 0.6111rem));}
					.mmScrArea .mmScrRow{height: 100vh; height: calc(100% - (0.6111rem + 0.6111rem + 16.4444rem));}
				</style>
				-->
				<div class="mmHr"></div>
				<div class="mmScrRow">
					<div class="mmScrCol6">
						<ul class="mmScrLst">
							<!-- ����ٹ�����(��) ����Ʈ forEach : S-->
							<% For i=0 To UBound(arrListArea1) %>
							<li class="mmtp">
								<button class="mmtpBtns" name="area_ul_list1" onclick="fn_set_area_change(this, '<%=i%>')"><%=arrListArea1(i, 1)%></button>
							</li>
							<% Next %>
							<!-- ����ٹ�����(��) ����Ʈ forEach : E-->
						</ul>
					</div>
					<div class="mmScrCol6">
						<% For i=0 To UBound(arrListArea1) %>
						<ul class="mmScrLst" id="area_ul_list2_<%=i%>" name="area_ul_list2" style="display:none;">
							<!-- ����ٹ�����(��) ����Ʈ forEach : S-->
							<% For ii=0 To UBound(arrListArea2(i)) %>
							<li class="mmtp">
								<input type="checkbox" class="chkrdo" name="area_check2_val" value="<%=arrListArea2(i)(ii, 0)%>" id="CR<%=arrListArea2(i)(ii, 0)%>" onclick="fn_set_area2(this, '<%=arrListArea1(i, 0)%>', '<%=arrListArea1(i, 1)%>')" />
								<label class="lb" for="CR<%=arrListArea2(i)(ii, 0)%>"><%=arrListArea2(i)(ii, 1)%></label>
							</li>
							<% Next %>
							<!-- ����ٹ�����(��) ����Ʈ forEach : E-->
						</ul>
						<% Next %>
					</div>
				</div>
				<div class="mmHr"></div>
				<div class="mmScrBottom">
					<div class="innerWrap">
						<div class="mmBreadCom ">
							<div class="tp ">
								<span class="lb">����</span>
								<div id="btm_item_list" class="txts">
									<%
									If isArray(arrArea) Then
										For i=0 To UBound(arrArea, 2)
									%>
									<div class="tt">
										<input type="hidden" name="view_resume_area" value="<%=arrArea(0, i)%>">
										<input type="hidden" name="view_resume_area_nm" value="<%=getAcName(arrArea(0, i))%>">
										<input type="hidden" name="view_resume_area_sub" value="<%=arrArea(1, i)%>">
										<input type="hidden" name="view_resume_area_sub_nm" value="<%=getAcName(arrArea(1, i))%>">
										<%=getAcName(arrArea(0, i))%><span class="mmColorBlue2">></span> <%=getAcName(arrArea(1, i))%>
										<a href="javascript:;" class="clBtn" title="����" onclick="fn_set_area2_del('<%=arrArea(1, i)%>')"></a>
									</div>
									<%
										Next
									End If
									%>
								</div>
							</div>
						</div>
						<div class="mmBtnsWrap TXTC MT35">
							<a href="javascript:;" class="mmBtns navy bold" onclick="fn_hope(''); fn_save_area();"><small class="MR10">+</small>���� ���ÿϷ�</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- �̷¼���ϼ�������:S -->
</div>