<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String email = request.getParameter("email");
	MemberDAO mDAO = new MemberDAO();
	int echeck = mDAO.emailCheck(email); 
%>
<%=echeck%>









