/**
 * 
 */
package com.bas.common.exceptions;

/**
 * @author Sandy
 *
 */
public class BaSException extends RuntimeException {
	
	private static final long serialVersionUID = 1L;

	public BaSException() {
    }

    public BaSException(String message) {
        super(message);
    }

    public BaSException(Throwable cause) {
        super(cause);
    }

    public BaSException(String message, Throwable cause) {
        super(message, cause);
    }

}
