<%@page import="java.util.ArrayList"%>
<%@page import="itemboard.ReviewDAO"%>
<%@page import="itemboard.ReviewBean"%>
<%@page import="item.ItemBean"%>
<%@page import="item.ItemDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="../headfoot/head.jsp"/>
<title>Insert title here</title>

</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
		
		String id = (String)session.getAttribute("id");
		String nickname = (String)session.getAttribute("nickname");
		int num = Integer.parseInt(request.getParameter("num"));
		String pageNum = request.getParameter("pageNum");
		
		ItemDAO iDAO = new ItemDAO();
		
		int memberShip = iDAO.updateMemberShip(nickname);
		
		ItemBean ibean = iDAO.getBoard(num);
		String imgFile = ibean.getFile();
		
	%>
	
	<h3><%=ibean.getTitle()%></h3>
	
	<table border="1">
		<tr>
			<td>판매 물품</td>
			<td>작성자</td>
		</tr>
		<tr>
			<td rowspan="9"><img alt="판매물품" src="../upItemFile/<%=ibean.getFile()%>" width="450" height="550"> </td>
			<td><%=ibean.getNickname()%>님</td>
		</tr>
		<tr>	
			<td>등급</td>
		</tr>
		<tr>
			<td>
				<%
					if(memberShip >= 0 && memberShip <= 100000){
					%>
						<img alt="브론즈" src="../image/브론즈.png" width="30" height="30">
					<%	
					}else if(memberShip > 100000 && memberShip <= 500000){
					%>
						<img alt="실버" src="../image/실버.png" width="30" height="30">
					<%
					}else if(memberShip > 500000 && memberShip <= 2000000){
					%>
						<img alt="골드" src="../image/골드.png" width="30" height="30">
					<%
					}else if(memberShip >= 10000000){
					%>
						<img alt="다이아" src="../image/다이아.png" width="30" height="30">
					<%
					}
				%>
			</td>
		</tr>
		<tr>
			<td>가격</td>
		</tr>
		<tr>
			<td><%=ibean.getPrice() %></td>
		</tr>
		<tr>
			<td>작성일</td>
		</tr>
		<tr>
			<td><%=ibean.getDate()%></td>
		</tr>
		<tr>
			<td>내용</td>
		</tr>
		<tr>
			<td><%=ibean.getContent() %></td>
		</tr>
		<tr>
		<%
			if(nickname != null){
		%>
				<td colspan="2"><button type="button">구매하기</button></td>
		<%
			}
		%>
		</tr>
		<tr>
			<td>
			<%
				if(nickname !=null && nickname.equals(ibean.getNickname())){
			%>
				<input type="button" value="수정하기" onclick="location.href='iupdateForm.jsp?num=<%=ibean.getNum()%>&pageNum=<%=pageNum%>';">
				<input type="button" value="삭제하기" onclick="location.href='ideleteForm.jsp?num=<%=ibean.getNum()%>&pageNum=<%=pageNum%>';"><br>
			<%
				}
			%>
			<%
				if(nickname != null){
			%>
				<input type="button" value="리뷰쓰기" onclick="location.href='ireWriteForm.jsp?num=<%=ibean.getNum()%>&re_ref=<%=ibean.getRe_ref()%>&re_lev=<%=ibean.getRe_lev()%>&re_seq=<%=ibean.getRe_seq()%>';">
			<%		
				}
			%>
				<input type="button" value="목록으로" onclick="location.href='dealBoard.jsp'">
			</td>
		</tr>
	</table>
	
	<hr>
	
	<%
		ReviewDAO rDAO = new ReviewDAO();
		ArrayList rbean = rDAO.getReview(num);
		int rcnt = rDAO.getReviewCount();
		
	%>
	<jsp:useBean id="rebean" class="itemboard.ReviewBean"/>
	<jsp:setProperty property="*" name="rebean"/>
	
	<table border="1">
		<tr>
			<td colspan="2"><h3>댓글</h3></td>
		</tr>
	<%
		if(rcnt != 0){
			for(int j = 0; j<rbean.size(); j++){
				rebean = (ReviewBean)rbean.get(j);
	%>
		<tr>
			<td><%=rebean.getTitle() %></td>
			<td><%=rebean.getContent()%></td>
		</tr>
	<%
			}
		}
	%>
	</table>
	
	
	
	
	
	
	
	
</body>
</html>