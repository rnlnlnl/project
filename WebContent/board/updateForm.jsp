<%@page import="board.BoardBean"%>
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
		int num = Integer.parseInt(request.getParameter("num"));
		String pageNum = request.getParameter("pageNum");
		String nickname = (String)session.getAttribute("nickname");
		
		BoardDAO bDAO = new BoardDAO();
		BoardBean bbean = bDAO.getBoard(num);
	%>
	
	
	<fieldset>
		<form action="updatePro.jsp?pageNum=<%=pageNum%>" method="post" enctype="multipart/form-data">
			<table border="1">
				<tr>
					<td>글쓴이</td>
					<td>
						<input type="text" name="nickname" value="<%=bbean.getNickname()%>" readonly>
						<input type="hidden" name="num" value="<%=num%>">
					</td>
					<td>조회수</td>
					<td><input type="text" name="readcount" value="<%=bbean.getReadcount()%>" readonly></td>
				</tr>
				<tr>
					<td>글 제목</td>
					<td colspan="4"><input type="text" name="title" value="<%=bbean.getTitle()%>"></td>
				</tr>
				<tr>
					<td>첨부파일</td>
					<td colspan="4"><input type="file" name="file" value="<%=bbean.getFile()%>"></td>
				</tr>
				<tr>
					<td>글 내용</td>
					<td colspan="4"><textarea rows="10" cols="50" name="content"><%=bbean.getContent()%></textarea> </td>
				</tr>

			</table>
			<input type="submit" value="수정하기">
			<input type="button" value="목록으로" onclick="location.href='boardList.jsp'">
		</form>
	</fieldset>
	
	
	
	
	
</body>
</html>