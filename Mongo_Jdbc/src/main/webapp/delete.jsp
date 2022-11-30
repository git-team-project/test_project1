<%@page import="people.PeopleDao"%>
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
	
	//Document deleteDocument = new Document("name","나이스");
	//collection.deleteOne(deleteDocument);
	
	PeopleDao dao = new PeopleDao();
	String id = request.getParameter("id");
	long result = dao.delete(id);
	//out.print("delete 성공");
	if(result > 0) {
	   	response.sendRedirect("index.jsp");
	} else {
	   	request.getRequestDispatcher("index.jsp").forward(request, response);
		out.print("<script>alert('삭제 실패하였습니다.');</script>");
	}
%>
<body>
</body>
</html>