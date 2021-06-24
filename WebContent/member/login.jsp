<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>로그인 페이지</title>
</head>
<body>
	
	<a href="../main.jsp"><img alt="gameItem" src="../image/logo.jpg"></a>
	
	<fieldset>
	  <legend>로그인</legend>
		<form action="loginPro.jsp" method="post">
			
			<input type="text" name="id" placeholder="아이디" required><br>
			
			<input type="password" name="pw" placeholder="비밀번호" required><br>
			
			<input type="submit" value="로그인">
		</form>
	</fieldset>
	
	
</body>
</html>