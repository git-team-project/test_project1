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
       System.out.println("������ ���̽� ���� ����!!");
       
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
		
		// ������ �α���, ������ �� ���� �α����� �� �ִ�
		if(session_check == null) {
			String newSession = session.getId();
			System.out.println(newSession);
			sql = "update member set session = '" + newSession + "' where member_id = '" + member_id + "' and password = '" + member_pw +"'";
			PreparedStatement psmt = con.prepareStatement(sql);
			psmt.executeUpdate();
		// ���ǰ��� ������ �ִ� -> ������ �α��� �ϰ� ���� -> �α��� x (�ߺ� ����)
		} else {
			num = 0;
		}
    } catch (Exception e) {
       System.out.println("������ ���̽� �������!!");
       e.printStackTrace();
    }finally {
       try {
          if(con != null)
             con.close();
       }catch(Exception e){
          System.out.println(e.getMessage());
       }
    }
    
    // �α����� �Ǵ� ���
    if(num == 1) {
    	session.setAttribute("idKey", member_id);
		response.sendRedirect("vote.jsp");
    } else { // �α����� �ȵǴ� ���
    	// ������ �������� ���
    	if(session_check != null) {
		%>
		
		<script type="text/javascript">
			alert("������ �������Դϴ�!");
			history.back();
		</script>
		<%    		
    	// ���̵�� ��й�ȣ�� Ʋ�����	
    	} else {
		%>    		
    	<script type="text/javascript">
			alert("���̵�� ��й�ȣ�� Ȯ�����ּ���!");	
			history.back();
		</script>
    	<% 	
    	}
		//response.sendRedirect("index.jsp");
    }
	%>
</body>
</html>