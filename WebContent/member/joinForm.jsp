<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원가입</title>
</head>
<body>
	
	
	<fieldset>
		<legend>회원가입</legend>
		<form action="joinPro.jsp" method="post" onsubmit="return fun1();">
			<label>아이디</label>
			<input type="text" name="id" id="id" required>
			<label>비밀번호</label>
			<input type="password" name="pw" id="pw" required>
			<label>비밀번호 확인</label>
			<input type="password" name="pw1" id="pw1" required>
			<label>이름</label>
			<input type="text" name="name" id="name" required>
			<label>닉네임</label>
			<input type="text" name="nickname" id="nickname" required>
			<label></label>
			<input type="text" >
		</form>
	</fieldset>
	
</body>
</html>