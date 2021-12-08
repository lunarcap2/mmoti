<%
If resumeIsComplete = "1" Or resumeIsComplete = "2" Or resumeIsComplete = "4" Or resumeIsComplete = "6" Then
	ConnectDB DBCon, Application("DBInfo_FAIR")

		'--��������
		Call execResumeCommon_M(DBCon, arrParams1_1(), "", "")

		'--�̷¼�1,2
		rid = execResumeResumeNew_M(DBCon, arrParams10(), "", "")

		If rtype = "T" Then
			save_resume_id = rid
		End If

		'--���� �ڱ�Ұ�
		Call execResumeSelfIntro_M(DBCon, Array(rid,user_id,stp,self_intro), "", "")
		
		If rsubGubun = "13" Then
			'--����/���
			Call execResumePariotHandicap(DBCon, arrParams1_4(), "", "")

			'--��������� ���
			ret_val = regReNewalResume_EmploymentSupport(DBCon, arrParams1_EmpSupport(), "", "")

			'--����
			Call execResumeMilitary(DBCon, arrParams1_3(), "", "")
		End If
		
		If rsubGubun = "2" Then
			'--�з�
			'Call execResumeSchool(DBCon, arrParamsSchool(1,0,1,1), "", "")
			seq=1
			For ii=1 To Request.Form("univ_name").count
				If Request.Form("univ_name")(ii) <> "" Then
					If resumeIsComplete = "6" Then
						Call execResumeItemUpdate_school_M(DBCon, arrParamsSchool(2, rsub_seq_no, ii, Request.Form("univ_kind")(ii)),"", "")
					Else
						Call execResumeSchool(DBCon, arrParamsSchool(2, seq, ii, Request.Form("univ_kind")(ii)),"", "")
					End If
					
					seq = seq+1
				End If
			Next
		End If
		
		If rsubGubun = "3" Then
			'--���
			'Call execResumeCareer(DBCon, arrParams2_career(0, 0), "", "") '��ü����  error
			seq=1
			For ii=1 To Request.Form("experience_corp_name").count
				If Request.Form("experience_corp_name")(ii) <> "" Then
					If resumeIsComplete = "6" Then
						Call execResumeItemUpdate_career_M(DBCon, arrParams2_career(rsub_seq_no,ii), "", "")
					Else
						Call execResumeCareer(DBCon, arrParams2_career(seq,ii), "", "")
					End If

					seq = seq+1
				End If
			Next
		End If
		
		If rsubGubun = "6" Then
			'--�ֿ�Ȱ������
			'Call delReNewalResume_ActivityAll(DBCon, rid, rtype, "", "")
			for ii=1 to request.form("rac_type").count
				if request.form("rac_type")(ii) <> "" Then
					ret_val = regReNewalResume_Activity(DBCon, arrParams2_Activity(ii), "", "")	' �ֿ�Ȱ������ ���(�̷¼�����201103)				
					if request.form("temp_save_flag") = "Y" and ret_val > 0 then
					end if
				end if
			Next
		End If
		
		If rsubGubun = "5" Then
			'--����ٹ���
			Call execResumeWorkArea(DBCon, arrParams1_7(), "", "")

			'--����ٹ�����
			Call execResumeWorkStyle(DBCon, arrParams1_8(), "", "")
			
			'--�������/Ű����
			Call execResumeJcCodeKeyword(DBCon, arrParamsHopeJc(), "", "")

			'--�������/Ű����
			Call execResumeCtCodeKeyword(DBCon, arrParamsHopeCt(), "", "")
			
			'--�������,���� �̷¼� ���̺� �ݿ� (����Ʈ,�� ����)
			jc_code_all = Replace(Request.Form("resume_jobcode"),", ","|")
			ct_code_all = Replace(Request.Form("resume_jobtype"),", ","|")

			redim parameters(4)
			parameters(0) = makeParam("@userid", adVarchar, adParamInput, 20, user_id)
			parameters(1) = makeParam("@rid", adInteger, adParamInput, 4, rid)
			parameters(2) = makeParam("@jc_code_all", adVarchar, adParamInput, 64, jc_code_all)
			parameters(3) = makeParam("@ct_code_all", adVarchar, adParamInput, 64, ct_code_all)
			parameters(4) = makeParam("@execRid", adInteger, adParamOutput, 4, 0)

			Call execSP(DBCon, "usp_resume_ctjc_update", parameters, "", "")
			execRid = getParamOutputValue(parameters, "@execRid")
		End If
		
		If rsubGubun = "8" Then
			'--�ڰ���
			'Call execResumeLicense(DBCon, arrParams3_2(0, 0), "", "")
			seq=1
			For ii=1 To Request.Form("license_name").count
				If Request.Form("license_name")(ii) <> "" Then
					If resumeIsComplete = "6" Then
						Call execResumeItemUpdate_license_M(DBCon, arrParams3_2(rsub_seq_no,ii), "", "")
					Else
						Call execResumeLicense(DBCon, arrParams3_2(seq,ii), "", "")
					End If

					seq = seq+1
				End If
			Next
		End If
		
		If rsubGubun = "7" Then
			If resumeIsComplete = "6" Then
				If rsubItem <> Request.Form("language_type") Then
					'����
					Call execResumeItemDel_M(DBCon, Array(user_id,rid,rsubGubun,rsubItem,rsub_seq_no,rtype), "", "")

					'���
					'--���дɷ�(ȸȭ)
					'Call execResumeLanguageUse(DBCon, arrParams3_3(0, 0), "", "")
					seq=1
					For ii=1 To Request.Form("language_name").count
						If Request.Form("language_name")(ii) <> "" Then
							Call execResumeLanguageUse(DBCon, arrParams3_3(seq,ii), "", "")						
							seq = seq+1
						End If
					Next

					'--���н���(���ν���)
					'Call execResumeLanguageExam(DBCon, arrParams3_4_renew(0, 0), "", "")
					seq=1
					For ii=1 To Request.Form("language_exam_group").count
						If Request.Form("language_exam_group")(ii) <> "" Then
							Call execResumeLanguageExam(DBCon, arrParams3_4_renew(seq,ii), "", "")
							seq = seq+1
						End If
					Next
				Else
					'--���дɷ�(ȸȭ)
					For ii=1 To Request.Form("language_name").count
						If Request.Form("language_name")(ii) <> "" Then
							Call execResumeItemUpdate_language_use_M(DBCon, arrParams3_3(rsub_seq_no,ii), "", "")							
							seq = seq+1
						End If
					Next

					'--���н���(���ν���)
					For ii=1 To Request.Form("language_exam_group").count
						If Request.Form("language_exam_group")(ii) <> "" Then
							Call execResumeItemUpdate_language_exam_M(DBCon, arrParams3_4_renew(rsub_seq_no,ii), "", "")
						End If
					Next
				End If
			Else
				'--���дɷ�(ȸȭ)
				'Call execResumeLanguageUse(DBCon, arrParams3_3(0, 0), "", "")
				seq=1
				For ii=1 To Request.Form("language_name").count
					If Request.Form("language_name")(ii) <> "" Then
						Call execResumeLanguageUse(DBCon, arrParams3_3(seq,ii), "", "")						
						seq = seq+1
					End If
				Next

				'--���н���(���ν���)
				'Call execResumeLanguageExam(DBCon, arrParams3_4_renew(0, 0), "", "")
				seq=1
				For ii=1 To Request.Form("language_exam_group").count
					If Request.Form("language_exam_group")(ii) <> "" Then
						Call execResumeLanguageExam(DBCon, arrParams3_4_renew(seq,ii), "", "")
						seq = seq+1
					End If
				Next
			End If			
		End If
		
		If rsubGubun = "11" Then
			'--�ؿܿ���
			'Call execResumeAbroad(DBCon, arrParams3_5(0, 0), "", "")
			seq=1
			For ii=1 To Request.Form("abroad_nation_code").count
				If Request.Form("abroad_nation_code")(ii) <> "" Then
					If resumeIsComplete = "6" Then
						Call execResumeItemUpdate_overseas_M(DBCon, arrParams3_5(rsub_seq_no,ii), "", "")
					Else
						Call execResumeAbroad(DBCon, arrParams3_5(seq,ii), "", "")
					End If
					
					seq = seq+1
				End If
			Next
		End If
		
		If rsubGubun = "10" Then
			'--�����̼�
			'Call execResumeAcademy(DBCon, arrParams3_6(0, 0), "", "")
			seq=1
			For ii=1 To Request.Form("academy_org_name").count
				If Request.Form("academy_org_name")(ii) <> "" Then
					If resumeIsComplete = "6" Then
						Call execResumeItemUpdate_education_M(DBCon, arrParams3_6(rsub_seq_no,ii), "", "")
					Else
						Call execResumeAcademy(DBCon, arrParams3_6(seq,ii), "", "")
					End If
					
					seq = seq+1
				End If
			Next
		End If
		
		If rsubGubun = "9" Then
			'--���󳻿�
			'Call execResumePrize(DBCon, arrParams3_7(0, 0), "", "")
			seq=1
			For ii=1 To Request.Form("prize_org_name").count
				If Request.Form("prize_org_name")(ii) <> "" Then
					If resumeIsComplete = "6" Then
						Call execResumeItemUpdate_awards_M(DBCon, arrParams3_7(rsub_seq_no,ii), "", "")
					Else
						Call execResumePrize(DBCon, arrParams3_7(seq,ii), "", "")
					End If
					
					seq = seq+1
				End If
			Next
		End If
		
		If rsubGubun = "12" Then
			'--��Ʈ������
			'Call execResumePortfolio(DBCon, arrParams3_Portfolio_1(0, 0), "", "")
			seq=1
			For ii=1 To Request.Form("portfolio_type1").count
				If Request.Form("pf_url_addr")(ii) <> "" Then
					Call execResumePortfolio(DBCon, arrParams3_Portfolio_1(seq,ii), "", "")
					seq = seq+1
				End If
			Next
			For ii=1 To Request.Form("portfolio_type2").count
				If Request.Form("pf_upload_file")(ii) <> "" Then				
					Call execResumePortfolio(DBCon, arrParams3_Portfolio_2(seq,ii), "", "")
					seq = seq+1
				End If
			Next
		End If
		
		If rsubGubun = "4" Then
			'--�ڱ�Ұ���
			'Call regReNewalResume_Essay_Del(DBCon, rid, "", "")
			seq=1
			for ii=1 to Request.Form("res_seq").count
				if request.form("res_content")(ii) <> "" Then
					res_seq = regReNewalResume_Essay(DBCon, arrParams4_EssayReNew(seq, ii), "", "")
					seq = seq + 1
				end if
			Next
		End If

		If resumeIsComplete = "1" Then '�߰������� �ƴҰ�츸 �Ϸ�κ�
			if rtype = "T" then
				'--�̷¼� ��ϿϷ� (�̷¼� �̵� : �߰����� -> �Ϸ� �̷¼�)
				rid = execResumeRegCompleteNew(DBCon, Array(rid,user_id,stp), "", "")
				
				'--�̷¼� �Ǽ� +1 ��Ű����
				Call setCookie(site_code & "WKP_F", "CK_ResumeCnt", "career.co.kr", CK_ResumeCnt + 1)
			end If
		End If

		Call execResumeMonth(DBCon, Array(rid, "", ""), "", "") '�̷¼� ��¿��� update


		'�̷¼��������üũ
		If resumeIsComplete = "1" Or rtype = "C" Then
			complete_resume_id = rid
		End If

		ReDim parameter(3)
		parameter(0)    = makeParam("@gubun", adVarChar, adParamInput, 20, "Mobile")
		parameter(1)    = makeParam("@userid", adVarChar, adParamInput, 20, user_id)
		parameter(2)    = makeParam("@save_resume_id", adInteger, adParamInput, 4, save_resume_id)
		parameter(3)    = makeParam("@complete_resume_id", adInteger, adParamInput, 4, complete_resume_id)		

		Call execSP(DBCon, "usp_�̷¼�_���_LOG", parameter, "", "")

	DisconnectDB DBCon
End If
%>