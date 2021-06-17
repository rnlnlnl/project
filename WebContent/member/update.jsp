<%@page import="java.util.ArrayList"%>
<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>내정보 변경</title>
</head>
<body>
<%
	String id = (String)session.getAttribute("id");
	String nikename = (String)session.getAttribute("nickname");
	
	MemberDAO mDAO = new MemberDAO();
	MemberBean bean = new MemberBean();
	
	ArrayList myList = mDAO.getMyPage(id);
	bean = (MemberBean)myList.get(0);
%>
	
	<fieldset>
		<legend>내정보 변경</legend>
		<form action="updatePro.jsp" method="post" >
			<label></label>
			<input type="text" name="id" value="<%=bean.getId()%>"><br>
			
			<label></label>
			<input type="text" name="name" value="<%=bean.getName()%>"><br>
			
			<label></label>
			<input type="text" name="nickname" value="<%=bean.getNickname()%>"><br>
			
			<label></label>
			<input type="text" name="age" value="<%=bean.getAge()%>"><br>
			
			<label></label>
			<input type="text" name="email" value="<%=bean.getEmail()%>"><br>
			
			<label></label>
			<input type="text" name="addr1" value="<%=bean.getAddr1()%>"><br>
			<input type="text" name="addr2" value="<%=bean.getAddr2()%>"><br>
			<input type="text" name="addr3" value="<%=bean.getAddr3()%>"><br>
			
			<label></label>
			<input type="text" name="tel" value="<%=bean.getTel()%>"><br>
			
			<input type="submit" value="변경하기">
			<button><a href="../main.jsp">돌아가기</a></button>
		</form>
	</fieldset>
	
	
	
	
	
	
	
	
	
	
	
</body>
</html>