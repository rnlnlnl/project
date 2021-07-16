<%@page import="item.ItemDAO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
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
	<jsp:useBean id="ibean" class="item.ItemBean"/>
	<jsp:setProperty property="*" name="ibean"/>
	<% 
		int maxSize = 10 * 1024 * 1024; // 100MB
		String realPath = request.getRealPath("/upItemFile");
		
		MultipartRequest multi =
						new MultipartRequest(
								request,
								realPath,
								maxSize,
								"UTF-8",
								new DefaultFileRenamePolicy()
								);
		
		ibean.setNickname(multi.getParameter("nickname"));
		ibean.setFile(multi.getFilesystemName("file"));
		ibean.setTitle(multi.getParameter("title"));
		ibean.setGname(multi.getParameter("gname"));
		ibean.setPrice(Integer.parseInt(multi.getParameter("price")));
		ibean.setContent(multi.getParameter("content"));
		// ip주소 추가
		ibean.setIp(request.getRemoteAddr());
		
		ItemDAO iDAO = new ItemDAO();
		iDAO.insertItem(ibean);
		 
		response.sendRedirect("dealBoard.jsp");
	%>

</body>
</html>