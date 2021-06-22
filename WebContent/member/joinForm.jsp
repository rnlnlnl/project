<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원가입</title>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript">

	/* 
		Ajax는 해당 페이지에 있는 값 자체를 가지고 오는 거라서 페이지를 비워주고 값만 나타나게 해줘야 한다
		숫자를 가지고 오려면 datatype을 "text"로 하면 안된다
	*/
 	function idChecked() {
		
		var id = $("#id").val();
		
 		$.ajax({
			type: "post",
			url: "${pageContext.request.contextPath}/member/idCheck.jsp",
			data: ({
				id: $("#id").val()
			}),
			
			success: function (result) { 
				console.log("뭐냐"+result);
				if (result == 0) {
					$("#idCheck").html("사용가능한 아이디입니다.");
					$("#idCheck").css("color", "green");
	                
				}else if(result == 1){
					$("#idCheck").html("이미 사용중인 아이디입니다.");
					$("#idCheck").css("color", "red"); 
		            
				}
			}
		});  
 	}
	
	function nickCheck() {
		var nickname = $("#nickname").val();
		
		$.ajax({
			type: "post",
			url: "${pageContext.request.contextPath}/member/nickCheck.jsp",
			data : ({
				nickname: $("#nickname").val()
			}),
			success: function(check) {
				if (check == 0) {
					$("#nickCheck").html("사용가능한 닉네임입니다.");
					$("#nickCheck").css("color", "green");
	                
				}else if(check == 1){
					$("#nickCheck").html("이미 사용중인 닉네임입니다.");
					$("#nickCheck").css("color", "red"); 
		            
				}
			}
			
		});
		
		
	}
	
	
	
	
	
	
	function checkpw() {
		var pw = $("#pw").val();
		var pw1 = $("#pw1").val();
		
		
		if (pw != pw1 ) {
			$("#passCheck").html("비밀번호가 일치하지 않습니다.").css("color","red");
		}else{
			$("#passCheck").html("비밀번호가 동일합니다.").css("color","green");
		}
		
	}
	
	
	
	
	
	function join() {
		
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
		var email = document.fr.email.value;
 		var addr1 = document.fr.addr1.value;
		var addr2 = document.fr.addr2.value;
		var addr3 = document.fr.addr3.value; 
		var tel = document.fr.tel.value;

		
		
		if (idl < 5 || idl >= 13 ) {
			alert("아이디는 5~13자리 사이로 만들어주세요.");
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
			alert("나이는 숫자를 적어주세요");
			document.fr.age.focus();
			return false;
		}
		
		if (gender == false && gender1 == false) {
			alert("성별을 체크해주세요.");
			return false;
		}
		
		
		
		if(/^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/.test(email) == false){
			alert("이메일의 양식이 맞지 않습니다.");
			document.fr.email.focus();
			return false;
		}
		
		if(addr1 == ""){
			alert("주소를 적어주세요");
			return false;
		}
		
		if(addr2 == ""){
			alert("주소를 적어주세요");
			return false;
		}
		
		if(addr3 == ""){
			alert("주소를 적어주세요");
			return false;
		}
		
		if (/^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}/.test(tel) == false) {
			alert("(-)을 넣어주세요. 전화번호 양식이 맞지 않습니다.");
			document.fr.tel.focus();
			return false;
		}

		
	}
	
	 function sample6_execDaumPostcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var addr = ''; // 주소 변수
	                var extraAddr = ''; // 참고항목 변수

	                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    addr = data.roadAddress;
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    addr = data.jibunAddress;
	                }

	                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	                if(data.userSelectedType === 'R'){
	                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있고, 공동주택일 경우 추가한다.
	                    if(data.buildingName !== '' && data.apartment === 'Y'){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                    if(extraAddr !== ''){
	                        extraAddr = ' (' + extraAddr + ')';
	                    }
	                    // 조합된 참고항목을 해당 필드에 넣는다.
	                    //document.getElementById("sample6_extraAddress").value = extraAddr;
	                
	                } /* else {
	                    document.getElementById("sample6_extraAddress").value = '';
	                } */

	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('addr1').value = data.zonecode;
	                document.getElementById("addr2").value = addr;
	                // 커서를 상세주소 필드로 이동한다.
	                document.getElementById("addr3").focus();
	            }
	        }).open();
	    }
	
	
	
	
</script>
</head>
<body>
	
	<fieldset>
		<legend>회원가입</legend>
		<form action="joinPro.jsp" method="post" name="fr">
		  <div>	
			<label>아이디</label>
			<input type="text" name="id" id="id" onblur="idChecked();" required>
			<span id="idCheck"></span><br>
		  </div>
		  
			<label>비밀번호</label>
			<input type="password" name="pw" id="pw" required><br>
			<label>비밀번호 확인</label>
			<input type="password" name="pw1" id="pw1" onblur="checkpw();" required>
			<span id="passCheck"></span><br>
			
			<label>이름</label>
			<input type="text" name="name" id="name" required><br>
			
			<label>닉네임</label>
			<input type="text" name="nickname" id="nickname" onblur="nickCheck();" required>
			<span id="nickCheck"></span><br>
			
			<label>나이</label>
			<input type="text" name="age" id="age" required><br>
			
			<label>성별</label>
			<input type="radio" name="gender" id="gender" value="남">남
			<input type="radio" name="gender" id="gender" value="여">여<br>
			
			<label>이메일</label>
			<input type="email" name="email" id="email" required><br>
			
			<input type="text" name="addr1" id="addr1" placeholder="우편번호" required readonly="readonly">
			<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
			<input type="text" name="addr2" id="addr2" placeholder="주소" required readonly="readonly"><br>
			<input type="text" name="addr3" id="addr3" placeholder="상세주소" required><br>
			<!-- <input type="hidden" id="sample6_extraAddress" placeholder="참고항목"> -->
			
			<label>전화번호</label>
			<input type="text" name="tel" id="tel" placeholder="(-)을 넣어주세요. " required><br>
			
			<input type="submit" value="회원가입" onclick="join()">
			<input type="reset" value="초기화">
		</form>
	</fieldset>
	
</body>
</html>