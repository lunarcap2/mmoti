<!-- <script type="text/javascript" src="/js/resume_renew.js"></script> -->

<%
'arrIngResume	= arrData(0)(0)	'�ۼ����� �̷¼���ȣ(�߰�����)
'arrBase		= arrData(0)(1)	'�⺻�̷¼�
'arrUser		= arrData(0)(2)	'����ȸ������(�̷¼���)
'arrComm		= arrData(0)(3)	'�̷¼� ��������
'arrResume		= arrData(0)(4)	'�̷¼�1,2
'
'arrSchool		= arrData(0)(5)	'�̷¼��з�
'arrCareer		= arrData(0)(6)	'�̷¼����
'arrActivity	= arrData(0)(7)	'�ֿ�Ȱ������(����,���Ȱ��)
'
'arrLanguageUse	= arrData(0)(8)	'�ܱ��� ȸȭ�ɷ�
'arrLanguageExam= arrData(0)(9)	'�ܱ��� ���ν���
'arrLicense		= arrData(0)(10)'�ڰ���
'arrPrize		= arrData(0)(11)'����
'arrAcademy		= arrData(0)(12)'����
'arrAbroad		= arrData(0)(13)'�ؿܿ���
'
'arrPersonal	= arrData(0)(14)'����/���
'arrMilitary	= arrData(0)(15)'����
'arrEmpSupport	= arrData(0)(16)'��������ݴ��
'
'arrPortfolio	= arrData(0)(17)'��Ʈ������
'
'arrWorkType	= arrData(0)(18)'����ٹ�����
'arrArea		= arrData(0)(19)'�������
'arrCtKwd		= arrData(0)(20)'�������
'arrJcKwd		= arrData(0)(21)'�������
'
'arrNew_Essay	= arrData(0)(22)'�ڱ�Ұ���


'�̷¼� ��������
Dim p_birth, p_birthYY, p_birthMM, p_birthDD, p_jumin_code, p_phone, p_phone1, p_phone2, p_phone3, p_email, p_email1, p_email2, p_userName, p_address, p_userPhoto, p_selfIntro, p_age
If isArray(arrComm) Then
	p_phone			= arrComm(8, 0)
	p_birthYY		= arrComm(1, 0)
	p_birthMM		= arrComm(2, 0)
	p_birthDD		= arrComm(3, 0)
	p_jumin_code	= arrComm(4, 0)
	If p_jumin_code = "1" Or p_jumin_code = "2" Then
		p_birthYY = "19" & p_birthYY
	Else
		p_birthYY = "20" & p_birthYY
	End If
	p_birth			= p_birthYY & "." & p_birthMM & "." & p_birthDD
	p_email			= arrComm(10, 0)
	p_email1		= Split(arrComm(10, 0), "@")(0)
	p_email2		= Split(arrComm(10, 0), "@")(1)
	p_userName		= arrComm(0, 0)
	p_address		= arrComm(13, 0)
	p_age			= year(date) - p_birthYY + 1
	If arrComm(19, 0) <> "" Then p_userPhoto = "http://www2.career.co.kr/hdrive/fair/mypic/" & arrComm(19, 0)

End If

Dim cal_sdate, cal_edate, cal_datediff, cal_datediff_month
cal_datediff_month = 0

Function getDateDiff(p_sdate, p_edate)
	Dim out_value, sdate, edate

	sdate = Replace(p_sdate, ".", "-")
	edate = Replace(p_edate, ".", "-")

	If isDate(sdate) And isDate(edate) Then
		out_value = Datediff("m", sdate, edate) +1

		If out_value > 11 Then
			If out_value mod 12 > 0 Then
				out_value = fix(out_value / 12) & "�� " & out_value mod 12 & "����"
			Else
				out_value = fix(out_value / 12) & "��"
			End If
		Else
			out_value = out_value & "����"
		End If
	End If

	getDateDiff = out_value
End Function


Function getDateDiffMonth(p_sdate, p_edate)
	Dim out_value, sdate, edate

	sdate = Replace(p_sdate, ".", "-")
	edate = Replace(p_edate, ".", "-")

	If isDate(sdate) And isDate(edate) Then
		out_value = Datediff("m", sdate, edate) +1
	End If

	getDateDiffMonth = out_value
End Function

%>

