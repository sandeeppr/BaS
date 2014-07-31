package com.bas.workbench.profiles.controller;

import java.io.IOException;
import java.io.InputStream;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
/*import org.apache.commons.fileupload.FileItemIterator;
import org.apache.commons.fileupload.FileItemStream;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.util.Streams;*/
/*import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;*/
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bas.common.exceptions.BaSException;
import com.bas.common.models.RefDocs;
import com.bas.common.models.User;
import com.bas.workbench.profiles.service.IProfileMgmtService;
import com.bas.workbench.profiles.va.ProfileObject;

@Controller
@RequestMapping("/profileMgmt")
public class ProfileMgmtController {

	@Autowired
	IProfileMgmtService profileService;
	@Autowired
	ServletContext context;
	private static final Logger logger = Logger.getLogger(ProfileMgmtController.class);
	
		
	/**
	 * Service to bring up sign up page for service providers
	 * @return
	 */
	@RequestMapping(value = "/showSPSignUp", method = RequestMethod.GET)
	public String showServiceProviderSignUpView() {
		return "SignUp";
	}
	
	/**
	 * Service to bring up login page for customers
	 * @return
	 */
	@RequestMapping(value = "/loginRegister", method = RequestMethod.GET)
	public String showCustomerSignUpView() {
		return "SignIn";
	}
	
	@RequestMapping(value = "/confirm", method = RequestMethod.GET)
	public String showHomeView() {
		return "/ConfirmationPage";
	}
	
	@RequestMapping(value = "/error", method = RequestMethod.GET)
	public String showErrorView() {
		return "ErrorPage";
	}
	
	@RequestMapping(method = RequestMethod.POST, value = "/createAccount", consumes = "application/json")
	public @ResponseBody String register(@RequestBody User user, HttpServletResponse resp) {
		resp.addHeader("Access-Control-Allow-Origin", "*");
		logger.debug("got user : "+user.getId());
		System.out.println("got user : "+user.getId());
		boolean isCreated = false;
		try{
			isCreated = profileService.createAccount(user);
		}catch(Exception e){
			throw new BaSException(e.getMessage());		
		}
		if(isCreated)
			return "Success";
		else
			return "Failure";
	}
	
	
	@RequestMapping(method = RequestMethod.POST, value = "saveRefDocs", consumes = "application/json")
	public void register(@RequestBody RefDocs refdocs, HttpServletResponse resp) {
		resp.addHeader("Access-Control-Allow-Origin", "*");
		logger.debug("got user : "+refdocs.getId());
		//profileService.save(refdocs);		
	}
	
	@RequestMapping(method = RequestMethod.POST, value = "saveProfile", consumes = "application/json")
	public  @ResponseBody String saveProfile(@RequestBody ProfileObject profile, HttpServletResponse resp) {
		resp.addHeader("Access-Control-Allow-Origin", "*");
		System.out.println(profile.getAddress().getCity());			
		boolean saved = profileService.saveProfile(profile);
		if(saved)
			return "true";
		else
			return "false";
	}
	
	@RequestMapping(method = RequestMethod.POST, value = "/uploadFile")
	public String upload(@ModelAttribute ProfileObject prof, HttpServletRequest req, HttpServletResponse resp) {
		resp.addHeader("Access-Control-Allow-Origin", "*");
		logger.debug("Continuing creation of profile for : "+prof.getCustomer_id());
		boolean saved = profileService.saveProfile(prof);
		if(saved)
			return "ConfirmationPage";
		else
			return "Error";
	}
	
	@RequestMapping(method = RequestMethod.POST, value = "/uploadProfile")
	public void uploadProfile(@RequestBody ProfileObject prof, HttpServletRequest req, HttpServletResponse resp) {
		resp.addHeader("Access-Control-Allow-Origin", "*");
		logger.debug("Continuing creation of profile for : "+prof.getCustomer_id());
		profileService.processDocumentUploads(prof.getFiles());
		logger.debug("Processed uploaded documents");
		boolean saved = profileService.saveProfile(prof);
		/*if(saved)
			return "redirect:home";
		else
			return "redirect:error";*/
	}
	
	@RequestMapping(method=RequestMethod.GET, value="showSPProfile")
	public String showSPProfile(){
		return "SP_Profile";
	}
	
	@RequestMapping(method=RequestMethod.GET, value="image1")
	public @ResponseBody String testphoto(HttpServletResponse response) throws IOException {
		response.setContentType("image/png");
       
	    InputStream in = context.getResourceAsStream("/images/image.png");
	    /*String image = Base64.encode(IOUtils.toByteArray(in));
	    return "data:image/png;base64,"+image;*/
	    
	    return new String(IOUtils.toByteArray(in));
	    
	}
	
	@RequestMapping(method=RequestMethod.GET, value="test")
	public String test(){
		return "success";
	}
	
}
