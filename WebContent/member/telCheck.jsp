<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	String tel = request.getParameter("tel");
	MemberDAO mDAO = new MemberDAO();
	int tcheck = mDAO.telCheck(tel); 
%>
<%=tcheck%>



