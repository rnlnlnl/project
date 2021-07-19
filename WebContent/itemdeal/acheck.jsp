<%@page import="item.ItemDAO"%>
<%@page import="like.LikeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String acheck = request.getParameter("acheck");
	int num = Integer.parseInt(request.getParameter("num"));
	ItemDAO iDAO = new ItemDAO();
	String achecked = iDAO.adminCheck(acheck, num);
%>
<%=achecked%>