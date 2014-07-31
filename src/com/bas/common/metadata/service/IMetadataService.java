/**
 * 
 */
package com.bas.common.metadata.service;

import java.util.List;

import com.bas.common.metadata.dto.SearchReq;
import com.bas.common.models.Packages;
import com.bas.common.models.Services;
import com.bas.workbench.bookings.vo.SearchResponse;


/**
 * @author Sandy
 *
 */
public interface IMetadataService {

	public List<Services> findAllServices();
	public Services findServiceById(String id);
	public List<Packages> findPkgsByService(String serviceId);
	public String findTariffByPkgCode(String pkgCode);
	public List<String> findLocsByCity(String city);
	public List<SearchResponse> searchServiceProviders(SearchReq searchReq);
	public List<String> findAllModels();
	byte[] getImageBytes(String name);
}
