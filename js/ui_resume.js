var count = 0; //���ø�HTML�ȿ� Ȥ�ö� üũ�ڽ��� �������־� ���� üũ�ڽ�/���� label/id�� �ֱ���
function fn_append(val, _self) {
	var $this = $(_self) || $(document);
	var _val = val;
	var _gubun = '';
	if(typeof val === 'object'){
		_val = val.code;
		_gubun = val.gubun;
	}
	if(_val == '2') {
		if(_gubun == '3'){
			$('[name="div_school_high"]').append(createInput2_3(_gubun));
		}else{
			$('[name="div_school_univ"]').append(createInput2(_gubun));
		}
	}
	if(_val == '4') {
		$('[name="div_introduce"]').append(createInput4());
	}
	if(_val == '7') {
		$('[name="div_language"]').append(createInput7());
	}
	if(_val == '8') {
		$('[name="div_license"]').append(createInput8());
	}
	if(_val == '10') {
		$('[name="div_education"]').append(createInput10());
	}
	if(_val == '11') {
		$('[name="div_overseas"]').append(createInput11());
	}
	$('div[name^="div_"]').customTags();
	if($this.closest('div[name^="div_"]').length && $this.closest('.cloneTargetDivision').length){
		$('html,body').stop().animate({
			'scrollTop': $this.closest('div[name^="div_"]').find('.cloneTargetDivision:last')[0].offsetTop
		});
	}
	count++;
}

function fn_remove(_self) {
	var $this = $(_self);
	$this.closest('.cloneTargetDivision').remove();
}


