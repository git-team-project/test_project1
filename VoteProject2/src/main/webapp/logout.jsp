<%@page import="java.sql.PreparedStatement"%>
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
	String member_id = (String)session.getAttribute("idKey");
	request.setCharacterEncoding("euc-kr");
	
	String driver = "com.mysql.cj.jdbc.Driver";
	String url = "jdbc:mysql://192.168.0.206:13306/db01";
	Connection con = null;
	
	try {
	   Class.forName(driver);
	   con = DriverManager.getConnection(url, "test", "1234");
	   System.out.println("데이터 베이스 연결 성공!!");
	   
		String sql = "update member set session = null where member_id = '" + member_id +"'";
		PreparedStatement psmt = con.prepareStatement(sql);
		psmt.executeUpdate();
		
	} catch (Exception e) {
	   System.out.println("데이터 베이스 연결실패!!");
	   e.printStackTrace();
	}finally {
	   try {
	      if(con != null)
	         con.close();
	   }catch(Exception e){
	      System.out.println(e.getMessage());
	   }
	}
	session.invalidate();
	
	response.sendRedirect("index.jsp");
%>


</body>
</html>