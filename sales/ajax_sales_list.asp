<%
	Option Explicit

	Response.CacheControl = "no-cache"
	Response.AddHeader "Pragma", "no-cache"
	Response.Expires = -1
	Response.Charset = "euc-kr"
%>

<!--#include virtual = "/common/common.asp"-->
<!--#include virtual = "/inc/db/DBConnection.asp"-->

<%
Dim sRank, eRank
sRank	= Request("sRank")
eRank	= Request("eRank")

If sRank = "" Or eRank = "" Then
	Response.write "<script type='text/javascript'>"
	Response.write "alert('�ٽ� �õ��� �ֽñ� �ٶ��ϴ�.');"
	Response.write "</script>"
	Response.end
End If

ConnectDB DBCon, Application("DBInfo_FAIR")
	
	Dim i

	ReDim parameter(1)
	parameter(0) = makeParam("@Salary_sRank", adInteger, adParamInput, 4, sRank)
	parameter(1) = makeParam("@Salary_eRank", adInteger, adParamInput, 4, eRank)

	Dim arrRs : arrRs	= arrGetRsSP(DBCon, "usp_Salary_info_list", parameter, "", "")

	If isArray(arrRs) Then
		For i=0 To UBound(arrRs,2)
			Dim rs_no, rs_bizCode, rs_bizName, rs_etbDate, rs_empNum, rs_salesDate, rs_salesAmt
			rs_no			= arrRs(0,i)	'����
			rs_bizCode		= arrRs(2,i)	'����ڵ�Ϲ�ȣ
			rs_bizName		= arrRs(3,i)	'ȸ���
			rs_etbDate		= arrRs(9,i)	'������(YYYYMMDD)
			rs_empNum		= arrRs(10,i)	'��������
			rs_salesDate	= arrRs(4,i)	'����� ��������(YYYYMMDD)
			rs_salesAmt		= arrRs(5,i)	'�����
			
			
			Dim v_etbYY, v_empNum, v_salesAmt
			'�����⵵
			If rs_etbDate <> "" Then
				v_etbYY = Left(rs_etbDate,4) & "��"
			Else
				v_etbYY = "-"
			End If

			'��������
			If rs_empNum <> "" Then
				v_empNum = FormatNumber(rs_empNum,0) & "��"
			Else
				v_empNum = "-"
			End If

			'�����
			If rs_salesAmt <> "" Then
				v_salesAmt = getCompanyMoney_Text(CCur(rs_salesAmt) / 10) & " (" & Left(rs_salesDate,4) & "�� ����)"
			Else
				v_salesAmt = "-"
			End If

			Response.write "<a href=""./sales_view.asp?hdn_biz_code=" & rs_bizCode & """>"
			Response.write "	<dl>"
			Response.write "		<dt>" & rs_bizName & "</dt>"
			Response.write "		<dd>"
			Response.write "			<div class=""partners_info"">"
			Response.write "				<dl>"
			Response.write "					<dt>�����⵵</dt>"
			Response.write "					<dd>" & v_etbYY & "</dd>"
			Response.write "					<dt>��������</dt>"
			Response.write "					<dd>" & v_empNum & "</dd>"
			Response.write "				</dl>"
			Response.write "				<dl>"
			Response.write "					<dt>�����</dt>"
			Response.write "					<dd>" & v_salesAmt & "</dd>"
			Response.write "				</dl>"
			Response.write "				<dl>"
			Response.write "					<dt>�������</dt>"
			Response.write "					<dd>" & rs_no & "��</dd>"
			Response.write "				</dl>"
			Response.write "			</div>"
			Response.write "		</dd>"
			Response.write "	</dl>"
			Response.write "</a>"
		Next
	End If

DisconnectDB DBCon
%>