//�з»��� - ��� �ڵ� 3
function createInput2_3(_gubun) {
	var contents = '';

	contents+='<div class="cloneTargetDivision MT30 fnCloneTargetDivision">';
	contents+='	<div class="mmRow border colaps">';
	contents+='		<input type="hidden" id="final_scholar" name="final_scholar" value="">';
	contents+='		<input type="hidden" id="univ_kind" name="univ_kind" value="'+_gubun+'';
	contents+='		<input type="hidden" id="sc_type" name="sc_type" value="2">';
	contents+='		<input type="hidden" id="univ_depth" name="univ_depth" value=""> <!-- �迭�ڵ�(X) -->';
	contents+='		<input type="hidden" id="univ_pointavg" name="univ_pointavg" value=""> <!-- ��������(X) -->';
	contents+='		<input type="hidden" id="univ_code" name="univ_code" value=""> <!-- �����ڵ�(X) -->';
	contents+='		<input type="hidden" id="univ_major_code" name="univ_major_code" value=""> <!-- �����ڵ�(X) -->';
	contents+='		<input type="hidden" id="univ_area" name="univ_area" value=""> <!-- �����ڵ�(X) -->';
	contents+='		<input type="hidden" id="univ_stype" name="univ_stype" value="1"> <!-- �����ڵ�(X) -->';
	contents+='		<input type="hidden" id="univ1_grd" name="univ1_grd" value=""> <!-- ���������ڵ�(X) -->';
	contents+='		<input type="hidden" id="univ_syear" name="univ_syear" value="">';
	contents+='		<input type="hidden" id="univ_smonth" name="univ_smonth" value="">';
	contents+='		<input type="hidden" id="univ_eyear" name="univ_eyear" value="">';
	contents+='		<input type="hidden" id="univ_emonth" name="univ_emonth" value="">';
	contents+='		<input type="hidden" id="univ_etype" name="univ_etype" value=""> <!-- �������� -->';
	contents+='		<input type="hidden" id="univ_minor" name="univ_minor" value=""> <!-- ������ -->';
	contents+='		<input type="hidden" id="univ_mdepth" name="univ_mdepth" value=""> <!-- �������迭�ڵ�(X) -->';
	contents+='		<input type="hidden" id="univ_minor_code" name="univ_minor_code" value=""> <!-- �������ڵ�(X) -->';
	contents+='		<input type="hidden" id="univ_major" name="univ_major" value="">';
	contents+='		<input type="hidden" id="univ_research" name="univ_research" value="">';
	contents+='		<input type="hidden" id="univ_point" name="univ_point" value="">';
	contents+='		<input type="hidden" id="univ_minornm" name="univ_minornm" value="">';
	contents+='		<div class="mmCol12 ">';
	contents+='			<div class="mmCmmInput">';
	contents+='				<div class="ip">';
	contents+='					<input type="text" value="" id="univ_name" name="univ_name" placeholder="�б����� �Է��� �ּ���." onkeyup="fn_kwSearchItem(this, \'high\')" autocomplete="off" />';
	contents+='				</div>';
	contents+='				<!-- �˻���� â : S -->';
	contents+='				<!-- ���� Ŭ���� .mmCmmInput �ȿ� �ڽ����� �־���� -->';
	contents+='				<div class="result_box" id="id_result_box">';
	contents+='				</div>';
	contents+='				<!-- �˻���� â : E -->';
	contents+='			</div>';
	contents+='		</div>';
	contents+='		<div class="mmCol12">';
	contents+='			<select class="fnCustomSelect" name="select_univ_etype" onchange="fn_sel_value_set(this, \'univ_etype\');">';
	contents+='				<option value="">��������</option>';
	contents+='				<option value="3">����</option>';
	contents+='				<option value="4">����</option>';
	contents+='				<option value="5">����</option>';
	contents+='				<option value="7">����(��)</option>';
	contents+='				<option value="8">����</option>';
	contents+='			</select>';
	contents+='		</div>';
	contents+='		<div class="mmCol6">';
	contents+='			<div class="mmCmmInput date fnDatePicker">';
	contents+='				<div class="ip">';
	contents+='					<input type="text" value="" name="univ_sdate" placeholder="���г��" onkeyup="numCheck(this, \'int\'); changeDateType(this); fn_school_s_div(this);" onblur="chkDateType(this)" maxlength="6" />';
	contents+='				</div>';
	contents+='			</div>';
	contents+='		</div>';
	contents+='		<div class="mmCol6">';
	contents+='			<div class="mmCmmInput date fnDatePicker">';
	contents+='				<div class="ip">';
	contents+='					<input type="text" value="" name="univ_edate" placeholder="�������" onkeyup="numCheck(this, \'int\'); changeDateType(this); fn_school_e_div(this);" onblur="chkDateType(this)" maxlength="6" />';
	contents+='				</div>';
	contents+='			</div>';
	contents+='		</div>';
	contents+='		<div class="mmCol12" style="display:none;">';
	contents+='			<div class="mmCmmInput date fnDatePicker">';
	contents+='				<div class="ip">';
	contents+='					<input type="text" value="" name="gde_edate" placeholder="�հݳ��" onkeyup="numCheck(this, \'int\'); changeDateType(this); fn_school_e_div(this);" onblur="chkDateType(this)" maxlength="6" />';
	contents+='				</div>';
	contents+='			</div>';
	contents+='		</div>';
	contents+='	</div>';
	contents+='	<div class="MT30">';
	contents+='		<div class="mmCmmInput radiochk sm">';
	contents+='			<input type="checkbox" id="CC'+count+'" name="gde" value="1" onclick="fn_chk(this);"/>';
	contents+='			<label for="CC'+count+'" class="lb FWB">���� �������</label>';
	contents+='		</div>';
	contents+='	</div>';
	contents+='	<div class="mmBtnsWrap MT30 TXTC">';
	contents+='		<div class="mmRow">';
	contents+='			<div class="mmCol6">';
	contents+= '				<a href="#;" class="mmBtns blue2 outline FWB" onclick="fn_remove(this, true);">�����ϱ�</a>';
	contents+='			</div>';
	contents+='		</div>';
	contents+='	</div>';
	contents+='	<div class="mmHr MT35"></div>';
	contents+='</div>';
	return contents;
}

