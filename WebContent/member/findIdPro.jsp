<%@page import="member.GoogleAuth"%>
<%@page import="member.MemberBean"%>
<%@page import="javax.mail.Message.RecipientType"%>
<%@page import="java.util.Date"%>
<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.Address"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.Session"%>
<%@page import="javax.mail.PasswordAuthentication"%>
<%@page import="javax.mail.Authenticator"%>
<%@page import="java.util.Properties"%>
<%@page import="member.MemberDAO"%>
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
		String email = request.getParameter("email");
		
		MemberDAO mDAO = new MemberDAO();
		
		String id = mDAO.findId(email);
		
			String sender = "gksaudwls124@gmail.com";
			String subject = "아이템 거래소 입니다";
			String content = "안녕하세요 " + email + "님, <br>" + "귀하의 아이디는    [<b>" + id + "</b>]   입니다.";
			
			try{
				Properties properties = System.getProperties();
				
				properties.put("mail.smtp.starttls.enable", "true");
				properties.put("mail.smtp.host", "smtp.gmail.com");
				properties.put("mail.smtp.auth", "true");
				properties.put("mail.smtp.port", "587");
				
				Authenticator auth = new GoogleAuth(); 
				Session session1 = Session.getDefaultInstance(properties, auth);
				Message message = new MimeMessage(session1);
				Address senderAd = new InternetAddress(sender);
				Address receiverAd = new InternetAddress(email);
				
				message.setHeader("content-type", "text/html;charset=UTF-8");
				message.setFrom(senderAd);
				message.addRecipient(RecipientType.TO, receiverAd);
				message.setSubject(subject);
				message.setContent(content, "text/html;charset=UTF-8");
				message.setSentDate(new Date());
				
				Transport.send(message);
				
			}catch(Exception e){
				
			}
		response.sendRedirect("login.jsp");
	%>
	
	
	
	
	
</body>
</html>