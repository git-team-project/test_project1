<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
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
	request.setCharacterEncoding("euc-kr");
	
	String driver = "com.mysql.cj.jdbc.Driver";
    String url = "jdbc:mysql://192.168.0.206:13306/db01";
    Connection con = null;
    Statement stmt =null;
    ResultSet rs=null;
    String member_id = null;
    String member_pw = null;
    int num = 0;
    String session_check = null;
    
    try {
       Class.forName(driver);
       con = DriverManager.getConnection(url, "test", "1234");
       System.out.println("데이터 베이스 연결 성공!!");
       
       member_id = request.getParameter("member_id");
		member_pw = request.getParameter("member_pw");
		
		System.out.println(member_id + " " + member_pw);
		
		String sql = "SELECT count(*) as memberData, session FROM member where member_id = '" + member_id +"' and password = '" + member_pw +"' GROUP BY session";
		
		stmt = con.createStatement();
		rs = stmt.executeQuery(sql);
		
		while(rs.next()) {
			num = rs.getInt("memberData");
			session_check = rs.getString("session");
		}
		
		// 최초의 로그인, 세션이 빌 때만 로그인할 수 있다
		if(session_check == null) {
			String newSession = session.getId();
			System.out.println(newSession);
			sql = "update member set session = '" + newSession + "' where member_id = '" + member_id + "' and password = '" + member_pw +"'";
			PreparedStatement psmt = con.prepareStatement(sql);
			psmt.executeUpdate();
		// 세션값을 가지고 있다 -> 누군가 로그인 하고 있음 -> 로그인 x (중복 방지)
		} else {
			num = 0;
		}
    } catch (Exception e) {
       System.out.println("데이터 베이스 연결실패!!");
       e.printStackTrace();
    }finally {
       try {
          if(con != null)
             con.close();
       }catch(Exception e){
          System.out.println(e.getMessage());
       }
    }
    
    // 로그인이 되는 경우
    if(num == 1) {
    	session.setAttribute("idKey", member_id);
		response.sendRedirect("vote.jsp");
    } else { // 로그인이 안되는 경우
    	// 누군가 접속중인 경우
    	if(session_check != null) {
		%>
		
		<script type="text/javascript">
			alert("누군가 접속중입니다!");
			history.back();
		</script>
		<%    		
    	// 아이디와 비밀번호를 틀린경우	
    	} else {
		%>    		
    	<script type="text/javascript">
			alert("아이디와 비밀번호를 확인해주세요!");	
			history.back();
		</script>
    	<% 	
    	}
		//response.sendRedirect("index.jsp");
    }
	%>
</body>
</html>