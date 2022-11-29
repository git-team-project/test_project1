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
	
	String id = request.getParameter("id");
	String name = request.getParameter("name");
	int age = Integer.parseInt(request.getParameter("age"));
	
	People dto = new People(new ObjectId(id), name, age);
	PeopleDao dao = new PeopleDao();
	
	long result = dao.update(dto);
	
	if(result > 0) {
	   	response.sendRedirect("find.jsp");
	} else {
	   	request.getRequestDispatcher("find.jsp").forward(request, response);
		out.print("<script>alert('수정 실패하였습니다.');</script>");
	}
%>
<body>
</body>
</html>