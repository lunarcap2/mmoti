<!--
 /**
  * ��Ű�� ����
  * @param cookieName ��Ű��
  */

 function setCookieDomain()
 {
	 // only. Ŀ���� ������(SSL����)
	if(document.domain.indexOf("career.co.kr") >= 0)
		return "domain = career.co.kr;";
 }

 function getCookie( cookieName )
 {
  var search = cookieName + "=";
  var cookie = document.cookie;

  // ���� ��Ű�� ������ ���
  if( cookie.length > 0 )
  {
   // �ش� ��Ű���� �����ϴ��� �˻��� �� �����ϸ� ��ġ�� ����.
   startIndex = cookie.indexOf( cookieName );

   // ���� �����Ѵٸ�
   if( startIndex != -1 )
   {
    // ���� ���� ���� ���� �ε��� ����
    startIndex += cookieName.length;

    // ���� ���� ���� ���� �ε��� ����
    endIndex = cookie.indexOf( ";", startIndex );

    // ���� ���� �ε����� ��ã�� �Ǹ� ��Ű ��ü���̷� ����
    if( endIndex == -1) endIndex = cookie.length;

    // ��Ű���� �����Ͽ� ����
    return unescape( cookie.substring( startIndex + 1, endIndex ) );
   }
   else
   {
    // ��Ű ���� �ش� ��Ű�� �������� ���� ���
    return false;
   }
  }
  else
  {
   // ��Ű ��ü�� ���� ���
   return false;
  }
 }



 /**
  * ��Ű ����
  * @param cookieName ��Ű��
  * @param cookieValue ��Ű��
  * @param expireDay ��Ű ��ȿ��¥
  */
 function setCookie( cookieName, cookieValue, expireDate )
 {
	var today = new Date();
	today.setDate( today.getDate() + parseInt( expireDate ) );

	document.cookie = cookieName + "=" + escape( cookieValue ) + "; path=/; expires=" + today.toGMTString() +"; "+ setCookieDomain();
 }



 /**
  * ��Ű ����
  * @param cookieName ������ ��Ű��
  */
 function deleteCookie( cookieName )
 {
	var expireDate = new Date();

	//���� ��¥�� ��Ű �Ҹ� ��¥�� �����Ѵ�.
	expireDate.setDate( expireDate.getDate() - 1 );
	document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString() + "; path=/; "+ setCookieDomain();
 }



 /**
  * �ڽ��� ������ ������ ��Ű ����
  */
 function setMyCookie()
 {
	setCookie( form.setName.value, form.setValue.value, form.expire.value );
	viewCookie(); // ��ü ��Ű ��� ����
 }



 /**
  * �ڽ��� ������ ��Ű������ Ȯ��
  */
 function getMyCookie()
 {
	alert( "��Ű �� : " + getCookie( form.getName.value ) );
 }



 /**
  * �ڽ��� ������ ��Ű������ ��Ű ����
  */
 function deleteMyCookie()
 {
	deleteCookie( form.deleteName.value );
	alert("��Ű�� �����Ǿ����ϴ�.");
	viewCookie();
 }



 /**
  * ��ü ��Ű ���
  */
 function viewCookie()
{
	if( document.cookie.length > 0 )
		return document.cookie;
	else
		return "����� ��Ű�� �����ϴ�.";
 }
//-->