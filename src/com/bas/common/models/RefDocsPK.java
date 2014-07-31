/**
 * 
 */
package com.bas.common.models;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;

/**
 * @author Sandy
 *
 */
@Embeddable
public class RefDocsPK implements Serializable{

	private static final long serialVersionUID = 1L;

	@Column(name="provider_id")
	private String userId;
	
	@Column(name="doc_id")
	private String doc_id;
	
	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getDoc_id() {
		return doc_id;
	}

	public void setDoc_id(String doc_id) {
		this.doc_id = doc_id;
	}
}
