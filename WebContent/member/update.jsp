<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
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
	MemberBean beanList = new MemberBean();
	
	ArrayList list = mDAO.getMyPage(id);
	beanList = (MemberBean)list.get(0);
%>
	
	<fieldset>
		<legend>내정보 변경</legend>
		<form action="updatePro.jsp" method="post" >
			<label>아이디</label>
			<input type="text" name="id" value="<%=beanList.getId()%>" readonly><br>
			
			<label>이름</label>
			<input type="text" name="name" value="<%=beanList.getName()%>" readonly><br>
			
			<label>닉네임</label>
			<input type="text" name="nickname" value="<%=beanList.getNickname()%>" readonly><br>
			
			<label>나이</label>
			<input type="text" name="age" value="<%=beanList.getAge()%>"><br>
			
			<label>이메일</label>
			<input type="text" name="email" value="<%=beanList.getEmail()%>" readonly><br>
			
			<label>주소</label>
			<input type="text" name="addr1" value="<%=beanList.getAddr1()%>"><br>
			<input type="text" name="addr2" value="<%=beanList.getAddr2()%>"><br>
			<input type="text" name="addr3" value="<%=beanList.getAddr3()%>"><br>
			
			<label>전화번호</label>
			<input type="text" name="tel" value="<%=beanList.getTel()%>"><br>
			
			<input type="submit" value="변경하기">
			<button><a href="../main.jsp">돌아가기</a></button>
		</form>
	</fieldset>
	
	
	
	
	
	
	
	
	
	
	
</body>
</html>