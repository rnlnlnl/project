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
	String id = (String)session.getAttribute("id");
%>
	<form action="ideletePro.jsp" method="post">
		<input type="hidden" name="num" value="<%=num%>"><br>
		<%=nickname%>님 판매 글을 <b>삭제</b> 하시겠습니까?<br>
		<input type="submit" value="삭제하기"><br>
	</form>
	<button onclick="location.href='dealBoard.jsp'">목록으로</button>





</body>
</html>