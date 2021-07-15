<%@page import="item.ItemBean"%>
<%@page import="item.ItemDAO"%>
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
		
		String id = (String)session.getAttribute("id");
		String nickname = (String)session.getAttribute("nickname");
		int num = Integer.parseInt(request.getParameter("num"));
		String pageNum = request.getParameter("pageNum");
		
		ItemDAO iDAO = new ItemDAO();
		
		iDAO.updateMemberShip(nickname);
		
		ItemBean ibean = iDAO.getBoard(num);
		 
		
	%>
</body>
</html>