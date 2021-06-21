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
<input type="text" id="title" name="title" required><br>
<textarea rows="10" cols="50"></textarea><br>



<input type="submit" value="글쓰기">

</fieldset>





</body>
</html>