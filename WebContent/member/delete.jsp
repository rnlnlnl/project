<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원 탈퇴</title>
</head>
<body>
	<%
		String id = (String)session.getAttribute("id");
		String nickname = (String)session.getAttribute("nickname");
	%>	
	
	<%=nickname%>님 정말 회원탈퇴 하시겠습니까?
	
	<form action="deletePro.jsp" method="post">
		<input type="hidden" name="nickname" value="<%=nickname%>">
		<input type="password" name="pw" placeholder="비밀번호를 적어주세요.">
		
		<input type="submit" value="탈퇴하기">
	</form>
	
	<button onclick="history.back();">다시한번 생각해볼께요.</button>
	
</body>
</html>