<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<%
	request.setCharacterEncoding("UTF-8");
	
	String nickname = request.getParameter("nickname");
	String pw = request.getParameter("pw");
	
	MemberDAO mDAO = new MemberDAO();
	
	int check = mDAO.deleteMember(nickname,pw); 
	
	if(check == 1){
		session.invalidate();
%>
<script type="text/javascript">
	alert("회원탈퇴 되셨습니다.");
	location.href="../main.jsp";
</script>
<%
	
	}else{
%>
<script type="text/javascript">
	alert("비밀번호가 틀렸습니다.");
	history.back();
</script>
<%
	}
%>

