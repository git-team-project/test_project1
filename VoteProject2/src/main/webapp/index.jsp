<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Vote Login Page</title>
</head>
<body>
	
	<%
		request.setCharacterEncoding("euc-kr");
	%>
	
	
	<form method = "post" action="loginCheck.jsp">
	���̵� : <input type="text" name = "member_id" value = ""/>
	��й�ȣ : <input type="password" name = "member_pw" value = ""/><br/><br/>
	<input type="submit" value = "�α���"/>
	</form>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
</body>
</html>