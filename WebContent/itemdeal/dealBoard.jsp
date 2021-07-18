<%@page import="item.ItemBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="item.ItemDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="../js/jquery-3.6.0.min.js"></script>
<title>거래소</title>

<%
	request.setCharacterEncoding("UTF-8");
	
	String id = (String)session.getAttribute("id");
	String nickname = (String)session.getAttribute("nickname");

%>

<jsp:useBean id="ibean" class="item.ItemBean"/>
<jsp:setProperty property="*" name="ibean"/>

<script type="text/javascript">
	function writeb() {
		var nickname = $("#nickname").val();
		if(nickname == "null"){
			location.href="../member/login.jsp";
		}else if(nickname != null){
			location.href="iwriteForm.jsp";
		}
	}
	
	if(id == "null"){
		document.getElementById("adminCheck").hidden();
	}else if (id != "admin") {
		document.getElementById("adminCheck").hidden();
	}else{
		document.getElementById("adminCheck").disabled="";
	}
	
	if(id == "null"){
		document.getElementById("adminCheck1").hidden();
	}else if (id != "admin") {
		document.getElementById("adminCheck1").hidden();
	}else{
		document.getElementById("adminCheck1").disabled="";
	}
	
	function acheck() {
		var acheck = $("#itemSucces").val();
		
		$.ajax({
			type="post",
			url: "./itemdeal/acheck.jsp",
			data: ({$("#itemSucces").val()
			)},
			success: function (achecked) {
				if(achecked == true){
					$("#itemSucces").checked;
				}else if(achecked == false){
					$("#itemSucces").checked.false;
				}
			}
		});
	}
	
	
</script>
	

<%
	ItemDAO iDAO = new ItemDAO();

	int cnt = iDAO.getitemCount();
	
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
	
	// 끝행 번호 계산 10...20...30...40...
	int endRow = currentpage*pageSize;
	
	// 저장된 모든 글의 정보를 가져오는 멕서드 생성
	ArrayList itemList = iDAO.getItemList(startRow, pageSize);
	
%>

</head>
<body>
	
	<button name="write" id="write" onclick="writeb();">글쓰기</button>
	<input type="hidden" id="nickname" value="<%=nickname%>">
	<table>
		<tr>
			<td>게임 이름</td>
			<td>제목</td>
			<td>작성자</td>
			<td>작성일</td>
			<td>등급</td>
			<td id="adminCheck">관리자 거래물품 확인</td>
			
		</tr>
	<%
		if(cnt != 0){
			for(int i = 0; i<itemList.size(); i++){
				ibean = (ItemBean)itemList.get(i);
	%>	
		<tr>
			<td><%=ibean.getGname()%></td>
			<td>
				<a href="itemcontent.jsp?num=<%=ibean.getNum()%>&pageNum=<%=pageNum%>"><%=ibean.getTitle()%></a>
			</td>
			<td><%=ibean.getNickname()%></td>
			<td><%=ibean.getDate()%></td>
			<td><%=ibean.getReadcount()%></td>
			<td id="adminCheck1"><input type="checkbox" name="itemSucces" id="itemSucces" value="yes" onclick="acheck();">아이템 받음</td>
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
				<a href="dealBoard.jsp?pageNum=<%=startPage-pageBlock%>">[이전]</a>
			<%
		}
		// [1...10] [11...20] [21...30] ...
		for(int i =startPage; i<=endPage; i++){
			%>
				<a href="dealBoard.jsp?pageNum=<%=i%>">[<%=i%>]</a>
			<%
		}
		if(endPage < pageCount){
			%>
				<a href="dealBoard.jsp?pageNum=<%=startPage+pageBlock%>">[다음]</a>
			<%
		}
	
	}

%>	

</body>
</html>