//�з»���-����
function createInput2(_gubun) {
	var contents = '';

	contents+='<div class="cloneTargetDivision MT30 fnCloneTargetDivision">';
	contents+='	<div class="mmRow border colaps">';
	contents+='		<input type="hidden" id="final_scholar" name="final_scholar" value="">';
	contents+='		<input type="hidden" id="univ_kind" name="univ_kind" value="'+_gubun+'">';
	contents+='		<input type="hidden" id="sc_type" name="sc_type" value="2">';
	contents+='		<input type="hidden" id="univ_depth" name="univ_depth" value=""> <!-- �迭�ڵ�(X) -->';
	contents+='		<input type="hidden" id="univ_pointavg" name="univ_pointavg" value=""> <!-- ��������(X) -->';
	contents+='		<input type="hidden" id="univ_code" name="univ_code" value=""> <!-- �����ڵ�(X) -->';
	contents+='		<input type="hidden" id="univ_major_code" name="univ_major_code" value=""> <!-- �����ڵ�(X) -->';
	contents+='		<input type="hidden" id="univ_area" name="univ_area" value=""> <!-- �����ڵ�(X) -->';
	contents+='		<input type="hidden" id="univ_stype" name="univ_stype" value="1"> <!-- �����ڵ�(X) -->';
	contents+='		<input type="hidden" id="univ1_grd" name="univ1_grd" value=""> <!-- ���������ڵ�(X) -->';
	contents+='		<input type="hidden" id="univ_syear" name="univ_syear" value="">';
	contents+='		<input type="hidden" id="univ_smonth" name="univ_smonth" value="">';
	contents+='		<input type="hidden" id="univ_eyear" name="univ_eyear" value="">';
	contents+='		<input type="hidden" id="univ_emonth" name="univ_emonth" value="">';
	contents+='		<input type="hidden" id="univ_etype" name="univ_etype" value=""> <!-- �������� -->';
	contents+='		<input type="hidden" id="univ_minor" name="univ_minor" value=""> <!-- ������ -->';
	contents+='		<input type="hidden" id="univ_mdepth" name="univ_mdepth" value=""> <!-- �������迭�ڵ�(X) -->';
	contents+='		<input type="hidden" id="univ_minor_code" name="univ_minor_code" value=""> <!-- �������ڵ�(X) -->';
	contents+='		<div class="mmCol12 ">';
	contents+='			<div class="mmCmmInput">';
	contents+='				<div class="ip">';
	contents+='					<input type="text" value="" id="univ_name" name="univ_name" placeholder="�б����� �Է��� �ּ���." onkeyup="fn_kwSearchItem(this, \'univ\')" autocomplete="off" />';
	contents+='				</div>';
	contents+='				<!-- �˻���� â : S -->';
	contents+='				<!-- ���� Ŭ���� .mmCmmInput �ȿ� �ڽ����� �־���� -->';
	contents+='				<div class="result_box" id="id_result_box">';
	contents+='				</div>';
	contents+='				<!-- �˻���� â : E -->';
	contents+='			</div>';
	contents+='		</div>';
	contents+='		<div class="mmCol12">';
	contents+='			<select class="fnCustomSelect" name="select_univ_etype" onchange="fn_sel_value_set(this, \'univ_etype\');">';
	contents+='				<option value="">��������</option>';
	contents+='				<option value="3">����</option>';
	contents+='				<option value="4">����</option>';
	contents+='				<option value="5">����</option>';
	contents+='				<option value="7">����(��)</option>';
	contents+='				<option value="8">����</option>';
	contents+='			</select>';
	contents+='		</div>';
	contents+='		<div class="mmCol6">';
	contents+='			<div class="mmCmmInput date fnDatePicker">';
	contents+='				<div class="ip">';
	contents+='					<input type="text" value="" name="univ_sdate" placeholder="���г��" onkeyup="numCheck(this, \'int\'); changeDateType(this); fn_school_s_div(this);" onblur="chkDateType(this)" maxlength="6" />';
	contents+='				</div>';
	contents+='			</div>';
	contents+='		</div>';
	contents+='		<div class="mmCol6">';
	contents+='			<div class="mmCmmInput date fnDatePicker">';
	contents+='				<div class="ip">';
	contents+='					<input type="text" value="" name="univ_edate" placeholder="�������" onkeyup="numCheck(this, \'int\'); changeDateType(this); fn_school_e_div(this);" onblur="chkDateType(this)" maxlength="6" />';
	contents+='				</div>';
	contents+='			</div>';
	contents+='		</div>';
	contents+='	</div>';
	//contents+='	<% If schoolGubun = "6" Then %>';
	if(_gubun == '6'){
	contents+='	<div class="mmTit MT55">����</div>';
	contents+='	<div class="mmRow border colaps MT20">';
	contents+='		<div class="mmCol12">';
	contents+='			<select class="fnCustomSelect" name="select_univ1_grd" onchange="fn_sel_value_set(this, \'univ1_grd\');">';
	contents+='				<option value="">��������</option>';
	contents+='				<option value="1">����</option>';
	contents+='				<option value="2">�ڻ�</option>';
	contents+='				<option value="3">���ڻ�</option>';
	contents+='			</select>';
	contents+='		</div>';
	contents+='	</div>';
	}
	//contents+='	<% End If %>';
	contents+='	<!-- ���� : S-->';
	contents+='	<div class="mmTit MT55">����</div>';
	contents+='	<div class="mmRow border colaps MT20">';
	contents+='		<!--';
	contents+='		<div class="mmCol12">';
	contents+='			<select class="fnCustomSelect">';
	contents+='				<option value="">������ ������ �ּ���. </option>';
	contents+='			</select>';
	contents+='		</div>-->';
	contents+='		<div class="mmCol12 ">';
	contents+='			<div class="mmCmmInput">';
	contents+='				<div class="ip">';
	contents+='					<input type="text" value="" id="univ_major" name="univ_major" placeholder="������ �Է��� �ּ���." onkeyup="fn_kwSearchItem(this, \'major\')" autocomplete="off" />';
	contents+='				</div>';
	contents+='				<!-- �˻���� â : S -->';
	contents+='				<!-- ���� Ŭ���� .mmCmmInput �ȿ� �ڽ����� �־���� -->';
	contents+='				<div class="result_box" id="id_result_box">';
	contents+='				</div>';
	contents+='				<!-- �˻���� â : E -->';
	contents+='			</div>';
	contents+='		</div>';
	contents+='	</div>';
	contents+='	<!-- ���� : E-->';
	contents+='	<!-- ���� : S-->';
	contents+='	<div class="mmTit MT55">����</div>';
	contents+='	<div class="mmRow border colaps MT20">';
	contents+='		<div class="mmCol8">';
	contents+='			<div class="mmCmmInput">';
	contents+='				<div class="ip">';
	contents+='					<input type="text" value="" id="univ_point" name="univ_point" placeholder="������ �Է��� �ּ���." maxlength="4" />';
	contents+='				</div>';
	contents+='			</div>';
	contents+='		</div>';
	contents+='		<div class="mmCol4 ">';
	contents+='			<select class="fnCustomSelect" name="select_univ_pointavg" onchange="fn_sel_value_set(this, \'univ_pointavg\');">';
	contents+='				<option value="">����</option>';
	contents+='				<option value="4.0">4.0</option>';
	contents+='				<option value="4.3">4.3</option>';
	contents+='				<option value="4.5">4.5</option>';
	contents+='				<option value="7.0">7.0</option>';
	contents+='				<option value="100">100</option>';
	contents+='			</select>';
	contents+='		</div>';
	contents+='	</div>';
	contents+='	<!-- ���� : E-->';
	contents+='	<!-- �����߰� : S-->';
	contents+='	<div name="div_univ_add_minor" style="display:none;">';
	contents+='		<div class="mmTit MT55">�߰�����</div>';
	contents+='		<div class="mmRow border colaps MT20">';
	contents+='			<div class="mmCol8">';
	contents+='				<div class="mmCmmInput">';
	contents+='					<div class="ip">';
	contents+='						<input type="text" value="" id="univ_minornm" name="univ_minornm" placeholder="������ �Է��� �ּ���." onkeyup="fn_kwSearchItem(this, \'major\')" autocomplete="off" />';
	contents+='					</div>';
	contents+='					<!-- �˻���� â : S -->';
	contents+='					<!-- ���� Ŭ���� .mmCmmInput �ȿ� �ڽ����� �־���� -->';
	contents+='					<div class="result_box" id="id_result_box">';
	contents+='					</div>';
	contents+='					<!-- �˻���� â : E -->';
	contents+='				</div>';
	contents+='			</div>';
	contents+='			<div class="mmCol4 ">';
	contents+='				<select class="fnCustomSelect" name="select_univ_minor" onchange="fn_sel_value_set(this, \'univ_minor\');">';
	contents+='					<option value="">��������</option>';
	contents+='					<option value="��">������</option>';
	contents+='					<option value="����">��������</option>';
	contents+='				</select>';
	contents+='			</div>';
	contents+='		</div>';
	contents+='	</div>';
	contents+='	<!-- �����߰� : E-->';
	contents+='	<div class="mmBtnsWrap TXTC MT25">';
	contents+='		<div class="mmRow">';
	contents+='			<div class="mmCol6"><a href="javascript:;" class="mmBtns blue FWB" onclick="fn_univ_minor(this);"><small class="MR10">+</small>���� �߰�</a></div>';
	contents+='		</div>';
	contents+='	</div>';
	contents+='	<!-- �̼����� �� �������� : S-->';
	contents+='	<div class="mmTit MT65">�̼����� �� ��������</div>';
	contents+='	<div class="mmRow border colaps MT20">';
	contents+='		<div class="mmCol12">';
	contents+='			<div class="mmCmmInput">';
	contents+='				<div class="ip">';
	contents+='					<input type="text" value="" id="univ_research" name="univ_research" placeholder="�̼����� �� ���������� �Է��� �ּ���." />';
	contents+='				</div>';
	contents+='			</div>';
	contents+='		</div>';
	contents+='	</div>';
	contents+='	<!-- �̼����� �� �������� : E-->';
	contents+='<div class="mmBtnsWrap MT30 TXTC">';
	contents+='	<div class="mmRow">';
	contents+='		<div class="mmCol6">';
	contents+= '				<a href="#;" class="mmBtns blue2 outline FWB" onclick="fn_remove(this, true);">�����ϱ�</a>';
	contents+='		</div>';
	contents+='	</div>';
	contents+='</div>';
	contents+='<div class="mmHr MT35"></div>';
	contents+='</div>';

	return contents;
}

