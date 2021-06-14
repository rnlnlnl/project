<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원가입</title>
<script type="text/javascript">
	function fun1() {
		var id = document.fr.id.value;
		var pw = document.fr.pw.value;
		var name = document.fr.name.vlaue;
		var nickname = document.fr.nickname.value;
		var age = document.fr.age.value;
		var gender =  document.fr.gender[0].checked;
		
		
		
		
	}
	
	
</script>
</head>
<body>
	
	
	<fieldset>
		<legend>회원가입</legend>
		<form action="joinPro.jsp" method="post" name="fr" onsubmit="return fun1();">
			<label>아이디</label>
			<input type="text" name="id" id="id" required><br>
			<label>비밀번호</label>
			<input type="password" name="pw" id="pw" required><br>
			<label>비밀번호 확인</label>
			<input type="password" name="pw1" id="pw1" required><br>
			<label>이름</label>
			<input type="text" name="name" id="name" required><br>
			<label>닉네임</label>
			<input type="text" name="nickname" id="nickname" required><br>
			<label>나이</label>
			<input type="text" name="age" id="age" required><br>
			<label>성별</label>
			<input type="radio" name="gender" id="gender" value="남">남
			<input type="radio" name="gender" id="gender" value="여">여<br>
			<label>전화번호</label>
			<input type="text" name="tel" id="tel"><br>
			
			<input type="submit" value="회원가입">
			<input type="reset" value="초기화">
		</form>
	</fieldset>
	
</body>
</html>