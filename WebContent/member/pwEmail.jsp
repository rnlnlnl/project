<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="../js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	function checkAuthNum() {
		var checkNum = document.getElementById("authNum").value;
		var certNum = ${certNum};
		if (!checkNum) {
			alert("인증번호를 입력하세요");
		}else{
			if (checkNum == certNum) {
				alert("성공적으로 인증 되었습니다.");
				opener.document.getElementById("email").readOnly = true;
				$("#emailCheck",parent.opener.document).text("이메일 인증이 완료되었습니다.");
				opener.document.getElementById("certBtn").disabled = true;
				window.open('','_self').close();
			}else{
				alert("인증번호가 잘못되었습니다.");
				return false;
			}
		}
	}
	
</script>



<title>Insert title here</title>
</head>
<body>
	<h1>메일 인증</h1>
	<c:if test="${result == true}">
		<b>${param.email}로 인증 메일을 발송했습니다.</b>
		
		<label>인증번호를 입력해주세요</label>
		<input type="text" id="authNum" name="authNum"><br>
		
		<button type="button" onclick="checkAuthNum()">인증번호 확인하기</button>
	</c:if>
	<c:if test="${result != true}">
		인증 메일 전송 실패
	</c:if>
	인증번호 : ${certNum}
	
</body>
</html>