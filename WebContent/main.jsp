<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
 <style>
      html,
      body {
        position: relative;
        height: 100%;
      }

      body {
        background: #eee;
        font-family: Helvetica Neue, Helvetica, Arial, sans-serif;
        font-size: 14px;
        color: #000;
        margin: 0;
        padding: 0;
      }

      .swiper-container {
        width: 100%;
        height: 100%;
      }

      .swiper-slide {
        text-align: center;
        font-size: 18px;
        background: #fff;

        /* Center slide text vertically */
        display: -webkit-box;
        display: -ms-flexbox;
        display: -webkit-flex;
        display: flex;
        -webkit-box-pack: center;
        -ms-flex-pack: center;
        -webkit-justify-content: center;
        justify-content: center;
        -webkit-box-align: center;
        -ms-flex-align: center;
        -webkit-align-items: center;
        align-items: center;
      }

      .swiper-slide img {
        display: block;
        width: 100%;
        height: 100%;
        object-fit: cover;
      }
    </style>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
  <link
      rel="stylesheet"
      href="https://unpkg.com/swiper/swiper-bundle.min.css"
    />
<title>아이템 거래소</title>
</head>
<body>
<a href="main.jsp"><img alt="gameItem" src="./image/logo.jpg"></a><br>
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
		<a href="./itemdeal/dealBoard.jsp">택배 관리</a>
		<a href="./member/logout.jsp">로그아웃</a>
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
      <a href="./itemdeal/dealBoard.jsp" class="nav-link">거래소</a>
    </li>
    <li class="nav-item">
      <a href="./board/boardList.jsp" class="nav-link">이미지 계시판</a>
    </li>
    <li class="nav-item">
      <a href="./board/notice.jsp" class="nav-link">공지사항</a>
    </li>
  </ul>
</nav>


<div>
	<h2>아이템 거래소에 오신걸 환영합니다.</h2>
</div>
 <div class="swiper-container mySwiper">
      <div class="swiper-wrapper">
        <div class="swiper-slide"><img src="./image/image1.jpg"> </div>
        <div class="swiper-slide"><img src="./image/image2.jpg"></div>
        <div class="swiper-slide"><img src="./image/image3.jpg"></div>
        <div class="swiper-slide"><img src="./image/image4.jpg"></div>
        <div class="swiper-slide"><img src="./image/image5.jpg"></div>
        <div class="swiper-slide"><img src="./image/image6.jpg"></div>
        <div class="swiper-slide"><img src="./image/image7.jpg"></div>
        <div class="swiper-slide"><img src="./image/image8.jpg"></div>
        <div class="swiper-slide"><img src="./image/image9.jpg"></div>
      </div>
      <div class="swiper-button-next"></div>
      <div class="swiper-button-prev"></div>
    </div>
 <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>

    <!-- Initialize Swiper -->
    <script>
      var swiper = new Swiper(".mySwiper", {
        navigation: {
          nextEl: ".swiper-button-next",
          prevEl: ".swiper-button-prev",
        },
      });
    </script>

</body>
</html>