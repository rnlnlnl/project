<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글쓰기</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("id");
	String nickname = (String)session.getAttribute("nickname");

%>

<fieldset>
<legend>자유게시판 글쓰기</legend>
	<form action="writePro.jsp" method="post" enctype="multipart/form-data">
		<input type="hidden" name="nickname" value="<%=nickname%>">
		<table border="1">
			<tr>
				<td>제목</td>
				<td>첨부파일</td>
			</tr>
			<tr>
				<td><input type="text" id="title" name="title" required></td>
				<td><input type="file" id="file" name="file" ></td>
			</tr>
			<tr>
				<td colspan="2">내용</td>
			</tr>
			<tr>
				<td colspan="2"><textarea rows="10" cols="50" name="content"></textarea></td>
			</tr>
		</table>
		<input type="submit" value="글쓰기">
	</form>
</fieldset>





</body>
</html>