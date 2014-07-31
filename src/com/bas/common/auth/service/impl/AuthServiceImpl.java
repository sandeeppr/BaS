/**
 * 
 */
package com.bas.common.auth.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bas.common.auth.dao.AuthDao;
import com.bas.common.auth.service.IAuthService;
import com.bas.common.exceptions.DataAccessLayerException;
import com.bas.common.exceptions.ServiceLayerException;
import com.bas.common.models.User;

/**
 * @author Sandy
 *
 */
@Service
public class AuthServiceImpl implements IAuthService {

	@Autowired
	private AuthDao authDao;

	@Override
	public User findById(String userId) {
		User user = null;
		user = authDao.findById(userId);
		return user;
	}

	@Override
	public User findUserById(String userId, String pwd) {
		User user = null;
		user = authDao.findUserById(userId, pwd);
		return user;
	}
	
	@Override
	public boolean findAvailabilityById(String userId) {
		
		boolean available = authDao.findAvailability(userId);
		return available;
	}
	
	@Override
	public boolean confirmAcntCreation(String userId) {
		boolean available = false;
		
		try{
			available = authDao.findAvailability(userId);
		}catch(DataAccessLayerException dale){
			throw new ServiceLayerException(dale.getMessage());
		}
		
		if(available == true){
			try{
				available = authDao.activateUserById(userId);
			}catch(DataAccessLayerException dale){
				throw new ServiceLayerException(dale.getMessage());
			}			
			return true;
		}else 
			return false;
	}
	
	@Override
	public boolean subscribeUser(String email){
		try{
			return authDao.subscribeUser(email);
		}catch(DataAccessLayerException dale){
			return false;
		}
	}
}
