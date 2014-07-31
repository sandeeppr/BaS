/**
 * 
 */
package com.bas.workbench.bookings.controller;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.io.Serializable;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.constraints.NotNull;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.bas.common.auth.dto.Auth;
import com.bas.common.auth.service.IAuthService;
import com.bas.common.core.exceptions.JsonException;
import com.bas.common.core.util.JsonUtil;
import com.bas.common.models.BookingRequest;
import com.bas.common.models.User;
import com.bas.workbench.bookings.service.IBookingService;
import com.bas.workbench.bookings.vo.SearchResponse;
import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * @author Sandy
 *
 */
@Controller
@RequestMapping("/bookings")
public class BookingRequestController implements Serializable{

	private static final String SERVICE_REQUEST_VIEW = "BookaService";
	
	@Autowired
	private IBookingService bookingService;
	@Autowired
	private IAuthService authService;
	
	private static final Logger logger = Logger.getLogger(BookingRequestController.class);
	
	/**
	 * Service that would redirect to request view.
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(method = RequestMethod.GET, value = "requestBookingPage")
	public String getServiceRequestForm(HttpServletRequest request) throws Exception{
		logger.debug("requested booking page");
		return SERVICE_REQUEST_VIEW;
	}
	
	@RequestMapping(value = "/requests/{id}")
	public @ResponseBody BookingRequest getRequestsDetails(@PathVariable("id") @NotNull String id, HttpServletResponse resp){
		resp.addHeader("Access-Control-Allow-Origin", "*");

		BookingRequest request = bookingService.findById(Long.parseLong(id));	
		request.getMisc();
		
		try{
			logger.debug("request : \n"+JsonUtil.toString(request));
		}catch(JsonException | IllegalArgumentException e){
			logger.debug("Error : "+e.getMessage());
			logger.debug(e.getMessage());
		}
		
		return request;
	}
	
	@RequestMapping(value = "/requests")
	public @ResponseBody List<BookingRequest> getBookings(HttpServletResponse resp){
		if(logger.isDebugEnabled())
			logger.debug("call for getBookings alis /requests");
		logger.info("call for getBookings alis /requests");
		resp.addHeader("Access-Control-Allow-Origin", "*");
		List<BookingRequest> requests = bookingService.findAll();	
		//requests.getMisc();

		logger.info("request : \n"+JsonUtil.toString(requests));
		
		return requests;
	}
	
	@RequestMapping(method = RequestMethod.POST, value = "/requestABooking", consumes = "application/json")
	public @ResponseBody
	String processServiceBooking(@RequestBody BookingRequest booking, HttpServletResponse resp) throws ParseException {
		resp.addHeader("Access-Control-Allow-Origin", "*");
		// TODO
		booking.setBooked_date((new Date()).toString()); 

		//persist it now.
		bookingService.save(booking);
		
		return String.valueOf(booking.getBooking_id());
	}
	
	@SuppressWarnings("unused")
	private java.sql.Date convertStringToSqlDate(String strDate) throws ParseException{
		
		SimpleDateFormat sdf = new SimpleDateFormat("dd-mm-yyyy hh:mm");
        Date date = sdf.parse(strDate);
       
        java.sql.Date sqlDate = new java.sql.Date(date.getTime());
		
		return sqlDate;
	}
	
	@SuppressWarnings("unused")
	private BookingRequest translateUserJsonToDTO(HttpServletRequest request) {
		BookingRequest booking = null;
		String encoding = request.getCharacterEncoding();
		encoding = encoding == null ? "UTF-8" : encoding;
		try {
			InputStream in = request.getInputStream();
			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			byte[] buf = new byte[8192];
			int len = 0;
			while ((len = in.read(buf)) != -1) {
				baos.write(buf, 0, len);
			}
			String requestString = new String(baos.toByteArray(), encoding);
			ObjectMapper mapper = new ObjectMapper();
			booking = mapper.readValue(requestString, BookingRequest.class);
		} catch (Exception e) {			
			logger.debug("Error while maping the post request's data to POJO");
		}

		return booking;
	}
	
	@RequestMapping(method=RequestMethod.GET, value="test")
	public String test(){
		return "success";
	}
	
	@RequestMapping(value = "search/{param1}/{param2}/{param3}", method = RequestMethod.GET)
	public @ResponseBody List<SearchResponse> searchProviders(@PathVariable("param1")  @NotNull String param1, @PathVariable("param2")  @NotNull String param2, @PathVariable("param3")  @NotNull String param3, HttpServletResponse resp){		
		resp.addHeader("Access-Control-Allow-Origin", "*");
		List<SearchResponse> providers = bookingService.searchServiceProviders(param1, param2, param3);
		return providers;
	}
	
	@RequestMapping(value = "/auth/signin", method = RequestMethod.POST, consumes = "application/json")
	public @ResponseBody String loginUser(@RequestBody Auth auth, HttpServletRequest req,HttpServletResponse resp){		
		resp.addHeader("Access-Control-Allow-Origin", "*");
		HttpSession session = req.getSession();
		
		User user = authService.findUserById(auth.getUserid(),auth.getPwd());
		if(user != null ){
			System.out.println("user sign in : "+user.getName()+"  "+user.getMobile());
			session.setAttribute("loggedIn", "true");
			session.setAttribute("userName", user.getName());
			session.setAttribute("mobile", user.getMobile());
			return "Success";
		}else
			return "Login Failed. Invalid username or password !";
	}
}
