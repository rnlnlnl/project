<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");	
%>
	
	<jsp:useBean id="bbean" class="board.BoardBean"/>
	<jsp:setProperty property="*" name="bbean"/>
<%
	bbean.setIp(request.getRemoteAddr());
	
	BoardDAO bDAO = new BoardDAO();
	bDAO.reInsertBoard(bbean);
	
	response.sendRedirect("boardList.jsp");
	
	
%>
	
	
	
</body>
</html>