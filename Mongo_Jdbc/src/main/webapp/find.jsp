<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="people.PeopleDao"%>
<%@page import="people.People"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
	//MongoDatabase db = ConnectMongoDB.getDatabase();
	//MongoCollection<Document> collection = db.getCollection("people");
	
	//MongoCursor<Document> it = collection.find().iterator();
	//ArrayList<Object> res = new ArrayList<>();
	//while ( it.hasNext() ) // 다음커서 인덱스에 값이 있으면 true 없으면 false 
	//{  
	//    System.out.println(it.next()); // .next() 현제 커서의 값을 반환하고 커서를 다음으로 옮긴다 
	//    res.add(it.next());
	//}
	
	//out.print(res);
	PeopleDao dao = new PeopleDao();
	List<People> list = dao.findAll();
%>
<script type="text/javascript">
	let goAction = function(arg, id) {
		let form = document.form;
		document.getElementById("hiddenId").value = id;
		(arg === 'delete') ? form.action = 'delete.jsp' : form.action = 'findOne.jsp';
		form.submit();
	}
</script>
<body>
	<h1>회원 목록 조회</h1>
	<form action="" method="post" name="form">
	<input type="hidden" id="hiddenId" name="id" />
	<table border="1" width="800">
		<tr bgcolor="lightgrey">
			<td width="300">회원번호</td>
			<td>이름</td>
			<td>나이</td>
			<td>삭제</td>
			<td>수정</td>
		</tr>
<%
		for(int i=0; i<list.size(); i++) {
%>
		<tr>
		
			<td><%=list.get(i).getId() %></td>
			<td><%=list.get(i).getName() %></td>
			<td><%=list.get(i).getAge() %></td>
			<td><a href="javascript:goAction('delete', '<%=list.get(i).getId() %>')">삭제</a></td>
			<td><a href="javascript:goAction('findOne', '<%=list.get(i).getId() %>')">수정</a></td>
		</tr>
<%
		}
%>
	</table><br>
	</form>
	<a href="insertForm.jsp">document 추가</a>
</body>
</html>