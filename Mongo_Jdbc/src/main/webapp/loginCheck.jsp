<%@page import="people.PeopleDao"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<%
		PeopleDao dao = new PeopleDao();
		String memberId = request.getParameter("memberId");
		String pw = request.getParameter("pw");

		if(dao.loginCheck(memberId, pw)) {
			response.sendRedirect("memberlist.jsp");
		} else {
			response.sendRedirect("index.jsp");
		}	
	%>
	
	
</body>
</html>