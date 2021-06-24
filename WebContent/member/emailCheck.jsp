<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<%
	request.setCharacterEncoding("UTF-8");
	String email = request.getParameter("email");
	MemberDAO mDAO = new MemberDAO();
	int check = mDAO.emailCheck(email); 
%>
<%=check%>









