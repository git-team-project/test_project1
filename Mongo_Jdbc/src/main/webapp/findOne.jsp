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
	//String id = "6385ee624253e4c41b7b7a45";
	People dto = dao.findOneById(id);
%>
<script type="text/javascript">

let goUpdateDelete = function(arg, id) {
	let form = document.updateDeleteForm;
	(arg === 'delete') ? form.action = 'delete.jsp' : form.action = 'update.jsp';
	form.submit();
}

</script>
<body>
	<h1>회원 정보 수정</h1>
	<form action="" method="post" name="updateDeleteForm">
	<table border="1" width="800">
		<tr bgcolor="lightgrey">
			<td width="300">회원번호</td>
			<td>아이디</td>
			<td>이름</td>
			<td>부서</td>
			<td>주소</td>
			<td>핸드폰 번호</td>
			<td>이메일</td>
		</tr>
 		<tr>
			<td><input type="text" name="id" value="<%=dto.getId() %>" readonly /></td>
			<td><input type="text" name="memberId" value="<%=dto.getMemberId() %>" /></td>
			<td><input type="text" name="name" value="<%=dto.getName() %>" /></td>
			<td>
				<select name="dept" id="dept">
				  <option value="영업부">영업부</option>
				  <option value="관리부">관리부</option>
				  <option value="기술부">기술부</option>
				  <option value="생산부">생산부</option>
				  <option value="개발부">개발부</option>
				</select>
			</td>
			<td><input type="text" name="address" value="<%=dto.getAddress() %>" /></td>
			<td><input type="text" name="pno" value="<%=dto.getPno() %>" /></td>
			<td><input type="text" name="email" value="<%=dto.getEmail() %>" /></td>
		</tr>
	</table><br>
	</form>
</body>
<input type="submit" value="수정" onclick="javascript:goUpdateDelete('update')">
<input type="button" value="탈퇴" onclick="javascript:goUpdateDelete('delete', '<%=dto.getId() %>')">
<br><br>
<a href="memberlist.jsp">회원 목록 조회</a>
</html>