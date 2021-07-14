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
		request.setCharacterEncoding("UTF-8");
		
		String id = (String)session.getAttribute("id");
		String nickname = (String)session.getAttribute("nickname");
		int num = Integer.parseInt(request.getParameter("num"));
		String pageNum = request.getParameter("pageNum");
		
		BoardDAO bDAO = new BoardDAO();
		
		// 글 조회수를 1증가 - updateReadcount();
		bDAO.updateReadcount(num);
		
		BoardBean bbean = bDAO.getBoard(num);
		String imgFile = bbean.getFile();
				
	%>
	
	<h3><%=bbean.getNickname()%>의 글</h3>
	
	<table border="1">
		<tr>
			<td>글번호</td>
			<td><%=bbean.getNum()%></td>
			<td>조회수</td>
			<td><%=bbean.getReadcount()%></td>
			<td>작성일</td>
			<td><%=bbean.getDate()%></td>
		</tr>
		<tr>
			<td>글 제목</td>
			<td colspan="5"><%=bbean.getTitle()%></td>
		</tr>
		<tr>
			<td>첨부파일</td>
			<td colspan="5"><%=bbean.getFile()%></td>
		</tr>
		<tr>
			<td>첨부파일 </td>
			<td>
				<%if(imgFile != null){%>
					<%if(imgFile.substring(imgFile.length()-3, imgFile.length()).equals("jpg") || imgFile.substring(imgFile.length()-3, imgFile.length()).equals("png") || imgFile.substring(imgFile.length()-3, imgFile.length()).equals("gif")){ %>
						<img src="../upLoadFile/<%=bbean.getFile()%>" width="200" height="250">
					<%}else{ %>
						<a href="filedown.jsp?file_name=<%=bbean.getFile()%>"><%=bbean.getFile()%></a>
					<%} %>
				<%} if(imgFile == null){ %>
					<b>파일이 없습니다.</b>
				<%}%>
			</td>
		</tr>
		<tr>
			<td>글 내용</td>
			<td colspan="5"><%=bbean.getContent()%></td>
		</tr>
		<tr>
			<td colspan="5">
<%				
				if(nickname.equals(bbean.getNickname())){
%>
					<input type="button" value="수정하기" onclick="location.href='updateForm.jsp?num=<%=bbean.getNum()%>&pageNum=<%=pageNum%>';">
					<input type="button" value="삭제하기" onclick="location.href='deleteForm.jsp?num=<%=bbean.getNum()%>&pageNum=<%=pageNum%>';">
<%					
				}
%>				
<%				
				if(nickname != null){
%>
					<input type="button" value="답글쓰기" onclick="location.href='reWriteForm.jsp?num=<%=bbean.getNum()%>&re_ref=<%=bbean.getRe_ref()%>&re_lev=<%=bbean.getRe_lev()%>&re_seq=<%=bbean.getRe_seq()%>';">
<%					
				}
%>
				<input type="button" value="목록으로" onclick="location.href='boardList.jsp'">
			</td>
		</tr>
		
	</table>
	
	
	
	
	
</body>
</html>