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
	
	//out.print("create 성공");
%>
<script type="text/javascript">
let goInsert = function() {
	document.insertForm.submit();
}
</script>
<body>
	<h1>회원 등록</h1>
	<form action="insert.jsp" method="post" name="insertForm">
	<table border="1" width="800">
		<tr bgcolor="lightgrey">
			<td>이름</td>
			<td>나이</td>
			<td>추가</td>
		</tr>
		<tr>
			<td><input type="text" name="name" /></td>
			<td><input type="text" name="age" /></td>
			<td><a href="javascript:goInsert()">추가</a></td>
		</tr>
	</table><br>
	</form>
	<a href="find.jsp">회원 목록 조회</a>
</body>
</html>