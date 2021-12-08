<!--#include virtual="/wwwconf/function/db/DBConnection.asp"-->
<!--#include virtual = "/common/common.asp"-->
<%
'--------------------------------------------------------------------
'   Comment		: ����ȸ�� ����
' 	History		: 2020-12-01, �̻��� 
'--------------------------------------------------------------------
Session.CodePage  = 949			'�ѱ�
Response.CharSet  = "euc-kr"	'�ѱ�
Response.AddHeader "Pragma","no-cache"
Response.AddHeader "cache-control", "no-staff"
Response.Expires  = -1

emp_no = Request("emp_no")


ConnectDB DBCon, Application("DBInfo_FAIR")

' �Է� ��� ��ȿ�� üũ > 1)���� ��� ���̺� �ش� ������ �����ϴ��� ���� Ȯ��
strSql = "SELECT ���ϻ��, ����, �޴���, ���ڿ���, �������, ����ü����, ���͸�, �����, ��ġ�μ� " &_
		  "FROM ���ϸ������ WITH(NOLOCK) "&_
		  "WHERE ���ϻ��='"& emp_no &"' "
Rs.Open strSql, DBCon, adOpenForwardOnly, adLockReadOnly, adCmdText
Dim flagRs : flagRs = False 
If Rs.eof = False And Rs.bof = False Then
	flagRs = True 
	rs_EmpNo		= Rs(0)	' ���ϻ��
	rs_ItrnNm		= Rs(1)	' ���ϼ���
	rs_ItrnPhone	= Rs(2)	' �޴���
	rs_ItrnMail		= Rs(3)	' �̸���
	rs_ItrnAgency	= Rs(4)	' �������
	rs_ItrnGover	= Rs(5)	' ����ü����
	rs_ItrnCenter	= Rs(6) ' ���͸�
	rs_ItrnGoverDtl	= Rs(7)	' �����
	rs_ItrnDepart	= Rs(8)	' ��ġ�μ�
End If

If flagRs = False Then 
	rtn_value = "X"	' ���� ��ܿ� ���Ե��� ���� ��� ���� �Ұ� ó��
Else 
	
	' �Է� ��� ��ȿ�� üũ > 2)�ش� ������� ���Ե� ����ȸ�� ������ �ִ��� üũ
	strSql2 = "SELECT ���ξ��̵� FROM ����ȸ������ WITH(NOLOCK) WHERE ���ξ��̵�= ? "
	ReDim parameter(0)
	parameter(0)	= makeParam("@���ξ��̵�", adVarChar, adParamInput, 20, emp_no&"_wk")
	ArrRsDefault	= arrGetRsParam(DBCon, strSql2, parameter, "", "")
	If isArray(ArrRsDefault) Then	
		rtn_value = "N"	' �ش� ������� ���Ե� ������ �����Ѵٸ� �ߺ� ���� ���� ó��
	Else 
		rtn_value = "O" 
	End If 

End If 


DisconnectDB DBCon


Response.write rtn_value&"��"

' ���� ��ܿ� ��� ������ ���� ��� ���� ���� ����
If rtn_value = "O" Then 
	Response.write rs_EmpNo&"��"&rs_ItrnMail&"��"&rs_ItrnPhone&"��"&rs_ItrnNm&"��"
	Response.write "<table class='tb'>"+VBCRLF
	Response.write "<colgroup><col style='width:18%;' /><col /></colgroup><tbody>"+VBCRLF
	Response.write "<tr><th>���͸�</th><td>"&rs_ItrnCenter&"</td></tr>"+VBCRLF
	Response.write "<tr><th>�����</th><td>"&rs_ItrnGoverDtl&"</td></tr>"+VBCRLF
	Response.write "<tr><th>���� ��ġ�μ�</th><td>"&rs_ItrnDepart&"</td></tr>"+VBCRLF
	Response.write "<tr><th>���� ���</th><td>"&rs_EmpNo&"</td></tr>"+VBCRLF
	Response.write "<tr><th>�̸�</th><td>"&rs_ItrnNm&"</td></tr>"+VBCRLF
	Response.write "</tbody></table>"+VBCRLF
End If 
%>
<OBJECT RUNAT="SERVER" PROGID="ADODB.RecordSet" ID="Rs"></OBJECT>