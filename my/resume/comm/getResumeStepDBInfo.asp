<%
'============================================================
'	�̷¼� ��� �ܰ躰(Step) DB ���� ��ȸ.
'
'	#�����ۼ���	: 2009-11-30
'	#�ۼ���		    : �ӱ���(gidol@career.co.kr)
'------------------------------------------------------------
'   #���������� �ʼ���Ŭ��� ����
'       /wwwconf/function/db/DBConnection.asp
'       /wwwconf/function/user/ResumeInfo.asp
'   #���� ������
'       /my(myjob)/resume/resume_step1~4.asp
'       /my(myjob)/resume/resume_reg_step1~4.asp
'   #���� ����
'       stp : �̷¼� �ܰ�
'       rid : �̷¼� ��Ϲ�ȣ
'============================================================

'g_debug = true
'----------------------------------------
'   constant
'----------------------------------------
Dim svrNm	: svrNm		= Request.ServerVariables("SERVER_NAME")
Dim svrURL	: svrURL	= Request.ServerVariables("URL")
Dim mydir	: mydir		= "/my/resume_list.asp"

Dim baseChk	: baseChk	= False 
Dim rGubun	: rGubun	= request.QueryString("rGubun")

'----------------------------------------
'   chk. �̷¼� �ܰ� ���� üũ
'----------------------------------------
'-- �̷¼���ȣ ��ȿ���˻�
If Len(rid) = 0 Or IsEmpty(rid) Or Not IsNumeric(rid) Or rid = "0" Then
    rid = 0
End If

'If rid = 0 And stp = 5 Then
'    '-- 5�ܰ�(����) �̷¼� ��ȣ ����
'    ShowAlertMsg "������ �̷¼��� ���õ��� �ʾҽ��ϴ�.", "location.replace('"& mydir &"');", True
'End If

'----------------------------------------
'   �̷¼� ���� ��ȸ
'----------------------------------------
Dim arrData
Dim iResumeCnt		: iResumeCnt	= 0
Dim iResumeCntGnb	: iResumeCntGnb = 0

	ConnectDB DBCon, Application("DBInfo_FAIR")

	'response.Write "user_id : " & user_id & "<Br>"
	'response.Write "stp : " & stp & "<Br>"
	'response.Write "rid : " & rid & "<Br>"

	If set_user_id <> "" Then
		user_id = set_user_id
	End If
	
	'If apply_resume = "Y" Then arrData = getApplyResumeStepDataNew(DBCon, Array(user_id, stp, rid), "", "") Else arrData = getResumeStepDataNew(DBCon, Array(user_id, stp, rid), "", "")
	arrData = getResumeStepDataNew(DBCon, Array(user_id, stp, rid), "", "")
	if not isArray(arrData) Then
		response.Write "<script>"
		response.Write "	alert('�̷¼� ������ ��Ȯ���� �ʽ��ϴ�. �ٽ� Ȯ���Ͻð� �õ��� �ֽñ� �ٶ��ϴ�.');"
		response.Write "	window.close();"
		response.Write "</script>"
		Response.End
	end if

    ' response.Write "arrData(1) : " & arrData(1) & "<Br>"
	
	if arrData(1) = "5" then	rtype = "C"

	'-- �̷¼� �űԵ�� �� : �̷¼� �� ��ϰ���
	If stp = 1 And rid = 0 Then iResumeCnt = getResumeRegCnt(DBCon, user_id)

	'-- �̷¼� �űԵ�� �� : ������ �ۼ����� �̷¼���ȣ
	if (stp=2 or stp=3) and stp=arrData(1) and rtype="T" then
		baseChk = true
		dim base_chk_id : base_chk_id = getBaseRidByUserID(DBCon, user_id)
		if base_chk_id = rid or base_chk_id = "" then
			baseChk = false
		else
			if base_chk_id <> "" then
				arrData = getResumeStepData(DBCon, Array(user_id, stp, base_chk_id), "", "")
				if not isArray(arrData) then	baseChk = false
			end if
		end if
	end If
	
	iResumeCntGnb = getResumeRegCntGnb(DBCon, user_id)(2,0)

DisconnectDB DBCon

'response.Write "iResumeCnt : " & iResumeCnt & "<Br>"
'response.Write "iResumeCntGnb : " & iResumeCntGnb & "<Br>"

if not isArray(arrData(0)) then
	response.Write "<script>"
	response.Write "	alert('�̷¼� ������ ��Ȯ���� �ʽ��ϴ�. �ٽ� Ȯ���Ͻð� �õ��� �ֽñ� �ٶ��ϴ�.');"
	response.Write "	window.close();"
	response.Write "</script>"
	Response.End
end if

'----------------------------------------
'   �ܰ躰 ���� ����
'----------------------------------------
Dim arrIngResume
Dim arrBase, arrUser, arrComm, arrResume
Dim arrSchool, arrCareer, arrActivity
Dim arrLanguageUse, arrLanguageExam, arrLicense, arrPrize, arrAcademy, arrAbroad
Dim arrPersonal, arrMilitary, arrEmpSupport
Dim arrPortfolio
Dim arrWorkType, arrArea, arrCtKwd, arrJcKwd
Dim arrNew_Essay

arrIngResume	= arrData(0)(0)	'�ۼ����� �̷¼���ȣ(�߰�����)
arrBase			= arrData(0)(1)	'�⺻�̷¼�
arrUser			= arrData(0)(2)	'����ȸ������(�̷¼���)
arrComm			= arrData(0)(3)	'�̷¼� ��������
arrResume		= arrData(0)(4)	'�̷¼�1,2

arrSchool		= arrData(0)(5)	'�̷¼��з�
arrCareer		= arrData(0)(6)	'�̷¼����
arrActivity		= arrData(0)(7)	'�ֿ�Ȱ������(����,���Ȱ��)

arrLanguageUse	= arrData(0)(8)	'�ܱ��� ȸȭ�ɷ�
arrLanguageExam	= arrData(0)(9)	'�ܱ��� ���ν���
arrLicense		= arrData(0)(10)'�ڰ���
arrPrize		= arrData(0)(11)'����
arrAcademy		= arrData(0)(12)'����
arrAbroad		= arrData(0)(13)'�ؿܿ���

arrPersonal		= arrData(0)(14)'����/���
arrMilitary		= arrData(0)(15)'����
arrEmpSupport	= arrData(0)(16)'��������ݴ��

arrPortfolio	= arrData(0)(17)'��Ʈ������

arrWorkType		= arrData(0)(18)'����ٹ�����
arrArea			= arrData(0)(19)'�������
arrCtKwd		= arrData(0)(20)'�������
arrJcKwd		= arrData(0)(21)'�������

arrNew_Essay	= arrData(0)(22)'�ڱ�Ұ���


%>
