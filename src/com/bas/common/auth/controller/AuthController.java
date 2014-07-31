/**
 * 
 */
package com.bas.common.auth.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bas.common.auth.dto.Auth;
import com.bas.common.auth.service.IAuthService;
import com.bas.common.core.util.EncryptionUtil;
import com.bas.common.models.User;

/**
 * @author Sandy
 *
 */

@Controller
@RequestMapping("/auth")
public class AuthController {
	
	private static final String COMMON_AUTH_VIEW = "";
	private static final String SIGNUP_VIEW = "";
	private static final String ERROR_VIEW = "ErrorPage";
	
	@Autowired
	private IAuthService authService;
	
	/**
	 * Service that would redirect to auth view.
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(method = RequestMethod.GET, value = "common")
	public String getViewCommon(HttpServletRequest request) throws Exception{
		return COMMON_AUTH_VIEW;
	}
	
	/**
	 * Service that would redirect to auth view.
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(method = RequestMethod.GET, value = "signup")
	public String getViewSignUp(HttpServletRequest request) throws Exception{
		return SIGNUP_VIEW;
	}
	
	@RequestMapping(method = RequestMethod.GET, value = "error")
	public String showErrorView(HttpServletRequest request) throws Exception{
		return ERROR_VIEW;
	}
	
	@RequestMapping(method = RequestMethod.GET, value = "home")
	public String getViewHome(HttpServletRequest request) throws Exception{
		return "index";
	}
	
	@RequestMapping(method = RequestMethod.POST, value = "/doAuth", headers="Accept=*/*")
	public @ResponseBody
	String doAuth(@RequestBody Auth auth, HttpServletResponse resp) {
		resp.addHeader("Access-Control-Allow-Origin", "*");
		System.out.println("Attempting Login for user : "+auth.getUserid());
		User user = authService.findById(auth.getUserid());
		if(authorizeCredentials(auth,user))
			//redirect to a welcome page 
			return "true";
		else return "false";
	}
	
	@RequestMapping(method = RequestMethod.POST, value = "/checkUserId", consumes = "application/json", headers="Accept=*/*")
	public @ResponseBody String checkUserNameAvalibalitity(@RequestBody Auth auth, HttpServletResponse resp) {
		resp.addHeader("Access-Control-Allow-Origin", "*");
		System.out.println("Attempting to check username avalibality : "+auth.getUserid());
		boolean registered = authService.findAvailabilityById(auth.getUserid());
		if(registered)
			return String.valueOf(false);
		else 
			return String.valueOf(true);
	}
	
	@RequestMapping(method = RequestMethod.GET, value = "/checkUserId/{id}.{suffix}", headers="Accept=*/*" )
	public @ResponseBody String isUserNameAvalibale(@PathVariable("id") String id,@PathVariable("suffix") String suffix, HttpServletResponse resp) {
		resp.addHeader("Access-Control-Allow-Origin", "*");
		System.out.println("Attempting to check username avalibality dot : "+id+"."+suffix);
		boolean registered = authService.findAvailabilityById(id);
		if(registered)
			return String.valueOf(false);
		else 
			return String.valueOf(true);
	}
	
	@RequestMapping(method = RequestMethod.GET, value = "/checkUserId/{id:.+}", headers="Accept=*/*")
	public @ResponseBody String isSPIdAvalibale(@PathVariable("id") String id, HttpServletResponse resp) {
		resp.addHeader("Access-Control-Allow-Origin", "*");
		System.out.println("Attempting to check username avalibality exp : "+id);
		boolean registered = authService.findAvailabilityById(id);
		if(registered)
			return String.valueOf(false);
		else 
			return String.valueOf(true);
	}
	
	@RequestMapping(method = RequestMethod.GET, value = "/verify/{id:.+}", headers="Accept=*/*")
	public String confirmAccountCreation(@PathVariable("id") String id, HttpServletResponse resp) {
		resp.addHeader("Access-Control-Allow-Origin", "*");
		String decrypted = id;
		try {
			decrypted = (new EncryptionUtil()).decrypt(id);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("Attempting to confirm user account : "+decrypted);
		boolean activated = authService.confirmAcntCreation(decrypted);
		if(activated)
			return "index";
		else 
			return ERROR_VIEW;
	}
	
	@RequestMapping(method = RequestMethod.GET, value = "/emailVerify/{id}.{suffix}", headers="Accept=*/*")
	public @ResponseBody String confirmAccountCreation(@PathVariable("id") String id,@PathVariable("suffix") String suffix, HttpServletResponse resp) {
		resp.addHeader("Access-Control-Allow-Origin", "*");
		System.out.println("Attempting to confirm user account : "+id+"."+suffix);
		boolean found = authService.confirmAcntCreation(id+"."+suffix);
		if(found)
			return "/BaS";
		else 
			return ERROR_VIEW;
	}
	
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public @ResponseBody String logoutUser(HttpServletRequest req,HttpServletResponse resp){		
		resp.addHeader("Access-Control-Allow-Origin", "*");
		HttpSession session = req.getSession();
		session.removeAttribute("loggedIn");
		session.removeAttribute("userName");
		session.removeAttribute("mobile");
		return "Success";
	}
	
	@RequestMapping(value = "{id}/subscribe", method = RequestMethod.GET)
	public @ResponseBody String subscribeUser(@PathVariable("id") String id,HttpServletRequest req,HttpServletResponse resp){		
		resp.addHeader("Access-Control-Allow-Origin", "*");
		authService.subscribeUser(id);
		return "Success";
	}
	
	private boolean authorizeCredentials(Auth auth,User user){
		if(user == null)
			return false;
		if(auth.getPwd().equals(user.getPassword()))
			return true;
		return false;
	}

}
