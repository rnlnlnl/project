<%@page import="item.ItemBean"%>
<%@page import="item.ItemDAO"%>
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
	String id = (String)session.getAttribute("id");
	
	ItemDAO iDAO = new ItemDAO();
	ItemBean ibean = iDAO.getBoard(num);
	
%>
	<fieldset>
		<form action="iupdatePro.jsp?pageNum=<%=pageNum%>" method="post" enctype="multipart/form-data">
			<input type="text" name="nickname" value="<%=nickname%>" readonly>
			<input type="hidden" name="num" value="<%=num%>">
			<table border="1">
				<tr>
					<td>이미지 첨부파일</td>
					<td>설정</td>
				</tr>
				<tr>
					<td rowspan="8"><input type="file" id="file" name="file" value="<%=ibean.getFile()%>"> </td>
					<td>제목</td>
				</tr>
				<tr>
					<td><input type="text" id="title" name="title" value="<%=ibean.getTitle() %>" required></td>
				</tr>
				<tr>
					<td>게임 이름</td>
				</tr>
				<tr>
					<td>
						<select name="gname">
							<option value="메이플스토리">메이플스토리</option>
							<option value="배틀그라운드">배틀그라운드</option>
							<option value="리그오브레전드">리그오브레전드</option>
							<option value="리니지">리니지</option>
							<option value="블래이드&소울">블래이드&소울</option>
							<option value="아이온">아이온</option>
							<option value="기타">기타</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>가격</td>
				</tr>
				<tr>
					<td><input type="text" name="price" value="<%=ibean.getPrice() %>" required></td>
				</tr>
				<tr>
					<td>거래 내용</td>
				</tr>
				<tr>
					<td><textarea rows="10" cols="50" name="content" required><%=ibean.getContent()%></textarea></td>
				</tr>
			</table>
			<input type="submit" value="수정하기">
			<input type="button" value="목록으로" onclick="location.href='dealBoard.jsp'">
		</form>
	</fieldset>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
</body>
</html>