//�ܱ���
function createInput7() {
	var language_sel_option = $("#language_sel_option").html();

	var contents = '';

	contents += '<div class="cloneTargetDivision MT30 fnCloneTargetDivision">';
	contents += '	<div class="mmRow border colaps">';
	contents += '		<div class="mmCol12">';
	contents += '			<select class="fnCustomSelect" onchange="fn_language_reset(this);">';
	contents += '				<option value="">����</option>';
	contents += '				<option value="1">ȸȭ�ɷ�</option>';
	contents += '				<option value="2">���ν���</option>';
	contents += '			</select>';
	contents += '		</div>';
	contents += '	</div>';
	contents += '	<!--ȸȭ-->';
	contents += '	<div class="mmRow border colaps MT60" name="language_type1" style="display:none;">';
	contents += '		<input type="hidden" id="language_name" name="language_name" value="" />';
	contents += '		<input type="hidden" id="language_talk" name="language_talk" value="" />';
	contents += '		<input type="hidden" id="language_read" name="language_read" value="" />';
	contents += '		<input type="hidden" id="language_write" name="language_write" value="" />';
	contents += '		<div class="mmCol12">';
	contents += '			<select class="fnCustomSelect" id="language_title_name" onchange="fn_sel_value_set(this, \'language_name\');">';
	contents += '				<option value="">�ܱ������ ������ �ּ���.</option>';
	contents += 				language_sel_option;
	contents += '			</select>';
	contents += '		</div>';
	contents += '		<div class="mmCol12">';
	contents += '			<select class="fnCustomSelect" id="language_title_talk" onchange="fn_sel_value_set(this, \'language_talk\');">';
	contents += '				<option value="">ȸȭ �ɷ��� ������ �ּ���.</option>';
	contents += '				<option value="1">��</option>';
	contents += '				<option value="2">��</option>';
	contents += '				<option value="3">��</option>';
	contents += '			</select>';
	contents += '		</div>';
	contents += '	</div>';
	contents += '	<!--ȸȭ-->';
	contents += '	<!--����-->';
	contents += '	<div class="mmRow border colaps MT60" name="language_type2" style="display:none;">';
	contents += '		<input type="hidden" id="language_exam_group" name="language_exam_group" value="" />';
	contents += '		<input type="hidden" id="language_exam" name="language_exam" value="" />';
	contents += '		<input type="hidden" id="language_year" name="language_year" value="" />';
	contents += '		<input type="hidden" id="language_month" name="language_month" value="" />';
	contents += '		<input type="hidden" id="language_exam_etc" name="language_exam_etc" value="" />';
	contents += '		<input type="hidden" id="language_grade_opic" name="language_grade_opic" value="" />';
	contents += '		<div class="mmCol12">';
	contents += '			<select class="fnCustomSelect" id="language_title_exam_group" onchange="fn_sel_value_set(this, \'language_exam_group\'); fn_chgLanguage(this);">';
	contents += '				<option value="">�ܱ������ ������ �ּ���.</option>';
	contents += '				<option value="1">����</option>';
	contents += '				<option value="2">�Ϻ���</option>';
	contents += '				<option value="3">�߱���</option>';
	contents += '				<option value="4">��������</option>';
	contents += '				<option value="5">���Ͼ�</option>';
	contents += '			</select>';
	contents += '		</div>';
	contents += '		<div class="mmCol12">';
	contents += '			<select class="fnCustomSelect" id="language_title_exam" onchange="fn_sel_value_set(this, \'language_exam\');">';
	contents += '				<option value="">���� ���� ����</option>';
	contents += '			</select>';
	contents += '		</div>';
	contents += '		<div class="mmCol8">';
	contents += '			<div class="mmCmmInput">';
	contents += '				<div class="ip">';
	contents += '					<input type="text" value="" name="language_grade" placeholder="�������/�޼��� �Է��� �ּ���." />';
	contents += '				</div>';
	contents += '			</div>';
	contents += '		</div>';
	contents += '		<div class="mmCol4">';
	contents += '			<select class="fnCustomSelect" onchange="fn_sel_value_set(this, \'language_exam_etc\');">';
	contents += '				<option value="">����/�޼� ����</option>';
	contents += '				<option value="1">����</option>';
	contents += '				<option value="2">�޼�</option>';
	contents += '			</select>';
	contents += '		</div>';
	contents += '		<div class="mmCol12">';
	contents += '			<div class="mmCmmInput date fnDatePicker">';
	contents += '				<div class="ip">';
	contents += '					<input type="text" value="" name="language_date" placeholder="�����" onkeyup="numCheck(this, \'int\'); changeDateType(this); fn_language_div(this);" onblur="chkDateType(this)" maxlength="6" />';
	contents += '				</div>';
	contents += '			</div>';
	contents += '		</div>';
	contents += '	</div>';
	contents += '	<!--����-->';
	contents += '	<div class="mmBtnsWrap MT30 TXTC">';
	contents += '		<div class="mmRow">';
	contents += '			<div class="mmCol7">';
	contents += '				<a href="#;" class="mmBtns blue2 outline FWB" onclick="fn_remove(this, true);">�����ϱ�</a>';
	contents += '			</div>';
	contents += '		</div>';
	contents += '	</div>';
	contents += '	<div class="mmHr MT35"></div>';
	contents += '</div>';

	return contents;
}

