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
		request.setCharacterEncoding("EUC-KR");
	String member_id = (String)session.getAttribute("idKey");
	%>
	
<!-- 	<form method = "get" action="logout.jsp" name = "logout"> -->
<!-- 	<input type="submit" value = "�α׾ƿ�"/> -->
<!-- 	</form> -->
	
	
	<form method=post action ="result.jsp">
			<h4> <%= member_id %>�� �ȳ��ϼ���</h4>		
			<br/>
			<h1>������ICT 4�� ȸ�ĸ޴� ��ǥ</h1>
			<table>
				<tr>
				<td><img src="https://pelicana.co.kr/resources/images/menu/best_menu02_200824.jpg" width="100" height="100"> </td>
				<td><img src="https://src.hidoc.co.kr/image/lib/2020/6/17/1592363657269_0.jpg" width="100" height="100"> </td>
				<td><img src="https://cdn.mindgil.com/news/photo/202103/70839_7148_1250.jpg" width="100" height="100"> </td>
				<td><img src="https://kr.savorjapan.com/gg/content_image/0006130995F42.jpg" width="100" height="100"> </td>
				</tr>
				<tr >
				<td><input type="radio" name="checks" value="chicken" />ġŲ</td>
				<td><input type="radio" name="checks" value="pizza" />����</td>
				<td><input type="radio" name="checks" value="meat" />���</td>
				<td><input type="radio" name="checks" value="shabu" />�������</td>
				</tr>
				
				</table>
			<input type="submit" value="Ȯ��"/>
			<button type="button" onClick="location.href='resultList.jsp'" name="result">��ǥ��Ȳ</button>
			<button type="button" onClick="location.href='logout.jsp'" name="result">�α׾ƿ�</button>
		</form>
	
</body>
</html>