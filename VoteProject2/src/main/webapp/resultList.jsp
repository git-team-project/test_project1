<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Vote List Page</title>
</head>
<body>
	<%
		request.setCharacterEncoding("EUC-KR");
	
	String driver = "com.mysql.cj.jdbc.Driver";
	String url = "jdbc:mysql://192.168.0.206:13306/db01";
    Connection con = null;
    Statement stmt =null;
    ResultSet rs1=null;
    ResultSet rs2=null;
    ResultSet rs3=null;
    
    String type = request.getParameter("type");
    String member_id = (String)session.getAttribute("idKey");
    
    try {
       Class.forName(driver);
       con = DriverManager.getConnection(url, "test", "1234");
       System.out.println("데이터 베이스 연결 성공!!");
       stmt = con.createStatement();
       
	%>
	<!-- 	로그아웃 -->
	
	
	<%
	String[] arr = {"chicken", "pizza", "meat", "shabu"};
	String[] arr1 = {"치킨", "피자", "고기", "샤브샤브"};
	
	%>
	
	<div>
	<h3>투표 현황입니다.</h3>
	 <ul>
	 
	 	<%
	 	for(int i = 0; i < arr.length; i++) {
	 	%>

	 	<li><%=arr1[i]%></li>
	 	<%
	 	String sql = "select * from member where value = '" + arr[i]+ "'";
	       rs1 = stmt.executeQuery(sql);
	       ArrayList<String> members = new ArrayList<>();
	       
	       while(rs1.next()){
		 		members.add(rs1.getString("member_id"));
		 	} 
	       
			if (members.size() > 0){
				for (String member : members){
					out.print(member + " ");
				}
			} else {
				out.print("투표한 사람이 없습니다.");
			}
	 	}
	 	
	 	%>
	 	
	 	<br/><br/>
	 	
	 	투표 안한 사람<br/>
	 	<% 
 	 	String sql = "select member_id from member where value is null";
	       rs2 = stmt.executeQuery(sql);
	       String members = null;
	       
	       while(rs2.next()){
		 		members = rs2.getString("member_id");
	       
		 		if(members !=null) {
		 			out.print(members+" ");
			 	} 
	       }
	    %>
	    
	 </ul>
	</div>
	<%
		sql ="select value from member where member_id = '" + member_id + "'";
		rs3 = stmt.executeQuery(sql);
		String voteValue = null;
		
		while(rs3.next()){
			voteValue = rs3.getString("value");
		}
		
		if (voteValue == null){ %>
				<button type="button" onClick="location.href='vote.jsp'" >뒤로가기</button>
		<% }%>
	
	<% } catch (Exception se) {

		System.out.println(se.getMessage());

	} finally {

		try {

			if (rs1 != null)
				rs1.close();
			
			if (rs2 != null)
				rs2.close();
			
			if (rs3 != null)
				rs3.close();

			if (stmt != null)
				stmt.close();

			if (con != null)
				con.close();

		} catch (Exception se) {

			System.out.println(se.getMessage());

		}
	}
	 	%>
	 		<button type="button" onClick="location.href='logout.jsp'" >로그아웃</button>
	 	
</body>
</html>