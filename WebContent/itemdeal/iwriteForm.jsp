<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("id");
	String nickname = (String)session.getAttribute("nickname");
	%>
	
	<fieldset>
		<legend>아이템 거래</legend>
		<form action="iwritePro.jsp" method="post" enctype="multipart/form-data">
			<input type="text" name="nickname" value="<%=nickname%>" readonly>
			<table border="1">
				<tr>
					<td>이미지 첨부파일</td>
					<td>설정</td>
				</tr>
				<tr>
					<td rowspan="8"><input type="file" id="file" name="file"> </td>
					<td>제목</td>
				</tr>
				<tr>
					<td><input type="text" id="title" name="title" required></td>
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
					<td><input type="text" name="price" required></td>
				</tr>
				<tr>
					<td>거래 내용</td>
				</tr>
				<tr>
					<td><textarea rows="10" cols="50" name="content"></textarea> </td>
				</tr>
			</table>
			<input type="submit" value="등록하기">
		</form>
	</fieldset>
</body>
</html>