//�ڱ�Ұ���
function createInput4() {
	var contents = '';

	contents+='<div class="cloneTargetDivision MT30 fnCloneTargetDivision">';
	contents+='	<div class="mmRow border colaps">';
	contents+='		<input type="hidden" id="res_seq" name="res_seq" value="0">';
	contents+='		<div class="mmCol12">';
	contents+='			<div class="mmCmmInput">';
	contents+='				<div class="ip">';
	contents+='					<input type="text" value="" name="res_quotation" placeholder="�׸��� �Է��� �ּ���" />';
	contents+='				</div>';
	contents+='			</div>';
	contents+='		</div>';
	contents+='	</div>';
	contents+='	<div class="mmRow colaps MT15">';
	contents+='		<div class="mmCol12">';
	contents+='			<div class="mmCmmInput">';
	contents+='				<div class="ip">';
	contents+='					<textarea value="" id="res_content" name="res_content" placeholder="�ش� ������ �Է��� �ּ���." style="height: 24rem;"></textarea>';
	contents+='				</div>';
	contents+='			</div>';
	contents+='		</div>';
	contents+='	</div>';
	contents += '	<div class="mmBtnsWrap MT30 TXTC">';
	contents += '		<div class="mmRow">';
	contents += '			<div class="mmCol6">';
	contents += '				<a href="#;" class="mmBtns blue2 FWB" onclick="fn_append(\'4\', this);"><small class="MR10">+</small>�߰��ϱ�</a>';
	contents += '			</div>';
	contents += '			<div class="mmCol6">';
	contents += '				<a href="#;" class="mmBtns blue2 outline FWB" onclick="fn_remove(this, true);">�����ϱ�</a>';
	contents += '			</div>';
	contents += '		</div>';
	contents += '	</div>';
	contents+='<div class="mmHr MT35"></div>';
	contents+='</div>';

	return contents;
}