<!-- container -->
<div id="contents" class="sub_page">
	<div class="contents detail">

		<div class="resume_area">
			<div class="resume_view cust_resume_view">

				<div id="view1" class="view_box">
					<h3 class="name"><%=p_userName%><span>(<%=p_age%>��)</span></h3>
					<div class="img_box">
						<span><img src="<%=p_userPhoto%>"></span>
					</div>
					<div class="vb_area">
						<div class="vb_item">
							<div class="vb_label">����ó</div>
							<div class="vb_value"><%=p_phone%></div>
						</div>

						<div class="vb_item">
							<div class="vb_label">�������</div>
							<div class="vb_value"><%=p_birth%></div>
						</div>

						<div class="vb_item">
							<div class="vb_label">E-mail</div>
							<div class="vb_value"><%=p_email%></div>
						</div>

						<div class="vb_item">
							<div class="vb_label">�ּ�</div>
							<div class="vb_value"><%=p_address%></div>
						</div>
					</div>

					<% If arrResume(32, 0) <> "" Then %>
					<div class="vb_txt">
						<p><%=Replace(arrResume(32, 0), Chr(13), "<br>")%></p>
					</div>
					<% End If %>
				</div>


				<% If isArray(arrSchool) Then %>
				<div id="view2" class="view_box">
					<h3>�з»���</h3>
					<%
					For i=0 To UBound(arrSchool, 2)
					Dim univ_etype_nm
					Select Case arrSchool(12, i)
						Case "3" : univ_etype_nm = "����"
						Case "4" : univ_etype_nm = "����"
						Case "5" : univ_etype_nm = "����"
						Case "7" : univ_etype_nm = "����(��)"
						Case "8" : univ_etype_nm = "����"
					End Select

					Dim univ_year : univ_year = ""
					Select Case arrSchool(2,i)
						Case "4" : univ_year = "2,3����"
						Case "5" : univ_year = "4����"
					End Select

					cal_sdate = ""
					cal_edate = ""
					If isDate(arrSchool(7, i) & "-" & arrSchool(8, i)) Then cal_sdate = arrSchool(7, i) & "." & arrSchool(8, i)
					If isDate(arrSchool(10, i) & "-" & arrSchool(11, i)) Then cal_edate = arrSchool(10, i) & "." & arrSchool(11, i)
					%>
					<div class="vb_section">
						<div class="vb_row">
							<div class="name"><%=arrSchool(3, i)%></div>
							<div class="term">
								(
								<span><%=cal_sdate%></span>~<span><%=cal_edate%></span>
								<% If univ_year <> "" Then %>
								/ <%=univ_year%>
								<% End If %>
								)
							</div>
							<div class="line">
								<span><%=arrSchool(6, i)%></span>
								<span><%=univ_etype_nm%></span>
								<% If arrSchool(13, i) <> "" then %>
								<span>(<%=arrSchool(13, i)%>)</span>
								<% End If %>
								<% If arrSchool(17, i) <> "" Then %>
								/ <span><%=arrSchool(17, i)%>����</span>
								<span><%=arrSchool(18, i)%></span>
								<% End If %>
							</div>
						</div>

						<div class="vb_row">
							<p><%=arrSchool(24, i)%></p>
						</div>
					</div>
					<% Next %>
				</div><!-- �з»��� -->
				<% End If %>


				<% If isArray(arrCareer) Then %>
				<div id="view3" class="view_box">
					<h3>��»���</h3>
					<%
					For i=0 To UBound(arrCareer, 2)
					Dim experience_nowstatus_hdn_nm

					cal_sdate = ""
					cal_edate = ""
					cal_datediff = ""

					If arrCareer(5, i) = "2" Then
						If isDate(arrCareer(6, i) & "-" & arrCareer(7, i)) Then cal_sdate = arrCareer(6, i) & "." & arrCareer(7, i)
						cal_datediff = getDateDiff(cal_sdate, Left(Date(), 7))
						cal_datediff_month = cal_datediff_month + getDateDiffMonth(cal_sdate, Left(Date(), 7))
						cal_edate = "������"
					Else
						If isDate(arrCareer(6, i) & "-" & arrCareer(7, i)) Then cal_sdate = arrCareer(6, i) & "." & arrCareer(7, i)
						If isDate(arrCareer(8, i) & "-" & arrCareer(9, i)) Then cal_edate = arrCareer(8, i) & "." & arrCareer(9, i)
						cal_datediff = getDateDiff(cal_sdate, cal_edate)
						cal_datediff_month = cal_datediff_month + getDateDiffMonth(cal_sdate, cal_edate)
					End If
					%>
					<div class="vb_section">
						<div class="vb_row">
							<% If arrCareer(20, i) = "0" Then %>
							<div class="name">ȸ��� �����</div>
							<% Else %>
							<div class="name"><%=arrCareer(1, i)%></div>
							<% End If %>
							<div class="term">
							( <span><%=cal_sdate%></span> ~ <span><%=cal_edate%></span>
							<% If cal_datediff <> "" Then %>
							 / <%=cal_datediff%>
							<% End If %>
							)
							</div>
						</div>
						<div class="vb_detail">
							<div class="position"><%=arrCareer(3, i)%></div>
							<% If arrCareer(26, i) <> "" Then %>
							<p><%=Replace(arrCareer(26, i), Chr(13), "<br>")%></p>
							<% End If %>
						</div>
					</div>
					<% Next %>
					<div><%'cal_datediff_month%></div>
				</div><!-- ��»��� -->
				<% End If %>


				<% If isArray(arrActivity) Then %>
				<div id="view4" class="view_box">
					<h3>����,���Ȱ��</h3>
					<%
					For i=0 To UBound(arrActivity, 2)
					Dim rac_type_nm
					Select Case arrActivity(1, i)
						Case "1" : rac_type_nm = "����"
						Case "2" : rac_type_nm = "�Ƹ�����Ʈ"
						Case "3" : rac_type_nm = "����Ȱ��"
						Case "4" : rac_type_nm = "���Ƹ�"
						Case "5" : rac_type_nm = "�ڿ�����"
					End Select

					cal_sdate = ""
					cal_edate = ""
					cal_datediff = ""
					if isDate(arrActivity(3, i) & "-" & arrActivity(4, i)) Then cal_sdate = arrActivity(3, i) & "." & arrActivity(4, i)
					If isDate(arrActivity(5, i) & "-" & arrActivity(6, i)) Then cal_edate = arrActivity(5, i) & "." & arrActivity(6, i)
					cal_datediff = getDateDiff(cal_sdate, cal_edate)
					%>
					<div class="vb_section">
						<div class="vb_row">
							<div class="name"><%=arrActivity(7, i)%></div>
							<div class="term">
							( <span><%=cal_sdate%></span> ~ <span><%=cal_edate%></span>
							<% If cal_datediff <> "" Then %>
							 / <%=cal_datediff%>
							<% End If %>
							)</div>
						</div>
						<div class="vb_detail">
							<div class="position v2"><%=rac_type_nm%></div>
							<% If arrActivity(9, i) <> "" Then %>
							<p><%=Replace(arrActivity(9, i), Chr(13), "<br>")%></p>
							<% End If %>
						</div>
					</div>
					<% Next %>
				</div><!-- ����,���Ȱ�� -->
				<% End If %>


				<% If isArray(arrLanguageUse) Or isArray(arrLanguageExam) Then %>
				<div id="view5" class="view_box">
					<h3>�ܱ���</h3>
					<div class="vb_section">
						<div class="vb_row">
							<div class="language">
								<% If IsArray(arrLanguageUse) Then %>
								<dl>
									<dt>ȸȭ�ɷ�</dt>
									<dd>
										<table>
											<tbody>
												<%
												For i=0 To UBound(arrLanguageUse, 2)
												Dim language_talk_nm
												Select Case arrLanguageUse(2, i)
													Case "1" : language_talk_nm = "��"
													Case "2" : language_talk_nm = "��"
													Case "3" : language_talk_nm = "��"
												End Select
												%>
												<tr>
													<td><%=getLanguageCode(arrLanguageUse(1, i))%></td>
													<td><%=language_talk_nm%></td>
												</tr>
												<% Next %>
											</tbody>
										</table>
									</dd>
								</dl>
								<% End If %>

								<% If IsArray(arrLanguageExam) Then %>
								<dl>
									<dt>���ν���</dt>
									<dd>
										<table>
											<tbody>
												<%
												For i=0 To UBound(arrLanguageExam, 2)
												cal_sdate = ""
												If isDate(arrLanguageExam(4, i) & "-" & arrLanguageExam(5, i)) Then cal_sdate = arrLanguageExam(4, i) & "." & arrLanguageExam(5, i)
												%>
												<tr>
													<td><%=getLanguageCode(arrLanguageExam(1, i))%></td>
													<td><%=getLanguageExamCodeNm(arrLanguageExam(2, i))%></td>
													<td><%=arrLanguageExam(3, i)%></td>
													<td><%=cal_sdate%></td>
												</tr>
												<% Next %>
											</tbody>
										</table>
									</dd>
								</dl>
								<% End If %>
							</div>
						</div>
					</div>
				</div><!-- �ܱ��� -->
				<% End If %>


				<% If isArray(arrLicense) Then %>
				<div id="view6" class="view_box">
					<h3>�ڰ���</h3>
					<%
					For i=0 To UBound(arrLicense, 2)
					cal_sdate = ""
					If isDate(arrLicense(3, i) & "-" & arrLicense(4, i)) Then  cal_sdate = arrLicense(3, i) & "." & arrLicense(4, i)
					%>
					<div class="vb_section">
						<div class="vb_row">
							<div class="name"><%=arrLicense(1, i)%></div>
							<div class="data">
								( <span><%=cal_sdate%></span> / <span><%=arrLicense(2, i)%></span> )
							</div>
						</div>
					</div>
					<% Next %>
				</div><!-- �ڰ��� -->
				<% End If %>


				<% If isArray(arrPrize) Then %>
				<div id="view7" class="view_box">
					<h3>����</h3>
					<%
					For i=0 To UBound(arrPrize, 2)
					cal_sdate = ""
					If isDate(arrPrize(3, i) & "-" & arrPrize(4, i)) Then cal_sdate = arrPrize(3, i) & "." & arrPrize(4, i)
					%>
					<div class="vb_section">
						<div class="vb_row">
							<div class="name"><%=arrPrize(2, i)%></div>
							<div class="data">
								( <span><%=cal_sdate%></span> / <span><%=arrPrize(1, i)%></span> )
							</div>
						</div>
					</div>
					<% Next %>
				</div><!-- ���� -->
				<% End If %>


				<% If isArray(arrAcademy) Then %>
				<div id="view8" class="view_box">
					<h3>����</h3>
					<%
					For i=0 To UBound(arrAcademy, 2)
					cal_sdate = ""
					cal_edate = ""
					cal_datediff = ""
					If isDate(arrAcademy(2, i) & "-" & arrAcademy(3, i)) Then cal_sdate = arrAcademy(2, i) & "." & arrAcademy(3, i)
					If isDate(arrAcademy(4, i) & "-" & arrAcademy(5, i)) Then cal_edate = arrAcademy(4, i) & "." & arrAcademy(5, i)
					cal_datediff = getDateDiff(cal_sdate, cal_edate)
					%>
					<div class="vb_section">
						<div class="vb_row">
							<div class="name"><%=arrAcademy(6, i)%></div>
							<div class="data">
								( <span><%=cal_sdate%></span> ~ <span><%=cal_edate%></span>
								<% If cal_datediff <> "" Then %>
								 / <%=cal_datediff%>
								<% End If %>
								/ <span><%=arrAcademy(1, i)%></span> )
							</div>
						</div>
					</div>
					<% Next %>
				</div><!-- ���� -->
				<% End If %>


				<% If isArray(arrAbroad) Then %>
				<div id="view9" class="view_box">
					<h3>�ؿܰ���</h3>
					<%
					For i=0 To UBound(arrAbroad, 2)
					cal_sdate = ""
					cal_edate = ""
					cal_datediff = ""
					If isDate(arrAbroad(3, i) & "-" & arrAbroad(4, i)) Then cal_sdate = arrAbroad(3, i) & "." & arrAbroad(4, i)
					If isDate(arrAbroad(5, i) & "-" & arrAbroad(6, i)) Then cal_edate = arrAbroad(5, i) & "." & arrAbroad(6, i)
					cal_datediff = getDateDiff(cal_sdate, cal_edate)
					%>
					<div class="vb_section">
						<div class="vb_row">
							<div class="name"><%=getNationCode(arrAbroad(1, i))%></div>
							<div class="term">
							( <span><%=cal_sdate%></span> ~ <span><%=cal_edate%></span>
							<% If cal_datediff <> "" Then %>
							 / <%=cal_datediff%>
							<% End If %>
							)
							</div>

							<% If arrAbroad(7, i) <> "" Then %>
							<div class="txt"><%=Replace(arrAbroad(7, i), Chr(13), "<br>")%></div>
							<% End If %>
						</div>
					</div>
					<% Next %>
				</div><!-- �ؿܰ��� -->
				<% End If %>


				<%
				If isArray(arrPersonal) Or isArray(arrEmpSupport) Or isArray(arrMilitary) Then

				Dim patriot_flag, protect_flag, handicap_flag, handicap_grd, handicap_grd_nm, emp_support_flag
				Dim military_yn, military_nm, kind_class_nm, military_kind, military_class
				Dim military_sdate, military_syear, military_smonth, military_edate, military_eyear, military_emonth, military_reason

				handicap_grd_nm = "��ֵ��"
				If isArray(arrPersonal) Then
					patriot_flag = arrPersonal(0, 0)	'����
					protect_flag = arrPersonal(5, 0)	'�����ȣ���
					handicap_flag = arrPersonal(1, 0)	'���
					handicap_grd = arrPersonal(2, 0)	'��ֵ��
					Select Case handicap_grd
						Case "1" : handicap_grd_nm = "1��"
						Case "2" : handicap_grd_nm = "2��"
						Case "3" : handicap_grd_nm = "3��"
						Case "4" : handicap_grd_nm = "4��"
						Case "5" : handicap_grd_nm = "5��"
						Case "6" : handicap_grd_nm = "6��"
						Case Else : handicap_grd_nm = "��ֵ��"
					End Select
				End If

				If isArray(arrEmpSupport) Then
					emp_support_flag = arrEmpSupport(0, 0) '���������
				End If

				military_nm = "��������"
				kind_class_nm = "����/������"
				If isArray(arrMilitary) Then
					military_yn		= arrMilitary(0, 0)
					military_syear	= arrMilitary(3, 0)
					military_smonth	= arrMilitary(4, 0)
					military_eyear	= arrMilitary(5, 0)
					military_emonth	= arrMilitary(6, 0)
					military_kind	= arrMilitary(1, 0)
					military_class	= arrMilitary(2, 0)
					military_reason	= arrMilitary(10, 0)

					cal_sdate = ""
					cal_edate = ""
					cal_datediff = ""
					If isDate(military_syear & "-" & military_smonth) Then cal_sdate = military_syear & "." & military_smonth
					If isDate(military_eyear & "-" & military_emonth) Then cal_edate = military_eyear & "." & military_emonth
					cal_datediff = getDateDiff(cal_sdate, cal_edate)

					Select Case military_yn
						Case 1 kind_class_nm = "����"
						Case 2 kind_class_nm = "����"
						Case 3 kind_class_nm = "����"
						Case 4 kind_class_nm = "������"
						Case 5 kind_class_nm = "�ش����"
					End Select

					If military_yn = "1" Or military_yn = "4" Then
						kind_class_nm = getMilitaryKind(military_kind) & " / " & getMilitaryClass(military_class)
					End If
				End If

				%>
				<div id="view10" class="view_box">
					<h3>������.����</h3>
					<% If patriot_flag = "1" Then %>
					<div class="vb_section">
						<div class="vb_row">
							<div class="name">���� ���</div>
						</div>
					</div>
					<% End If %>

					<% If protect_flag = "1" Then %>
					<div class="vb_section">
						<div class="vb_row">
							<div class="name">�����ȣ ���</div>
						</div>
					</div>
					<% End If %>

					<% If emp_support_flag = "1" Then %>
					<div class="vb_section">
						<div class="vb_row">
							<div class="name">��������� ���</div>
						</div>
					</div>
					<% End If %>

					<% If handicap_flag = "1" Then %>
					<div class="vb_section">
						<div class="vb_row">
							<div class="name">���</div>
							<div class="term">(<span><%=handicap_grd_nm%></span>)</div>
						</div>
					</div>
					<% End If %>

					<% If military_yn <> "" Then %>
					<div class="vb_section">
						<div class="vb_row">
							<div class="name"><span><%=kind_class_nm%></span></div>
							<% If military_reason <> "" Then %>
							<div class="term"><%=military_reason%></div>
							<% Else %>
							<div class="term">( <span><%=cal_sdate%></span> ~ <span><%=cal_edate%></span>
							<% If cal_datediff <> "" Then %>
							 / <%=cal_datediff%>
							<% End If %>
							)</div>
							<% End If %>
						</div>
					</div>
					<% End If %>
				</div><!-- ������.���� -->
				<% End If %>


				<% If isArray(arrPortfolio) Then %>
				<div id="view11" class="view_box">
					<h3>��Ʈ������</h3>
					<div class="vb_section">
						<div class="vb_link">
							<ul>
								<%
								For i=0 To UBound(arrPortfolio, 2)
									If arrPortfolio(1, i) = "1" Then
								%>
								<li><span>��ũ</span><a href="http://<%=arrPortfolio(2, i)%>" target="_blank"><%=arrPortfolio(2, i)%></a></li>
								<%
									End If
								Next
								%>
							</ul>
						</div>
						<div class="vb_link">
							<ul>
								<%
								For i=0 To UBound(arrPortfolio, 2)
									If arrPortfolio(1, i) = "2" Then
								%>
								<li><span>����</span><a href="http://www2.career.co.kr/myjob/resume/file_download.asp?fileid1=<%=arrPortfolio(3, i)%>&fileid2=<%=arrPortfolio(4, i)%>"><%=arrPortfolio(3, i)%></a></li>
								<!-- <li><span>����</span><a href="<%=g_partner_wk%>/my/resume/file_download.asp?fileid1=<%=arrPortfolio(3, i)%>&fileid2=<%=arrPortfolio(4, i)%>"><%=arrPortfolio(3, i)%></a></li> -->
								<!-- <li><span>����</span><a href="/files/resume/<%=arrPortfolio(4, i)%>" target="_blank"><%=arrPortfolio(3, i)%></a></li> -->
								<%
									End If
								Next
								%>
							</ul>
						</div>
					</div>
				</div><!-- ��Ʈ������ -->
				<% End If %>


				<% If isArray(arrNew_Essay) Then %>
				<div id="view12" class="view_box">
					<h3>�ڱ�Ұ���</h3>
					<% For i=0 To UBound(arrNew_Essay, 2) %>
					<div class="vb_section">
						<div class="vb_row">
							<div class="name"><%=arrNew_Essay(4, i)%></div>
						</div>
						<div class="vb_me">
							<% If arrNew_Essay(5, i) <> "" Then %>
							<p><%=Replace(arrNew_Essay(5, i), Chr(13), "<br>")%></p>
							<% End If %>
						</div>
					</div>
					<% Next %>
				</div><!-- �ڱ�Ұ��� -->
				<% End If %>


				<%
				'arrWorkType	= arrData(0)(18)'����ٹ�����
				'arrArea		= arrData(0)(19)'�������
				'arrCtKwd		= arrData(0)(20)'�������
				'arrJcKwd		= arrData(0)(21)'�������

				Dim work_style, work_style_nm, salary_amt, salary_amt_nm
				If isArray(arrWorkType) Then work_style = arrWorkType(0, 0)
				If isArray(arrResume) Then salary_amt = arrResume(10, 0)

				work_style_nm = "�������"
				If work_style <> "" Then work_style_nm = getComWorkType(work_style)

				salary_amt_nm = "�������"
				If salary_amt <> "" And salary_amt <> "98" Then salary_amt_nm = getSalayYear(salary_amt)
				If salary_amt = "98" Then salary_amt_nm = "���� �� ����"

				'��/���� �ڵ�2�� ��ü
				Dim jc_code_all, ct_code_all
				If isArray(arrResume) Then
					jc_code_all = arrResume(28, 0)
					ct_code_all = arrResume(29, 0)
					If jc_code_all <> "" Then jc_code_all = Split(jc_code_all, "|")
					If ct_code_all <> "" Then ct_code_all = Split(ct_code_all, "|")
				End If

				If isArray(arrWorkType) Or isArray(arrArea) Or isArray(arrCtKwd) Or isArray(arrJcKwd) Or salary_amt <> "" Then
				%>
				<div id="view13" class="view_box">
					<h3>��� �ٹ�����</h3>
					<div class="vb_tb">
						<table>
							<colgroup>
								<col style="width:140px;">
								<col>
							</colgroup>
							<tbody>
								<% If isArray(arrWorkType) Then %>
								<tr>
									<th>�������</th>
									<td colspan="2"><%=work_style_nm%></td>
								</tr>
								<% End If %>

								<% If IsArray(arrArea) Then %>
								<tr>
									<th>����ٹ���</th>
									<td colspan="2">
										<div class="category_area area">
											<div class="category">
												<div class="c_jobs">
												<%
													For i=0 To UBound(arrArea, 2)
														Dim workArea_temp, workArea_temp2
														workArea_temp2 = ""

														If InStr(workArea_temp,getAcName(arrArea(0,i))) = 0 Then
															workArea_temp	= getAcName(arrArea(0,i))

															Response.write workArea_temp & " > "

															For ii=0 To UBound(arrArea, 2)
																If arrArea(0,i) = arrArea(0,ii) Then
																	If workArea_temp2 = "" Then
																		workArea_temp2 = getAcName(arrArea(1,ii))
																	Else
																		workArea_temp2	= workArea_temp2 & ", " & getAcName(arrArea(1,ii))
																	End If
																End If
															Next

															Response.write workArea_temp2 & "<br>"
														End If
													Next
												%>
												</div>
											</div>
										</div>
									</td>
								</tr>
								<% End If %>

								<% If salary_amt <> "" Then %>
								<tr>
									<th>�������</th>
									<td colspan="2"><%=salary_amt_nm%></td>
								</tr>
								<% End If %>

								<% If isArray(jc_code_all) Or isArray(ct_code_all) Then %>
								<tr>
									<th rowspan="2">�����о�</th>
									<td colspan="2">
										<% If isArray(jc_code_all) Then	%>
										<div class="category_area jobs">
											<% For i=0 To UBound(jc_code_all) %>
											<div class="category">
												<% If i = 0 Then %>
												<div class="c_head">����</div>
												<% End If %>
												<div class="c_recommend"><%=getJobtype(jc_code_all(i))%></div>
												<div class="c_jobs">
												<%
												If isArray(arrJcKwd) Then
													For ii=0 To UBound(arrJcKwd, 2)
													If jc_code_all(i) = Left(arrJcKwd(0, ii), 4) Then
												%>
												<%=arrJcKwd(1, ii)%>
												<%
													End If
													Next
												End If
												%>
												</div>
											</div>
											<% Next %>
										</div>
										<% End If %>

										<% If isArray(ct_code_all) Then	%>
										<div class="category_area">
											<% For i=0 To UBound(ct_code_all) %>
											<div class="category">
												<% If i = 0 Then %>
												<div class="c_head">���</div>
												<% End If %>
												<div class="c_recommend"><%=getJobtype(ct_code_all(i))%></div>
												<div class="c_jobs">
												<%
												If isArray(arrCtKwd) Then
													For ii=0 To UBound(arrCtKwd, 2)
													If ct_code_all(i) = Left(arrCtKwd(0, ii), 4) Then
												%>
												<%=arrCtKwd(1, ii)%>
												<%
													End If
													Next
												End If
												%>
												</div>
											</div>
											<% Next %>
										</div>
										<% End If %>
									</td>
								</tr>
								<% End If %>
							</tbody>
						</table>
					</div>
				</div><!-- ��� �ٹ����� -->
				<% End If %>


				<%
				Dim resume_mod_date, str_resume_mod_date
				resume_mod_date = Split(Left(arrResume(19, 0), 10), "-")
				str_resume_mod_date = resume_mod_date(0) & "�� " & resume_mod_date(1) & "�� " & resume_mod_date(2) & "��"
				%>
				<div class="chk_txt">
					<p>���� ��� ��������� ��ǰ� �ٸ������� Ȯ���մϴ�.<br>
					�ۼ��� : <span><%=p_userName%></span></p>

					<em>
					�� �̷¼��� <%=str_resume_mod_date%>�� ���� ������Ʈ�� �̷¼� �Դϴ�.<br>
					������ ������ ����Ͽ� ���Ȱ���� �̿� �� ���� å���� ���� �� �� �ֽ��ϴ�.<br>
					<%=site_name%> ���񽺴� �����ڰ� ����� ������ ���� �����ϰų� ������ å���� ���� ������<br>
					÷�ε� ������ �ŷ��Ͽ� �߻��� ���� ���￡ å���� ���� �ʽ��ϴ�.<br>
					���� ����/���� ���� �� �ٸ� �������� �̿� �� �̷¼� ���� Ȥ�� ����� ��ġ�� �� �� �ֽ��ϴ�.
					</em>
				</div>

			</div>
		</div><!-- resume_area -->

	</div>
</div>
<!-- //container -->
