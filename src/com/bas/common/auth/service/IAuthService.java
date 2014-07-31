/**
 * 
 */
package com.bas.common.auth.service;

import com.bas.common.models.User;

/**
 * @author Sandy
 *
 */
public interface IAuthService {	
	User findById(String userId);

	User findUserById(String userId, String pwd);

	boolean findAvailabilityById(String userId);

	boolean confirmAcntCreation(String userId);

	boolean subscribeUser(String email);
}
