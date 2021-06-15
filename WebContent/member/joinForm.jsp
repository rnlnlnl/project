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
		var idl = document.fr.id.value.length;
		var pw = document.fr.pw.value;
		var pw0 = document.fr.pw.value.length;
		var pw1 = document.fr.pw1.value;
		var name = document.fr.name.value;
		var nickname= document.fr.nickname.value.length;
		var age = document.fr.age.value;
		var gender = document.fr.gender[0].checked;
		var gender1 = document.fr.gender[1].checked;	
/*		var email = document.fr.email.value;
 		var addr1 = document.fr.addr1.value;
		var addr2 = document.fr.addr2.value;
		var addr3 = document.fr.addr3.value; */
		var tel = document.fr.tel.value;
//		alert("시발");
		
		
		if (idl < 5 || idl >= 13 ) {
			alert("아이디는 6~13자리 사이로 만들어주세요.");
			document.fr.id.focus();
			return false;
		}
		
		if (pw0 < 7 || pw0 > 17 ) {
			alert("비밀번호는 8~16자리 사이로 만들어주세요.");
			document.fr.pw.focus();
			return false;
		}
		
 		if (pw != pw1) {
			alert("비밀번호가 동일하지 않습니다.");
			document.fr.pw1.focus();
			return false;
		} 
		
		if(nickname > 15){
			alert("별명은 14자 이하로 작성해주세요.");
			document.fr.nickname.focus();
			return false;
		}
		
		if (/^[0-9]{1,3}/.test(age) == false) {
			alert("숫자를 적어주세요");
			document.fr.age.focus();
			return false;
		}
		
		if (gender == false && gender1 == false) {
			alert("성별을 체크해주세요.");
			return false;
		}
		
		if (/^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}/.test(tel) == false) {
			alert("(-)을 넣어주세요. 전화번호 양식이 맞지 않습니다.");
			document.fr.tel.focus();
			return false;
		}
		
		
		
		
		
		
		
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
			<input type="text" name="tel" id="tel" placeholder="(-)을 넣어주세요. " required><br>
			
			<input type="submit" value="회원가입">
			<input type="reset" value="초기화">
		</form>
	</fieldset>
	
</body>
</html>