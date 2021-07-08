<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.PasswordAuthentication"%>
<%@page import="javax.mail.Authenticator"%>
<%@page import="javax.mail.Session"%>
<%@page import="java.util.Random"%>
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
		String id = request.getParameter("id");
		String email = request.getParameter("email");
		
		MemberDAO mDAO = new MemberDAO();
		int check = mDAO.pwEmail(id);
		 
		if(check == 0){
	%>		
		<script type="text/javascript">
			alert("잘못 입력 하셨습니다.");
			history.back();
		</script>	
	<%		
		}
		
		String host = "smtp.naver.com";
		final String user = "gksaudwls124";
		final String password = "458961q2w!";
		
		String to_email = email;
		
		Properties props = new Properties();
		props.put("mail.smtp.host",host);
		props.put("mail.smtp.port",465);
		props.put("mail.smtp.auth","true");
		props.put("mail.smtp.ssl.enable","true");
		
		StringBuffer temp = new StringBuffer();
		Random rnd = new Random();
		for(int i=0;i<10;i++){
			int rIndex = rnd.nextInt(3);
			switch(rIndex){
			case 0:
				// a-z
				temp.append((char) ((int)(rnd.nextInt(26))+97));
				break;
			case 1:
				// A-Z
				temp.append((char) ((int)(rnd.nextInt(26))+65));
				break;
			case 2:
				// 0-9
				temp.append((rnd.nextInt(10)));
				break;
			}
		}
		
		String AuthenticationKey = temp.toString();
		System.out.println(AuthenticationKey);
		
		Session sesion = Session.getDefaultInstance(props, new Authenticator(){
			protected PasswordAuthentication getPasswordAuthentication(){
				return new PasswordAuthentication(user,password);
			}
		});
		//email 전송
		try{
			MimeMessage msg = new MimeMessage(sesion);
			msg.setFrom(new InternetAddress(user,"Item Deal"));
			msg.addRecipient(Message.RecipientType.TO, new InternetAddress(to_email));
			
			//메일 제목
			msg.setSubject("안녕하세요 Item Deal 입니다.");
			//메일 내용
			msg.setText("인증 번호는 :"+temp);
			
			Transport.send(msg);
			System.out.println("이메일 전송");
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		HttpSession saveKey = request.getSession();
		saveKey.setAttribute("AuthenticationKey", AuthenticationKey);
		//패스워드 바꿀때 뭘 바꿀지 조건에 들어가는 id
		request.setAttribute("id", id);
		response.sendRedirect("joinForm.jsp");
		
		
	%>
	
	
	
	
	
	
	
	
</body>
</html>