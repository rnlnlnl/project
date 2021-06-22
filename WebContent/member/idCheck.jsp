<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	
	String id = request.getParameter("id");
	
	
	
	MemberDAO mDAO = new MemberDAO();
	
	// 데이터 타입 지정해서 가져오기
	int result = mDAO.idCheck(id);
	%>
	<%=result %>
