<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<jsp:useBean id="mbeen" class="member.MemberBean"/>
<jsp:setProperty property="*" name="mbeen"/>
<%
	//한글처리 
	request.setCharacterEncoding("UTF-8");
	
	MemberDAO mdao = new MemberDAO();
	
	mdao.memberInsert(mbeen);
	
	response.sendRedirect("./login.jsp");
%>
	