//�ڰ���
function createInput8(){
	var contents = '';

	contents+='<div class="cloneTargetDivision MT30 fnCloneTargetDivision">';
	contents+='	<div class="mmRow border colaps">';
	contents+='		<input type="hidden" name="license_code" value="" />';
	contents+='		<input type="hidden" id="license_year" name="license_year" value="" />';
	contents+='		<input type="hidden" id="license_month" name="license_month" value="" />';
	contents+='		<div class="mmCol12 ">';
	contents+='			<div class="mmCmmInput">';
	contents+='				<div class="ip">';
	contents+='					<input type="text" value="" id="license_name" name="license_name" placeholder="�ڰ������� �Է��� �ּ���." onkeyup="fn_kwSearchItem(this, \'license\')" autocomplete="off" />';
	contents+='				</div>';
	contents+='				<!-- �˻���� â : S -->';
	contents+='				<!-- ���� Ŭ���� .mmCmmInput �ȿ� �ڽ����� �־���� -->';
	contents+='				<div class="result_box" id="id_result_box">';
	contents+='				</div>';
	contents+='				<!-- �˻���� â : E -->';
	contents+='			</div>';
	contents+='		</div>';
	contents+='		<div class="mmCol12 ">';
	contents+='			<div class="mmCmmInput">';
	contents+='				<div class="ip">';
	contents+='					<input type="text" value="" name="license_org" placeholder="�������� �Է��� �ּ���." />';
	contents+='				</div>';
	contents+='			</div>';
	contents+='		</div>';
	contents+='		<div class="mmCol12">';
	contents+='			<div class="mmCmmInput date fnDatePicker">';
	contents+='				<div class="ip">';
	contents+='					<input type="text" value="" name="license_date" placeholder="�����" onkeyup="numCheck(this, \'int\'); changeDateType(this); fn_license_div(this);" onblur="chkDateType(this)" maxlength="6" />';
	contents+='				</div>';
	contents+='			</div>';
	contents+='		</div>';
	contents+='	</div>';
	contents+='	<div class="mmBtnsWrap MT30 TXTC">';
	contents+='		<div class="mmRow">';
	contents+='			<div class="mmCol7">';
	contents+='				<a href="#;" class="mmBtns blue2 outline FWB" onclick="fn_remove(this, true);">�����ϱ�</a>';
	contents+='			</div>';
	contents+='		</div>';
	contents+='	</div>';
	contents+='	<div class="mmHr MT35"></div>';
	contents+='</div>';

	return contents;
}

