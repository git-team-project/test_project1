<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="people.PeopleDao"%>
<%@page import="people.People"%>

<!DOCTYPE html>
<html>
<head>
<style>
table {
	text-align: center;
}

</style>
<meta charset="UTF-8">
<title>Insert title here12</title>
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
	<h1>직원 목록 조회</h1>
	<form action="" method="post" name="form">
	<input type="hidden" id="hiddenId" name="id" />
	<table border="1" width="1000">
		<tr bgcolor="lightgrey">
			<td>ID</td>
			<td>이름</td>
			<td>주소</td>
			<td>전화번호</td>
			<td>이메일</td>
			<td>부서</td>
			<td>수정</td>
		</tr>
<%
		for(int i=0; i<list.size(); i++) {
%>
		<tr>
			<td><%=list.get(i).getMemberId() %></td>
			<td><%=list.get(i).getName() %></td>
			<td><%=list.get(i).getAddress() %></td>
			<td><%=list.get(i).getPno() %></td>
			<td><%=list.get(i).getEmail() %></td>
			<td><%=list.get(i).getDept() %></td>
			<td><a href="javascript:goAction('findOne', '<%=list.get(i).getId() %>')">수정</a></td>
		</tr>
<%
		}
%>
	</table><br>
	</form>

</body>
</html>