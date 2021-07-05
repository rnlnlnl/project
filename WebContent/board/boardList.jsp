<%@page import="board.BoardBean"%>
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
	<h5>글 갯수[<%=cnt%>]</h5>
	
	
	<table>
		<tr>
			<td></td>
			<td>제목</td>
			<td>작성자</td>
			<td>작성일</td>
			<td>조회</td>
			<td>좋아요</td>
		</tr>
		
<% 
		if(cnt != 0){
			for(int i = 0; i<boardList.size(); i++){
				bbean = (BoardBean)boardList.get(i);
%>				
				<tr>
					<td><%=bbean.getNum()%></td>
					<td>
					<%
					int wid = 0;
					if(bbean.getRe_lev() > 0){
						wid = 10 * bbean.getRe_lev();
						%>
						<img src="../image/level.gif" height="15" width="<%=wid%>">
						<img src="../image/re.gif">
					<%}%>
					<a href="content.jsp?num=<%=bbean.getNum()%>&pageNum=<%=pageNum%>"><%=bbean.getTitle()%></a>
					</td>
					<td><%=bbean.getContent()%></td>
					<td><%=bbean.getDate() %></td>
					<td><%=bbean.getReadcount() %></td>
					<td></td>
				</tr>
<%				
			}
		}
		
		
		
%>		
	</table>
	
	<hr>
	
<%
	////////////////////////////////////////////////
	// 페이징 처리
	if(cnt>0){
		// 한 페이지에서 보여줄 페이지 번호의 개수
		int pageBlock = 5;
		// 전체 페이지 갯수  => 전체글 / 페이지 크기
		int pageCount = cnt / pageSize + (cnt % pageSize == 0? 0 : 1);
		// 페이지 블럭 시작번호 계산  1 ~ 10 => 1, 11~20 => 11, 21~30 => 21
		int startPage = ((currentpage-1)/pageBlock)*pageBlock+1;
		// 페이지 블럭 끝번호 계산
		int endPage = startPage + pageBlock -1;
		// 끝 페이지 번호를 계산
		if(endPage > pageCount){
			endPage = pageCount;
		}
		
		//[이전]
		if(startPage > pageBlock){
			%>
			<a href="boardList.jsp?pageNum=<%=startPage-pageBlock%>">[이전]</a>
			<%
		}
		// [1...10] [11...20] [21...30] ...
		for(int i =startPage; i<=endPage; i++){
			%>
			<a href="boardList.jsp?pageNum=<%=i%>">[<%=i%>]</a>
			<%
		}
		if(endPage < pageCount){
			%>
			<a href="boardList.jsp?pageNum=<%=startPage+pageBlock%>">[다음]</a>
			<%
		}
		
	}
	
%>	

</body>
</html>