//����
function createInput10(){
	var contents = '';

	contents+='<div class="cloneTargetDivision MT30 fnCloneTargetDivision">';
	contents+='	<div class="mmRow border colaps">';
	contents+='		<input type="hidden" id="academy_syear" name="academy_syear" value="" />';
	contents+='		<input type="hidden" id="academy_smonth" name="academy_smonth" value="" />';
	contents+='		<input type="hidden" id="academy_eyear" name="academy_eyear" value="" />';
	contents+='		<input type="hidden" id="academy_emonth" name="academy_emonth" value="" />';
	contents+='		<div class="mmCol12">';
	contents+='			<div class="mmCmmInput">';
	contents+='				<div class="ip">';
	contents+='					<input type="text" value="" name="academy_name" placeholder="�������� �Է��� �ּ���." />';
	contents+='				</div>';
	contents+='			</div>';
	contents+='		</div>';
	contents+='		<div class="mmCol12">';
	contents+='			<div class="mmCmmInput">';
	contents+='				<div class="ip">';
	contents+='					<input type="text" value="" name="academy_org_name" placeholder="��������� �Է��� �ּ���." />';
	contents+='				</div>';
	contents+='			</div>';
	contents+='		</div>';
	contents+='		<div class="mmCol6">';
	contents+='			<div class="mmCmmInput date fnDatePicker">';
	contents+='				<div class="ip">';
	contents+='					<input type="text" value="" name="academy_sdate" placeholder="���۳��" onkeyup="numCheck(this, \'int\'); changeDateType(this); fn_education_s_div(this);" onblur="chkDateType(this)" maxlength="6" />';
	contents+='				</div>';
	contents+='			</div>';
	contents+='		</div>';
	contents+='		<div class="mmCol6">';
	contents+='			<div class="mmCmmInput date fnDatePicker">';
	contents+='				<div class="ip">';
	contents+='					<input type="text" value="" name="academy_edate" placeholder="������" onkeyup="numCheck(this, \'int\'); changeDateType(this); fn_education_e_div(this);" onblur="chkDateType(this)" maxlength="6" />';
	contents+='				</div>';
	contents+='			</div>';
	contents+='		</div>';
	contents+='	</div>';
	contents+='	<div class="mmBtnsWrap MT30 TXTC">';
	contents+='		<div class="mmRow">';
	contents+='			<div class="mmCol7">';
	contents+='				<a href="#;" class="mmBtns blue2 outline FWB" onclick="fn_remove(this, true);">�����ϱ�</a>';
	contents+='			</div>';
	contents+='		</div>';
	contents+='	</div>';
	contents+='	<div class="mmHr MT35"></div>';
	contents+='</div>';

	return contents;
}

