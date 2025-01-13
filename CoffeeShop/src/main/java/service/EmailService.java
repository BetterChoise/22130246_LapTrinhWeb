package service;

import java.util.Date;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class EmailService {

	// Email server configuration
	final static String from = "tannguyen7769@gmail.com"; // Thay bằng email của bạn
	final static String password = "acwwrdglqqyfrmge"; 

	/**
	 * Gửi email
	 *
	 * @param recipientEmail: Địa chỉ email người nhận
	 * @param subject:        Tiêu đề email
	 * @param messageText:    Nội dung email
	 * @throws ClassNotFoundException
	 */
	public static void sendEmail(String recipientEmail, String subject, String messageText)
			throws ClassNotFoundException {
		// Thiết lập cấu hình SMTP server
		Class.forName("jakarta.activation.DataHandler");

		Properties properties = new Properties();
		properties.put("mail.smtp.host", "smtp.gmail.com");
		properties.put("mail.smtp.port", "587");
		properties.put("mail.smtp.auth", "true");
		properties.put("mail.smtp.starttls.enable", "true");
		properties.put("mail.smtp.ssl.protocols", "TLSv1.2");

		javax.mail.Authenticator auth = new javax.mail.Authenticator() {
			@Override
			protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
				// TODO Auto-generated method stub
				return new javax.mail.PasswordAuthentication(messageText, password);
			}
		};

		Session session = Session.getInstance(properties, auth);

		final String to = recipientEmail;
		MimeMessage msg = new MimeMessage(session);

		try {
			// kiểu nội dung
			msg.addHeader("Content-type", "text/HTML; charset=UTF-8");
			// người gửi
			msg.setFrom(from);
			// người nhận
			msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to, false));
			// tiêu đề mail
			msg.setSubject(subject);
			// ngày gửi
			msg.setSentDate(new Date());
			// nội dung
			msg.setText("Your verification code: \n" + messageText, "UTF-8");

			Transport.send(msg);
		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}

	public static void main(String[] args) throws ClassNotFoundException {
		int otp = (int) (Math.random() * 900000) + 100000;
		String otpCode = "" + otp;
		sendEmail("vodaithanhtai777@gmail.com", "Verification", otpCode);
	}
}
