/**
 * 
 */
package com.bas.common.models;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Id;

/**
 * @author Sandy
 *
 */
public class ServiceProvider  implements Serializable{ 

	private static final long serialVersionUID = 1L;


	@Id
	@Column(name="provider_id")
	private String userId;
	@Id
	@Column(name="service_id")
	private String serviceId;

	@Column(name="active")
	private String active;
	
	
}