//�ؿܰ���
function createInput11(){
	var overseas_sel_option = $("#overseas_sel_option").html();

	var contents = '';

	contents+='<div class="cloneTargetDivision MT30 fnCloneTargetDivision">';
	contents+='	<div class="mmRow border colaps">';
	contents+='		<input type="hidden" id="abroad_nation_code" name="abroad_nation_code" value="" />';
	contents+='		<input type="hidden" id="abroad_org_name" name="abroad_org_name" value="" />';
	contents+='		<input type="hidden" id="abroad_syear" name="abroad_syear" value="" />';
	contents+='		<input type="hidden" id="abroad_smonth" name="abroad_smonth" value="" />';
	contents+='		<input type="hidden" id="abroad_eyear" name="abroad_eyear" value="" />';
	contents+='		<input type="hidden" id="abroad_emonth" name="abroad_emonth" value="" />';
	contents+='		<div class="mmCol12">';
	contents+='			<select class="fnCustomSelect" name="select_abroad_nation_code" onchange="fn_sel_value_set(this, \'abroad_nation_code\');">';
	contents+='				<option value="">��������</option>';
	contents+=				overseas_sel_option;
	contents+='			</select>';
	contents+='		</div>';
	contents+='		<div class="mmCol6">';
	contents+='			<div class="mmCmmInput date fnDatePicker">';
	contents+='				<div class="ip">';
	contents+='					<input type="text" value="" name="abroad_sdate" placeholder="���۳��" onkeyup="numCheck(this, \'int\'); changeDateType(this); fn_overseas_s_div(this);" onblur="chkDateType(this)" maxlength="6" />';
	contents+='				</div>';
	contents+='			</div>';
	contents+='		</div>';
	contents+='		<div class="mmCol6">';
	contents+='			<div class="mmCmmInput date fnDatePicker">';
	contents+='				<div class="ip">';
	contents+='					<input type="text" value="" name="abroad_edate" placeholder="������" onkeyup="numCheck(this, \'int\'); changeDateType(this); fn_overseas_e_div(this);" onblur="chkDateType(this)" maxlength="6" />';
	contents+='				</div>';
	contents+='			</div>';
	contents+='		</div>';
	contents+='	</div>';
	contents+='	<!-- �ؿܰ��� ���� : S-->';
	contents+='	<div class="mmTit MT55">�ؿܰ��� ����</div>';
	contents+='	<div class="mmRow border colaps MT20">';
	contents+='		<div class="mmCol12">';
	contents+='			<div class="mmCmmInput">';
	contents+='				<div class="ip">';
	contents+='					<textarea name="abroad_academy_name" value="" placeholder="�ؿܰ��� (ex.���п���, ��ȯ�л�, ��ŷ Ȧ������,�ؿܱٹ�)�� ������ �ּ���. "></textarea>';
	contents+='				</div>';
	contents+='			</div>';
	contents+='		</div>';
	contents+='	</div>';
	contents+='	<!-- �ؿܰ��� ���� : E-->';
	contents+='	<div class="mmBtnsWrap MT30 TXTC">';
	contents+='		<div class="mmRow">';
	contents+='			<div class="mmCol7">';
	contents+='				<a href="#;" class="mmBtns blue2 outline FWB" onclick="fn_remove(this, true);">�����ϱ�</a>';
	contents+='			</div>';
	contents+='		</div>';
	contents+='	</div>';
	contents+='	<div class="mmHr MT35"></div>';
	contents+='</div>';

	return contents;
}
