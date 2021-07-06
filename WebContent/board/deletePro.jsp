<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	
<%
	request.setCharacterEncoding("UTF-8");

	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	String nickname = (String)session.getAttribute("nickname");
	
	BoardDAO bDAO = new BoardDAO();
	int check = bDAO.deleteBoard(nickname,num);
	
	if(check == 1){
		%>
		<script type="text/javascript">
			alert("삭제완료");
			location.href="boardList.jsp";
		</script>
		<%
	}else if(check == 0){
		%>
		<script type="text/javascript">
			alert("본 작성자가 아닙니다.");
			history.back();
		</script>
		<%
	}else{
		%>
		<script type="text/javascript">
			alert("글 없음");
			history.back();
		</script>
		<%
	}
%>
	
	
	
</body>
</html>