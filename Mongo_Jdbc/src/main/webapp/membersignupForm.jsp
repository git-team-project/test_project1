<%@page import="people.People"%>
<%@page import="people.PeopleDao"%>
<%@ page language="java" contentType="text/html; charset=euc-kr"
    pageEncoding="euc-kr"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="euc-kr">
<title>Insert title here</title>
</head>
<body>
	<% request.setCharacterEncoding("euc-kr");%>
	<h1>회원 가입</h1>
	<form action="signup.jsp" method="post" name="signUpForm">
	<table border="1" width="800">
		<tr bgcolor="lightgrey">
			<td>아이디</td>
			<td>이름</td>
			<td>비밀번호</td>
			<td>부서</td>
			<td>주소</td>
			<td>핸드폰 번호</td>
			<td>이메일</td>
		</tr>
		
 		<tr>
			<td><input type="text" name="memberId" /></td>
			<td><input type="text" name="name" /></td>
			<td><input type="password" name="pw" /></td>
			<td>
				<select name="dept" id="dept">
				  <option value="영업부">영업부</option>
				  <option value="관리부">관리부</option>
				  <option value="기술부">기술부</option>
				  <option value="생산부">생산부</option>
				  <option value="개발부">개발부</option>
				</select>
			</td>
			<td><input type="text" name="address"/></td>
			<td><input type="text" name="pno"/></td>
			<td><input type="text" name="email"/></td>
			<!--  -->
		</tr>
	</table><br>
	<input type="submit" value="회원 가입">
	</form>
</body>
<br><br>
</html>
