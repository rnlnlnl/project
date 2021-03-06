<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
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
		String pageNum = request.getParameter("pageNum");
	%>
	<jsp:useBean id="bbean" class="board.BoardBean"/>
	<jsp:setProperty property="*" name="bbean"/>
	
	<%
		
	int maxSize = 10 * 1024 * 1024; // 100MB
	
	String realPath = request.getRealPath("/upLoadFile");
	
	
	MultipartRequest multi = 
					new MultipartRequest(
							request,
							realPath,
							maxSize,
							"UTF-8",
							new DefaultFileRenamePolicy()
							);
	
	bbean.setNum(Integer.parseInt(multi.getParameter("num")));
	bbean.setNickname(multi.getParameter("nickname"));
	bbean.setTitle(multi.getParameter("title"));
	bbean.setFile(multi.getFilesystemName("file"));
	bbean.setContent(multi.getParameter("content"));
	bbean.setReadcount(Integer.parseInt(multi.getParameter("readcount")));
	// ip주소 추가
	bbean.setIp(request.getRemoteAddr());
		
		BoardDAO bDAO = new BoardDAO();
		
		int check = bDAO.updateBoard(bbean);
		
		if(check == 1){
	%>
		<script type="text/javascript">
				alert("글정보를 수정했습니다.");
				location.href = "boardList.jsp?pageNum=<%=pageNum%>";
		</script>
	<%
		}else if(check == 0){
	%>
		<script type="text/javascript">
			alert("잘못된 접근입니다!");
			history.back();
		</script>
	<%
		}else{
	%>
		<script type="text/javascript">
			alert("해당 글 없음!");
			history.back();
		</script>
	<%
		}
	%>
</body>
</html>