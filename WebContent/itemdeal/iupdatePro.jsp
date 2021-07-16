<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="item.ItemDAO"%>
<%@page import="item.ItemBean"%>
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
		<jsp:useBean id="ibean" class="item.ItemBean"/>
		<jsp:setProperty property="*" name="ibean"/>
	<%	
		
	int maxSize = 10 * 1024 * 1024; // 100MB
	
	String realPath = request.getRealPath("/upItemFile");
	
	
	MultipartRequest multi = 
					new MultipartRequest(
							request,
							realPath,
							maxSize,
							"UTF-8",
							new DefaultFileRenamePolicy()
							);
	
	ibean.setNum(Integer.parseInt(multi.getParameter("num")));
	ibean.setNickname(multi.getParameter("nickname"));
	ibean.setTitle(multi.getParameter("title"));
	ibean.setFile(multi.getFilesystemName("file"));
	ibean.setGname(multi.getParameter("gname"));
	ibean.setContent(multi.getParameter("content"));
	ibean.setPrice(Integer.parseInt(multi.getParameter("price")));
	// ip주소 추가
	ibean.setIp(request.getRemoteAddr());
		
		ItemDAO iDAO = new ItemDAO();
		
		int check = iDAO.iupdateBoard(ibean);
		
		if(check == 1){
	%>
		<script type="text/javascript">
				alert("글정보를 수정했습니다.");
				location.href = "dealBoard.jsp?pageNum=<%=pageNum%>";
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