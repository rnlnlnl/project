package member;

import java.util.Date;
import java.util.Properties;

import javax.mail.Address;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Message.RecipientType;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class MemberService {

	MemberDAO mDAO;
	
	public MemberService(){
		mDAO = new MemberDAO();
	}
	
	public boolean emailCert(String email){
		String certNum = createCertNum();
		
		boolean result = emailCertSend(email, certNum);
		
		return result;
	}
	
	public boolean emailCertSend(String email, String authNum){
		boolean result = false;
		
		String sender = "gksaudwls124@gmail.com";
		String subject = "아이템 거래소 입니다";
		String content = "안녕하세요 " + email + "님, <br>" + "귀하의 인증번호는    [<b>" + authNum + "</b>]   입니다.";
		
		try {
			Properties properties = System.getProperties();

			properties.put("mail.smtp.starttls.enable", "true");
			properties.put("mail.smtp.host", "smtp.gmail.com");
			properties.put("mail.smtp.auth", "true");
			properties.put("mail.smtp.port", "587");
			
			Authenticator auth = new GoogleAuthentication();
			Session session = Session.getDefaultInstance(properties, auth);
			Message message = new MimeMessage(session);
			Address senderAd = new InternetAddress(sender);
			Address receiverAd = new InternetAddress(email);
			
			message.setHeader("content-type", "text/html;charset=UTF-8");
			message.setFrom(senderAd);
			message.addRecipient(RecipientType.TO, receiverAd);
			message.setSubject(subject);
			message.setContent(content, "text/html;charset=UTF-8");
			message.setSentDate(new Date());
			
			Transport.send(message);
			result = true;
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("이메일 전송 오류");
		}
		return result;
	}
	
	
	
	
	
	
	
	// 회원가입 이메일 인증시 전송되는 랜덤한 숫자 6자리 생성 메서드
	public String createCertNum() {
		StringBuffer certNum = new StringBuffer();

		for (int i = 0; i < 6; ++i) {
			int randNum = (int) (Math.random() * 10.0D);
			certNum.append(randNum);
		}

		return certNum.toString();
	}
	
	
}

class GoogleAuthentication extends Authenticator{
	
	PasswordAuthentication passAuth = new PasswordAuthentication("gksaudwls124@gmail.com", "458961q2w!");
	
	public PasswordAuthentication getPasswordAuthentication(){
		return this.passAuth;
	}
	
}





