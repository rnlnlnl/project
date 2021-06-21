<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>이미지 게시판</title>
</head>
<body>
<jsp:include page="../headfoot/head.jsp"/>
<%	
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("id");
	String nickname = (String)session.getAttribute("nickname");
	if(id != null){
		
%>		
	<a href="./board/write.jsp">글쓰기</a>
<%	
	}
%>	
	
	
	
	
	
	
	
	
	
</body>
</html>