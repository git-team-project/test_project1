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
<!-- 	<input type="submit" value = "로그아웃"/> -->
<!-- 	</form> -->
	
	
	<form method=post action ="result.jsp">
			<h4> <%= member_id %>님 안녕하세요</h4>		
			<br/>
			<h1>포스코ICT 4기 회식메뉴 투표</h1>
			<table>
				<tr>
				<td><img src="https://pelicana.co.kr/resources/images/menu/best_menu02_200824.jpg" width="100" height="100"> </td>
				<td><img src="https://src.hidoc.co.kr/image/lib/2020/6/17/1592363657269_0.jpg" width="100" height="100"> </td>
				<td><img src="https://cdn.mindgil.com/news/photo/202103/70839_7148_1250.jpg" width="100" height="100"> </td>
				<td><img src="https://kr.savorjapan.com/gg/content_image/0006130995F42.jpg" width="100" height="100"> </td>
				</tr>
				<tr >
				<td><input type="radio" name="checks" value="chicken" />치킨</td>
				<td><input type="radio" name="checks" value="pizza" />피자</td>
				<td><input type="radio" name="checks" value="meat" />고기</td>
				<td><input type="radio" name="checks" value="shabu" />샤브샤브</td>
				</tr>
				
				</table>
			<input type="submit" value="확인"/>
			<button type="button" onClick="location.href='resultList.jsp'" name="result">투표현황</button>
			<button type="button" onClick="location.href='logout.jsp'" name="result">로그아웃</button>
		</form>
	
</body>
</html>