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
	아이디 : <input type="text" name = "memberId" value = ""/>
	비밀번호 : <input type="password" name = "pw" value = ""/><br/><br/>
	<input type="submit" value = "로그인"/>
	<button type="button" onclick="location.href='membersignupForm.jsp'">회원가입</button>
	</form>
	
</body>
</html>