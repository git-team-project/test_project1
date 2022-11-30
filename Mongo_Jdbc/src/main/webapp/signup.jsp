<%@page import="people.PeopleDao"%>
<%@page import="people.People"%>
<%@ page language="java" contentType="text/html; charset=euc-kr"
    pageEncoding="euc-kr"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="euc-kr">
<title>Insert title here</title>

</head>
<body>


	<%		
	 	request.setCharacterEncoding("euc-kr");
		String memberId = request.getParameter("memberId");
		String pw = request.getParameter("pw");
		String address = request.getParameter("address");
		String name = request.getParameter("name");
		String dept = request.getParameter("dept");
		String pno = request.getParameter("pno");
		String email = request.getParameter("email");
	
	People dto = new People(memberId, pw, address, name, dept, pno, email);
	PeopleDao dao = new PeopleDao();
	
	boolean result = dao.insert(dto);
	
	if(result) {
	   	response.sendRedirect("index.jsp");
	} else {
	   	request.getRequestDispatcher("index.jsp").forward(request, response);
		out.print("<script>alert('회원 등록 실패하였습니다.');</script>");
	}
	
	%>

</body>
</html>