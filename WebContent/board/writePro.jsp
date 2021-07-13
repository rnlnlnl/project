<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
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
		<jsp:useBean id="bbean" class="board.BoardBean" />
		<jsp:setProperty property="*" name="bbean"/>
		
	<%
		int maxSize = 100*1024*1024*1024; // 100MB
		
		String realPath = request.getRealPath("/upLoadFile");
		
		MultipartRequest multi = 
						new MultipartRequest(
								request,
								realPath,
								maxSize,
								"UTF-8",
								new DefaultFileRenamePolicy()
								);
		
		String nickname = multi.getParameter("nickname");
		String title = multi.getParameter("title");
		String file = multi.getParameter("file");
		String content = multi.getParameter("content");
		
		bbean.setNickname(nickname);
		bbean.setTitle(title);
		bbean.setFile(file);
		bbean.setContent(content);
		// ip주소 추가
		bbean.setIp(request.getRemoteAddr());
	
		BoardDAO bDAO = new BoardDAO();
		
		bDAO.insertBoard(bbean);
		
		response.sendRedirect("boardList.jsp");
	%>	
		
		
		
	
</body>
</html>