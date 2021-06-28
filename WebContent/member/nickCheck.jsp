<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	MemberDAO mDAO = new MemberDAO();
	String nickname = request.getParameter("nickname");
	String id = (String)session.getAttribute("id");
	
	int check = mDAO.nickCheck(nickname); 
	
%>
	<%=check%>