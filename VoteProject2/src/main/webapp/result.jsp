<%@page import="java.util.Collections"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.lang.reflect.Array"%>
<%@page import="java.util.LinkedList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>result.jsp</title>
</head>
<body>
	<%
	String driver = "com.mysql.cj.jdbc.Driver";
	String url = "jdbc:mysql://192.168.0.206:13306/db01";
    Connection con = null;
    ResultSet rs=null;
    String member_id = null;
    String member_pw = null;
    String session_check = null;
    int max = 0;
    
	PreparedStatement pstmt = null;
	String sql = null;
	
	LinkedList<String> nameList = new LinkedList<>();
	LinkedList<String> valueList = new LinkedList<>();
	LinkedList<String> lankStrList = new LinkedList<>();
	
	boolean isFlag = false;
	
	
	try {
			member_id = (String)session.getAttribute("idKey"); // �̸�

			String[] foods = request.getParameterValues("checks");
			for (String food : foods) {
				session.setAttribute("valueKey", food); // üũ�� ��. 1���� ��
			}

			// DB ����
			Class.forName(driver);
       		con = DriverManager.getConnection(url, "test", "1234");
			
			sql = "select value from member where member_id = '" + member_id + "'";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			String voteCheck = "";
			while (rs.next()) {
				voteCheck = rs.getString("value");
			}
			
			if (voteCheck == null){ // DB���� �޾ƿ��� ���� ��
			
				// ����
				sql = "update member set value = ? where member_id = ?";
				pstmt = con.prepareStatement(sql);
				String member_value = (String)session.getAttribute("valueKey"); 
				pstmt.setString(1, member_value);
				System.out.println("member_value : " + member_value);
				
				pstmt.setString(2, member_id);
				System.out.println("member_id : " + member_id);
	
				int n = pstmt.executeUpdate();
				System.out.println("������ ���� ����!!");
	
				// ��ȸ.
	// 			sql = "select value, count(*) from member group by value order by count(*) desc";
				sql = "select name, ifnull(cnt, 0) as count from menu a left join (select count(*) cnt, value from member group by (value)) b on a.name = b.value order by count desc";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				while (rs.next()) {
					String databaseValue = rs.getString("name");
					String databaseCount = rs.getString("count");
					max = Math.max(max, Integer.parseInt(databaseCount));
					
					System.out.println("value : " + databaseValue);
					System.out.println("count : " + databaseCount);
					
					nameList.add(databaseValue); // ������ �� ����Ʈ
					valueList.add(databaseCount); // ���� ���� ī��Ʈ
				}
				
				sql = "select value, count(*) as count from member group by value having count = " + max;
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				while (rs.next()) {
					if (rs.getString("value") != null){
						lankStrList.add(rs.getString("value"));
						System.out.println("rs.getString : " + rs.getString("value"));
					}
				}
			} else { 
				// ��ǥ�� ���� ��� 
				%>
				<script type="text/javascript">
				alert("�̹� ��ǥ�� �߽��ϴ�.");
				location.href="resultList.jsp";
				</script>
				<%  
			}
			
		} catch (Exception ex) { 
// 			ex.printStackTrace();
		%>
		 	
			<script type="text/javascript">
			alert("��ǥ ���ּ���!!");
			history.back();
			</script>
		
			<%
			System.out.println("������ ���� ����!!");
		}
	
	%>
	
	<div>
		<%=member_id%>���� ��ǥ�ϼ̽��ϴ�.
	</div>
	
	<div>
		<% for (int i = 0; i < nameList.size(); i++){%>
		<p>
			<%= nameList.get(i) %>, ��ǥ�� : <%= valueList.get(i) %>
		</p>
		<%}%>
		
		
			<h3>1���� 
			<%
			String val = "";
			for (int i = 0; i < lankStrList.size(); i++){
				val = lankStrList.get(i);
				if (i == lankStrList.size() - 1){
				System.out.println("lankStrList.size()" + lankStrList.size());
				%> 
					<%= val%> <%= max%>ǥ �Դϴ�.
				<%} else {%>
					<%= val%>,
				<%}%>
				<%} %>
			
			
			</h3>
	</div>
	<form action="logout.jsp">
			<input type="submit" value="Ȯ��" />
	</form>
</body>
</html>