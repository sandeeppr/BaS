/**
 * 
 */
package com.bas.workbench.common;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bas.workbench.bookings.controller.BookingRequestController;

/**
 * @author Sandy
 *
 */
@Controller
@RequestMapping("/views")
public class SahaayViewController {
	
	private static final String ABOUTUS_VIEW = "AboutUs";
	private static final String HOWITWORKS_VIEW = "HowItWorks";
	private static final String OURSERVICES_VIEW = "Services";
	private static final String HOME_VIEW = "index";
	
	private static final Logger logger = Logger.getLogger(SahaayViewController.class);
	
	@RequestMapping(method = RequestMethod.GET, value = "home")
	public String showHomeView(HttpServletRequest request) throws Exception{
		logger.debug("requested home page");
		return HOME_VIEW;
	}
	
	@RequestMapping(method = RequestMethod.GET, value = "aboutus")
	public String showAboutUs(HttpServletRequest request) throws Exception{
		logger.debug("requested aboutus page");
		return ABOUTUS_VIEW;
	}
	
	@RequestMapping(method = RequestMethod.GET, value = "services")
	public String showServices(HttpServletRequest request) throws Exception{
		logger.debug("requested services page");
		return OURSERVICES_VIEW;
	}
	
	@RequestMapping(method = RequestMethod.GET, value = "howitworks")
	public String showHowItWorks(HttpServletRequest request) throws Exception{
		logger.debug("requested howitworks page");
		return HOWITWORKS_VIEW;
	}
	
}
