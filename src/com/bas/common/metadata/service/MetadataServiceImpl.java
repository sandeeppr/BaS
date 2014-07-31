/**
 * 
 */
package com.bas.common.metadata.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import com.bas.common.exceptions.DataAccessLayerException;
import com.bas.common.metadata.dao.MetadataDao;
import com.bas.common.metadata.dto.SearchReq;
import com.bas.common.models.Packages;
import com.bas.common.models.Services;
import com.bas.workbench.bookings.vo.SearchResponse;

/**
 * @author Sandy
 *
 */
@Service
public class MetadataServiceImpl implements IMetadataService {
	
	@Autowired
	private MetadataDao metadataDao;

	@Override
	public Services findServiceById(String id) {
		return metadataDao.findServiceById(id);
	}

	@Override
	public List<Packages> findPkgsByService(String serviceId) {
		return metadataDao.findPkgsByService(serviceId);
	}

	@Override
	public List<Services> findAllServices() {
		return metadataDao.findAllServices();
	}

	@Override
	public String findTariffByPkgCode(String pkgCode) {
		return metadataDao.findTariffByPkg(pkgCode);
	}

	@Override
	public List<String> findLocsByCity(String city) {
		List<String> locs = null;
		try{
			locs = metadataDao.findLocsByCity(city);
		}catch(DataAccessLayerException dale){
			// TODO
		}
		return locs;
	}

	@Override
	public List<SearchResponse> searchServiceProviders(SearchReq searchReq) {
		List<SearchResponse> list = null;
		try{
			list = metadataDao.searchProviders(searchReq.getType(), searchReq.getParam1(), searchReq.getParam2(), searchReq.getParam3(),searchReq.getParam4());
		}catch(DataAccessLayerException dale){
			//TODO
		}
		return list;
	}

	@Override
	public List<String> findAllModels() {
		List<String> models = null;
		try{
			models = metadataDao.findAllModels();
		}catch(DataAccessLayerException dale){
			//TODO
		}
		return models;
	}
	
	@Override
	public byte[] getImageBytes(String name){
		
		String[] tokens = name.split("_");		
		byte[] bytes = null;
		
		try{
			bytes = metadataDao.getImageBytes(tokens[0], tokens[1]);
		}catch(DataAccessLayerException dale){
			//TODO
		}
		
		return bytes;
	}

}
