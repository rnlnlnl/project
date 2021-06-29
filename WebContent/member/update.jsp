<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<title>내정보 변경</title>
<%
	String id = (String)session.getAttribute("id");
	String nikename = (String)session.getAttribute("nickname");
	
	MemberDAO mDAO = new MemberDAO();
	MemberBean mbean = new MemberBean();
	
	ArrayList list = mDAO.getMyPage(id);
	mbean = (MemberBean)list.get(0);
%>
<script type="text/javascript">
	
	function update() {
		
		var id = document.fr.id.value;
		var age = document.fr.age.value;
		var tel = document.fr.tel.value;
		
		if (/^[0-9]{1,3}/.test(age) == false) {
			alert("나이는 숫자를 적어주세요");
			document.fr.age.focus();
			return false;
		}
		
		if (/^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}/.test(tel) == false) {
			alert("(-)을 넣어주세요. 전화번호 양식이 맞지 않습니다.");
			document.fr.tel.focus();
			return false;
		}
		
		
	}
	
	//닉네임중복 검사
	function nickCheck(rtn) {
		var nickname = document.fr.nickname.value;
		var rtn = true;
		$.ajax({
			type: "post",
			url: "${pageContext.request.contextPath}/member/nickCheck.jsp",
			data:({
				nickname : document.fr.nickname.value
				
			}),
			success: function (check) {
				console.log("닉네임"+check);
				if(check == 0){
					$("#nickCheck").html("사용 가능한 닉네임입니다.");
					$("#nickCheck").css("color", "green");
				}else if(check == 1){
					$("#nickCheck").html("사용 불가능한 닉네임입니다.");
					$("#nickCheck").css("color", "red");
					rtn = false;
				}
			}
		});	
	}
	
	// 전화번호 중복 검사
	function telCheck() {
		var tel = document.fr.tel.value;
		var rtt = true;
		$.ajax({
			type: "post",
			url: "${pageContext.request.contextPath}/member/telCheck.jsp",
			data : ({
				tel: document.fr.tel.value
			}),
			success: function (tcheck) {
				console.log("뭐냐"+tcheck);
				if(tcheck == 0){
					$("#telCheck").html("사용 가능한 전화번호입니다.");
					$("#telCheck").css("color", "green");
				}else if(tcheck == 1){
					$("#telCheck").html("사용 불가능한 전화번호입니다.");
					$("#telCheck").css("color", "red");
					rtt = false;
				}
			}
		});
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
		<legend>내정보 변경</legend>
		<form action="updatePro.jsp" method="post" name="fr">
			<label>아이디</label>
			<input type="text" name="id" value="<%=mbean.getId()%>" readonly><br>
			
			<label>이름</label>
			<input type="text" name="name" value="<%=mbean.getName()%>" readonly><br>
			
			<label>닉네임</label>
			<input type="text" name="nickname" value="<%=mbean.getNickname()%>" onblur="nickCheck();" required><br>
			<span id="nickCheck"></span><br>
			
			<label>나이</label>
			<input type="text" name="age" value="<%=mbean.getAge()%>" required><br>
			
			<label>이메일</label>
			<input type="text" name="email" value="<%=mbean.getEmail()%>" readonly><br>
			
			<label>주소</label>
			<input type="text" name="addr1" id="addr1" value="<%=mbean.getAddr1()%>" placeholder="우편번호" required readonly="readonly">
			<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
			<input type="text" name="addr2" id="addr2" value="<%=mbean.getAddr2()%>" placeholder="주소" required readonly="readonly"><br>
			<input type="text" name="addr3" id="addr3" value="<%=mbean.getAddr3()%>" placeholder="상세주소" required><br>
			
			<label>전화번호</label>
			<input type="text" name="tel" value="<%=mbean.getTel()%>" onblur="telCheck();" required><br>
			<span id="telCheck"></span><br>
			
			<input type="submit" value="변경하기" onclick="return update();">
			<button><a href="../main.jsp">돌아가기</a></button>
		</form>
		<button><a href="./delete.jsp">회원탈퇴</a></button>
	</fieldset>
	
	
	
	
	
	
	
	
	
	
	
</body>
</html>