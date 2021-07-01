<%@page import="java.util.ArrayList"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="../js/jquery-3.6.0.min.js"></script>
<%
	request.setCharacterEncoding("UTF-8");
	
	String id = (String)session.getAttribute("id");
	String nickname = (String)session.getAttribute("nickname");
%>
<jsp:useBean id="bbean" class="board.BoardBean"/>
<jsp:setProperty property="*" name="bbean"/>
<%

	BoardDAO bDAO = new BoardDAO();
	
	int cnt = bDAO.getBoardCount();
	
	
	
	
	//페이징 처리
	
	// 한 페이지에 출력할 글의 개수
	int pageSize = 10;
	
	// 현재 페이지의 위치정보
	// list.jsp로올때 pageNum값을 안가지고 와서 pageNum은 null이다
	// int로 사용하면 인티저로 변환을 계속 해줘야한다
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null){
		pageNum = "1";
	}
	
	// 시작행 계산 1...11...21...31...
	// 계산을 위해 Integer바꿔준다
	int currentpage = Integer.parseInt(pageNum);
	int startRow = (currentpage-1)*pageSize+1;
	//	(1-1)*10+1=1
	
	// 끝행 번호 계산 10...20...30...40...
	int endRow = currentpage*pageSize;
	
	// 저장된 모든 글의 정보를 가져오는 멕서드 생성
	ArrayList boardList = bDAO.getBoardList(startRow, pageSize);
	
%>


</head>
<body>
	
	
	
	<table>
		<tr>
			<td></td>
			<td>제목</td>
			<td>작성자</td>
			<td>작성일</td>
			<td>조회</td>
			<td>좋아요</td>
		</tr>
		
		
		
	</table>
	
	
	
	
</body>
</html>