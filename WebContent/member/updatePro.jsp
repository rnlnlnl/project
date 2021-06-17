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
<jsp:useBean id="beanList" class="member.MemberBean"/>
<jsp:getProperty property="*" name="beanList"/>
<%
	request.setCharacterEncoding("UTF-8");
	
	MemberDAO mDAO = new MemberDAO();
	
	mDAO.myPageUpdate(beanList);
	
	response.sendRedirect("./main.jsp");
%>
	
	
	
	
</body>
</html>