<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("id");
	String nickname = (String)session.getAttribute("nickname");
	
	if(id == null){
	%>
		<a href="./member/login.jsp">로그인</a>
		<a href="./member/join.jsp">회원가입</a>
	<%
	}else if(id.equals("admin")){
	%>
		<a href="./member/admin.jsp">택배 관리</a>
	<%
	}else{
	%>
		<%=nickname%>님 환영합니다.
		<a href="./member/update.jsp">내정보 수정</a>
		<a href="./member/logout.jsp">로그아웃</a>
	<%
	}
%>


<nav class="navbar navbar-expand-sm bg-secondary navbar-dark">
  <ul class="navbar-nav">
    <li class="nav-item active">
      <a href="./board/deal.jsp" class="nav-link">거래소</a>
    </li>
    <li class="nav-item">
      <a href="./board/boardList.jsp" class="nav-link">이미지 계시판</a>
    </li>
    <li class="nav-item">
      <a href="./board/notice.jsp" class="nav-link">공지사항</a>
    </li>
  </ul>
</nav>




</body>
</html>