<%@page import="people.PeopleDao"%>
<%@page import="people.People"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
	//MongoDatabase db = ConnectMongoDB.getDatabase();
	//MongoCollection<Document> collection = db.getCollection("people");
	
	//Document createDocument = new Document("name","나이스");
	//collection.insertOne(createDocument);
	
	String name = request.getParameter("name");
	int age = Integer.parseInt(request.getParameter("age"));
	
	//People dto = new People(name, age);
	PeopleDao dao = new PeopleDao();
	
	//boolean result = dao.insert(dto);
	
/* 	if(result) {
	   	response.sendRedirect("find.jsp");
	} else {
	   	request.getRequestDispatcher("find.jsp").forward(request, response);
		out.print("<script>alert('회원 등록 실패하였습니다.');</script>");
	} */
%>

<body>
</body>
</html>