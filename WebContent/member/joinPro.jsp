<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원가입</title>
<jsp:useBean id="mbeen" class="member.MemberBean"/>
<jsp:setProperty property="*" name="mbeen"/>
</head>
<body>
<%
	//한글처리 
	request.setCharacterEncoding("UTF-8");
	
	MemberDAO mdao = new MemberDAO();
	
	mdao.memberInsert(mbeen);
	
	response.sendRedirect("./login.jsp");
	
%>
	
	
	
	
</body>
</html>