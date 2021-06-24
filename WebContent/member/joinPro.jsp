<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%
//한글처리는 위쪽에 해줘야 오류가 안일어 난다 Bean을 위에 적으면 깨진거를 받아와서 저장을 하기 떄문
request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="mbeen" class="member.MemberBean"/>
<jsp:setProperty property="*" name="mbeen"/>
<%
	
	MemberDAO mdao = new MemberDAO();
	
	mdao.memberInsert(mbeen);
	
	response.sendRedirect("./login.jsp");
%>
	
