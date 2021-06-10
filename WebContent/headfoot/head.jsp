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
	String id = (String)session.getAttribute("id");
	String nickname = (String)session.getAttribute("nickname");
	
	if(id == null){
	%>
		<a href="./member/login.jsp">로그인</a>
		<a href="./member/join.jsp">회원가입</a>
	<%
	}else if(id.equals("admin")){
	%>
		<a href="./member/admin.jsp">택배 관리</a>
	<%
	}else{
	%>
		<%=nickname%>님 환영합니다.
		<a href="./member/update.jsp">내정보 수정</a>
		<a href="./member/logout.jsp">로그아웃</a>
	<%
	}
	
	
%>






</body>
</html>