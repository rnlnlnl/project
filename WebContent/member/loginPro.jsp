<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>loginPro</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	
	MemberDAO memberdao = new MemberDAO();
	
	int check = memberdao.userCheck(id, pw);
	String nickname = memberdao.nickname(id, pw);
	
	if(check == 1){
		//login.jsp에서 입력한 아이디값을 session내장객체 영역에 저장
		session.setAttribute("id", id);
		session.setAttribute("nickname", nickname);
		response.sendRedirect("../main.jsp");
	}else if(check == 0){
	%>
		<script type="text/javascript">
			alert("아이디 또는 비밀번호가 틀렸습니다.");
			history.back();
		</script>
	<%
	}else{
		%>
		<script type="text/javascript">
			alert("아이디 또는 비밀번호가 틀렸습니다.");
			history.back();
		</script>
	<%

	} 
	
/* 	MemberBean b = new MemberBean();
	System.out.println(b);
	b.setId(request.getParameter("id"));
	
	System.out.println(b); */ 
	
	

%>
<jsp:useBean id="memberbean" class="member.MemberBean"/>
<jsp:setProperty property="*" name="memberbean"/>
	
</body>
</html>