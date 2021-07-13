package member;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class GoogleAuth extends Authenticator{
PasswordAuthentication passAuth = new PasswordAuthentication("gksaudwls124@gmail.com", "ridmxilaudovymkq");
	
	public PasswordAuthentication getPasswordAuthentication(){
		return this.passAuth;
	}
}
