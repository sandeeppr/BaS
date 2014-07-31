/**
 * 
 */
package com.bas.common.notification.email;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;

import org.springframework.stereotype.Service;

import com.bas.common.models.BookingRequest;
import com.bas.common.models.User;
import com.bas.common.notification.sms.SMS;

/**
 * @author Sandy
 *
 */
@Service
public class NotificationUtil {

	public void notifyBookingConfirmation(BookingRequest booking) throws AddressException, MessagingException{		
		notifyByEmail(booking);
		notifyBookingBySMS(booking);		
	}
	
	public void notifyAccountConfirmation(User user, boolean isCustomer) throws AddressException, MessagingException{		
		if(!isCustomer) // ie.. he is a provider
			sendAccountConfirmation(user);
		
		if(isCustomer)
			notifyAccountCreatiobBySMS(user);
	}
	
	private void notifyBookingBySMS(BookingRequest booking){
		
		SMS notify = new SMS();
		notify.setMailServerProperties();
		
		// to customer
		String url = notify.prepBookingConfirmationSMS(booking.getCustomer_id(), booking.getContact_no(), booking.getBooking_id().toString());
		notify.sendSMS(url);
	}
	
	
	private void notifyAccountCreatiobBySMS(User user){
		
		SMS notify = new SMS();
		notify.setMailServerProperties();
		
		// to customer
		String url = notify.prepAccountCreationSMS(user.getName(), user.getMobile(), user.getId());
		notify.sendSMS(url);
	}
	
	private void notifyByEmail(BookingRequest booking) throws AddressException, MessagingException{
		Notify notify = new Notify();
		notify.setMailServerProperties();
		
		// to cc
		notify.createEmailMessage(booking);
		notify.sendEmail();
		
		//to customer
		notify.createBookingEmailMsg(booking);
		notify.sendEmail();
		
	}
	
	private void sendAccountConfirmation(User user) throws AddressException, MessagingException{
		Notify notify = new Notify();
		notify.setMailServerProperties();
		
		// to cc
		notify.createWelcomeEmailMsg(user);
		notify.sendEmail();
		
	
	}

}
