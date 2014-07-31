/**
 * 
 */
package com.bas.common.notification.sms;

/**
 * @author Sandy
 *
 */
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.Properties;

import com.bas.common.notification.email.Notify;

public class SMS{
	
	private Properties smsProperties;
	public void setMailServerProperties() {

		smsProperties = new Properties();
		InputStream input = null;
		try {
			input = new FileInputStream("/resources/basProps.properties");
			smsProperties.load(input);
		} catch (IOException e) {
			e.printStackTrace();
			input = Notify.class.getClassLoader().getResourceAsStream("/resources/basProps.properties");
			try {
				smsProperties.load(input);
			} catch (IOException e1) {
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
	}
	
	public String prepBookingConfirmationSMS(String name, String phone, String orderID){
		boolean debug = true;
		String encodedPhone= null;
		String message=null;
		try{	
			encodedPhone = URLEncoder.encode("91"+phone, "UTF-8"); 		
			
			if(debug) 
				System.out.println("phone------>"+encodedPhone); 

			String msg = smsProperties.getProperty("sms.gateway.message.bookingConfirmation");
			//String msg = "Dear ***USERNAME***, \nThanks for booking with Sahaay.com. \nPlease make a note of your Booking Request Id : ***BOOKING_ID***, for further reference. \n Thanks,\nSahaay.Com.";
			msg = msg.replace("***USERNAME***", name);
			msg = msg.replace("***BOOKING_ID***", orderID);
			message = URLEncoder.encode(msg, "UTF-8"); 
		
			if(debug) 
				System.out.println("message---->"+message); 
		
		}catch (UnsupportedEncodingException e){ 
			System.out.println("Encoding not supported"); 
		} 
		
		//String url_str = "http://smsoutbox.info/"+"?user=sahaay&password=sah567"+ "&PhoneNumber="+phone+"&Text="+message+ "&Sender=Sahaay.com";
		
		String url_str = smsProperties.getProperty("sms.gateway.host")+"?user="+smsProperties.getProperty("sms.gateway.username")
				+ "&password="+smsProperties.getProperty("sms.gateway.password")
				+ "&PhoneNumber="+encodedPhone+"&Text="+message
				+ "&Sender="+smsProperties.getProperty("sms.gateway.sender");
	
		if(debug)                   
			System.out.println("url string->"+url_str);
		
		return url_str;
	}
	
	public String prepAccountCreationSMS(String name, String phone, String custID){
		boolean debug = true;
		String encodedPhone= null;
		String message=null;
		try{	
			encodedPhone = URLEncoder.encode("91"+phone, "UTF-8"); 		
			
			if(debug) 
				System.out.println("phone------>"+encodedPhone); 

			String msg = smsProperties.getProperty("sms.gateway.message.registrationConfirmation");
			msg = msg.replace("***USERNAME***", name);
			msg = msg.replace("***REG_ID***", custID);
			message = URLEncoder.encode(msg, "UTF-8"); 
		
			if(debug) 
				System.out.println("message---->"+message); 
		
		}catch (UnsupportedEncodingException e){ 
			System.out.println("Encoding not supported"); 
		} 
		
		String url_str = smsProperties.getProperty("sms.gateway.host")+"?user="+smsProperties.getProperty("sms.gateway.username")
				+ "&password="+smsProperties.getProperty("sms.gateway.password")
				+ "&PhoneNumber="+encodedPhone+"&Text="+message
				+ "&Sender="+smsProperties.getProperty("sms.gateway.sender");
	
		if(debug)                   
			System.out.println("url string->"+url_str);
		
		return url_str;
	}
	
	public void sendSMS(String url){
		try { 
			
			URL url2 = new URL(url); 
			HttpURLConnection connection = (HttpURLConnection) url2.openConnection();
			connection.setDoOutput(false); 
			connection.setDoInput(true); 
			
			System.out.println("Opened Con->"+connection); 
			
			String res=connection.getResponseMessage(); 
			
			System.out.println("Get Resp  ->"+res); 
			
			int code = connection.getResponseCode () ; 
			
			if ( code == HttpURLConnection.HTTP_OK ){ 
				connection.disconnect() ; 
			}
			
		}catch(IOException e){
			System.out.println("unable to create new url"+e.getMessage());
		}
	}
	
	public static void main(String[] args){
		SMS sms = new SMS();
		String str = sms.prepBookingConfirmationSMS("BEVK Kumari", "09916017100", "165");
		sms.sendSMS(str);
	}
}