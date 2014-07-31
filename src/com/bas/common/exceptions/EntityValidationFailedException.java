/**
 * 
 */
package com.bas.common.exceptions;

import org.springframework.dao.DataAccessException;

/**
 * @author Sandy
 *
 */
public class EntityValidationFailedException extends DataAccessException {
	private static final long serialVersionUID = 1L;

	public EntityValidationFailedException(String argMsg, Throwable argCause) {
		super(argMsg, argCause);
	}

	public EntityValidationFailedException(String argMsg) {
		super(argMsg);
	}

}
