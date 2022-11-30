<%@page import="people.People"%>
<%@page import="people.PeopleDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="org.bson.types.ObjectId" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
	//MongoDatabase db = ConnectMongoDB.getDatabase();
	//MongoCollection<Document> collection = db.getCollection("people");
	
	//Document deleteDocument = new Document("name","나이스");
	//collection.deleteOne(deleteDocument);
	
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html; charset=UTF-8");
	
	//String id = "6385ee624253e4c41b7b7a45";
	String id = request.getParameter("id");
	String memberId = request.getParameter("memberId");
	String name = request.getParameter("name");
	String address = request.getParameter("address");
	String dept = request.getParameter("dept");
	String email = request.getParameter("email");
	String pno = request.getParameter("pno");
	
	People dto = new People(new ObjectId(id), memberId, address, name, dept, pno, email);
	PeopleDao dao = new PeopleDao();
	
	long result = dao.update(dto);
	
	if(result > 0) {
	   	response.sendRedirect("memberlist.jsp");
	} else {
	   	request.getRequestDispatcher("memberlist.jsp").forward(request, response);
		out.print("<script>alert('수정 실패하였습니다.');</script>");
	}
%>
<body>
</body>
</html>