/**
 * 
 */
package com.bas.common.metadata.controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.validation.constraints.NotNull;

import org.apache.catalina.util.Base64;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bas.common.core.exceptions.JsonException;
import com.bas.common.core.util.JsonUtil;
import com.bas.common.metadata.dto.SearchReq;
import com.bas.common.metadata.service.IMetadataService;
import com.bas.common.models.Services;
import com.bas.workbench.bookings.vo.SearchResponse;

/**
 * @author Sandy
 *
 */
@Controller
@RequestMapping(value = "/metadata")
public class MetadataController {
	
	@Autowired
	private IMetadataService metadataService;

	@RequestMapping(value = "/services", method = RequestMethod.GET)
	public @ResponseBody List<Services> getServices(HttpServletResponse resp){
		resp.addHeader("Access-Control-Allow-Origin", "*");
		List<Services> services = metadataService.findAllServices();		
		return services;
	}
	
	@RequestMapping(value = "/services/{id}", method = RequestMethod.GET)
	public @ResponseBody Services getServiceDetails(@PathVariable("id") @NotNull String id, HttpServletResponse resp){
		resp.addHeader("Access-Control-Allow-Origin", "*");
		Services service = metadataService.findServiceById(id);	
		//service.getPkgs().size();
		
		try{
			System.out.println("services : \n"+JsonUtil.toString(service));
		}catch(JsonException | IllegalArgumentException e){
			System.out.println("Error : "+e.getMessage());
		}
		
		return service;
	}
	
	@RequestMapping(value = "/tariff/{pkgCode}", method = RequestMethod.GET)
	public @ResponseBody String getTariffByServiceId(@PathVariable("pkgCode") @NotNull String pkgCode, HttpServletResponse resp){		
		resp.addHeader("Access-Control-Allow-Origin", "*");
		String tariff = metadataService.findTariffByPkgCode(pkgCode);		
		return tariff;
	}
	
	@RequestMapping(value = "/{city}/localities", method = RequestMethod.GET)
	public @ResponseBody List<String> getLocalitiesByCity(@PathVariable("city")  @NotNull String city, HttpServletResponse resp){		
		resp.addHeader("Access-Control-Allow-Origin", "*");
		List<String> localities = metadataService.findLocsByCity(city);		
		return localities;
	}
	
	@RequestMapping(value = "/search", method = RequestMethod.POST, consumes = "application/json")
	public @ResponseBody List<SearchResponse> searchProviders(@RequestBody SearchReq searchReq, HttpServletResponse resp){		
		resp.addHeader("Access-Control-Allow-Origin", "*");		
		List<SearchResponse> providers =  metadataService.searchServiceProviders(searchReq);
		return providers;
	}
	
	@RequestMapping(value = "/models", method = RequestMethod.GET)
	public @ResponseBody List<String> getModels(HttpServletResponse resp){		
		resp.addHeader("Access-Control-Allow-Origin", "*");
		List<String> list = metadataService.findAllModels();		
		return list;
	}
	
}
