/**
 * 
 */
package com.bas.common.notification.email;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.bas.common.core.util.EncryptionUtil;
import com.bas.common.exceptions.DataAccessLayerException;
import com.bas.common.models.BookingRequest;
import com.bas.common.models.User;

/**
 * @author Sandy
 * 
 */
public class Notify {

	private Properties emailProperties;
	private Session mailSession;
	private MimeMessage emailMessage;
	
	public void setMailServerProperties() {

		emailProperties = new Properties();
		InputStream input = null;
		try {
			input = new FileInputStream("/resources/basProps.properties");
			emailProperties.load(input);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			input = Notify.class.getClassLoader().getResourceAsStream("/resources/basProps.properties");
			try {
				emailProperties.load(input);
			} catch (IOException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		}finally {
			if (input != null) {
				try {
					input.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		
		System.out.println("reading prop : "+emailProperties.getProperty("mail.smtp.port"));
	    /*emailProperties = System.getProperties();
	    emailProperties.put("mail.smtp.port", "587");
	    emailProperties.put("mail.smtp.auth", "true");
	    emailProperties.put("mail.smtp.starttls.enable", "true");
		emailProperties.put("mail.email.host","smtp.gmail.com");
		emailProperties.put("mail.from.user","orders.sahaay@gmail.com");
		emailProperties.put("mail.from.user.pwd","sahaay123$");
		emailProperties.put("mail.email.subject_CustomerCare","New Booking Request :");
		emailProperties.put("mail.email.newAccount_subject","Welcome to Sahaay !");
*/
	}

	public void createEmailMessage(BookingRequest booking)
			throws AddressException, MessagingException {

		
		String toCustomerCare = "Hi CustomerCare, </br> </br> Please find the details of a new booking. </br></br>"
				+ "<table>" + "<tr><td>Booking Id           : </td><td>    "
				+ booking.getBooking_id()
				+ "</td></tr>"
				+ "<tr><td>Booked By            : </td><td>    "
				+ booking.getCustomer_id()
				+ "<tr><td>Contact Name         : </td><td>    "
				+ booking.getMisc().getInfo8()
				+ "</td></tr>"
				+ "<tr><td>Contact Number       : </td><td>    "
				+ booking.getContact_no()
				+ "</td></tr>"
				+ "<tr><td>Interested Service   : </td><td>    "
				+ booking.getService_id()
				+ "</td></tr>"
				+ "<tr><td>Preferred Provider   : </td><td>    "
				+ booking.getMisc().getInfo5()
				+ "</td></tr>"
				+ "<tr><td>Location/City        : </td><td>    "
				+ booking.getMisc().getInfo0()
				+ "</td></tr>"
				+ "<tr><td>Required Date & Time : </td><td>    "
				+ booking.getBooking_startDate()
				+ "</td></tr>"
				+ "<tr><td>Hourly Package       : </td><td>    "
				+ booking.getPkg_code() +" hrs"
				+ "</td></tr>"
				+ "<tr><td>Tariff Entitled      : </td><td>    "
				+ booking.getCost()
				+ "</td></tr>"
				+ "<tr><td>Going Out of Station : </td><td>    "
				+ booking.getMisc().getInfo1()
				+ "</td></tr>"
				+ "<tr><td>Model of the Car     : </td><td>    "
				+ booking.getMisc().getInfo2()
				+ "</td></tr>"
				+ "<tr><td>Pickup Location      : </td><td>    "
				+ booking.getMisc().getInfo3()
				+ "</td></tr>"
				+ "<tr><td>Preferences          : </td><td>    "
				+ booking.getMisc().getInfo4()
				+ "</td></tr>"
				+ "</table>"
				+ "</br> Please do the needful !"
				+ "</br></br> Thanks,</br>Sahaay.com";

		mailSession = Session.getDefaultInstance(emailProperties, null);
		emailMessage = new MimeMessage(mailSession);
		
		String[] toList = (emailProperties.getProperty("mail.email.ordersSupport").toString()).split(",");
		

		for (int i = 0; i < toList.length; i++) {
			emailMessage.addRecipient(Message.RecipientType.TO,
					new InternetAddress(toList[i]));
		}

		emailMessage.setSubject(emailProperties.getProperty("mail.email.subject_CustomerCare") + booking.getBooking_id()
				+ "/" + booking.getService_id() + "/"
				+ booking.getMisc().getInfo0() + "/"
				+ booking.getBooking_startDate());
		emailMessage.setContent(toCustomerCare, "text/html");// for a html email
		// emailMessage.setText(emailBody);// for a text email

	}

	
	public void createWelcomeEmailMsg(User user)
			throws AddressException, MessagingException {
		String[] toEmails = new String[]{user.getId()};
		String toCustomer;
		try {
			toCustomer = "Hi "
					+ user.getName()
					+ ",<br> <br>Welcome to <b>Sahaay.com</b>. <br> Please make a note of your <strong>User Id : "
					+ user.getId()
					+ "</strong>, for further references."
					+ "<br><br>  To complete your registration, please click the link below <br>"
					+ emailProperties.getProperty("host.protocol")+"://"+emailProperties.getProperty("host.server")+"/"+emailProperties.getProperty("urls.emailconfirm")+"/"+(new EncryptionUtil()).encrypt(user.getId())
					+ "<br> <br>If you have any questions regarding this booking, please feel free to contact us."
					+ "<br><strong>Toll Free number : 1234-567-890</strong>"
					+ "<br><strong>Customer Service Email address : customercare@sahaay.com</strong>"
					+ "<br><br>Regards, <br> Team Sahaay.";
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			throw new DataAccessLayerException("Failed to send email notification");
		}
		
		mailSession = Session.getDefaultInstance(emailProperties, null);
		emailMessage = new MimeMessage(mailSession);

		for (int i = 0; i < toEmails.length; i++) {
			emailMessage.addRecipient(Message.RecipientType.TO,
					new InternetAddress(toEmails[i]));
		}

		emailMessage.setSubject(emailProperties.getProperty("mail.email.newAccount_subject"));
		emailMessage.setContent(toCustomer, "text/html");// for a html email
		// emailMessage.setText(emailBody);// for a text email

	}
	
	public void createBookingEmailMsg(BookingRequest booking)
			throws AddressException, MessagingException {
		String toCustomer = "Hi "
				+ booking.getCustomer_id()
				+ ",</br> </br>Thanks for booking with <b>Sahaay.com</b>. </br> Please make a note of your <strong>Booking Request Id : "
				+ booking.getBooking_id()
				+ "</strong>, for further references."
				+ "</br> Our customer service will get in touch with you with you to take the request forward."
				+ "</br></br>If you have any questions regarding this booking, please feel free to contact us."
				+ "</br><strong>Toll Free number : 1234-567-890</strong>"
				+ "</br><strong>Customer Service Email address : customercare@sahaay.com</strong>"
				+ "</br></br>Regards, </br> Team Sahaay.";
		String[] toEmails = new String[]{booking.getCustomer_id()};
		
		mailSession = Session.getDefaultInstance(emailProperties, null);
		emailMessage = new MimeMessage(mailSession);

		for (int i = 0; i < toEmails.length; i++) {
			emailMessage.addRecipient(Message.RecipientType.TO,
					new InternetAddress(toEmails[i]));
		}

		emailMessage.setSubject(emailProperties.getProperty("mail.email.bookingConf.customer"));
		emailMessage.setContent(toCustomer, "text/html");// for a html email
		// emailMessage.setText(emailBody);// for a text email

	}

	public void sendEmail() throws AddressException, MessagingException {

		Transport transport = mailSession.getTransport("smtp");

		transport.connect(emailProperties.getProperty("mail.email.host"), emailProperties.getProperty("mail.from.user"), emailProperties.getProperty("mail.from.user.pwd"));
		transport.sendMessage(emailMessage, emailMessage.getAllRecipients());
		transport.close();
		System.out.println("Email sent successfully.");
	}
	
	public static void main(String[] args){
		Notify not = new Notify();
		not.setMailServerProperties();
		User user = new User();
		user.setId("kisan.pr@gmail.com");
		user.setName("Name");
		try {
			not.createWelcomeEmailMsg(user);
			not.sendEmail();
		} catch (AddressException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

}
