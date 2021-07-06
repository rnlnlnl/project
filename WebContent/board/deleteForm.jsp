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
%> 
	
	<form action="deletePro.jsp" method="post">
		<input type="hidden" name="num" value="<%=num%>"><br>
		<%=nickname%>님 정말 글을 삭제 하시겠습니까?<br>
		<input type="submit" value="삭제하기"><br>
	</form>
	<button onclick="location.href='boardList.jsp'">목록으로</button>
	
	
	
</body>
</html>