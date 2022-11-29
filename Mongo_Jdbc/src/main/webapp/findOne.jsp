<%@page import="people.People"%>
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
//	MongoDatabase db = ConnectMongoDB.getDatabase();
//	MongoCollection<Document> collection = db.getCollection("people");
	
//	MongoCollection<Document> documentMongoCollection = db.getCollection("people");
//	collection.updateOne(new Document("name","isohyeon1"), new Document("$set", new Document("name", "이소현")));
	
//	out.print("update 성공");
	PeopleDao dao = new PeopleDao();
	String id = request.getParameter("id");
	People dto = dao.findOneById(id);
%>
<script type="text/javascript">
let goUpdate = function() {
	document.updateForm.submit();
}
</script>
<body>
	<h1>회원 정보 조회</h1>
	<form action="update.jsp" method="post" name="updateForm">
	<table border="1" width="800">
		<tr bgcolor="lightgrey">
			<td width="300">회원번호</td>
			<td>이름</td>
			<td>나이</td>
			<td>수정</td>
		</tr>
		<tr>
			<td><input type="text" name="id" value="<%=dto.getId() %>" readonly /></td>
			<td><input type="text" name="name" value="<%=dto.getName() %>" /></td>
			<td><input type="text" name="age" value="<%=dto.getAge() %>" /></td>
			<td><a href="javascript:goUpdate()">수정</a></td>
		</tr>
	</table><br>
	</form>
</body>
<a href="find.jsp">회원 목록 조회</a>
</html>