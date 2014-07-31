/**
 * 
 */
package com.bas.common.models;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.codehaus.jackson.annotate.JsonAutoDetect;
import org.codehaus.jackson.annotate.JsonBackReference;
import org.codehaus.jackson.annotate.JsonIgnoreProperties;

/**
 * @author Sandy
 *
 */
@Entity
@Table(name="proof_documents")
@JsonAutoDetect
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class RefDocs  implements Serializable{ 

	private static final long serialVersionUID = 1L;
	
	@EmbeddedId
	private RefDocsPK id;

	@Column(name = "provider_id", insertable =  false, updatable = false)
	private String userId = null;
	
	@Column(name="doc_id", insertable =  false, updatable = false)
	private String doc_id;
	
	@Column(name = "doc_copy", unique = false, nullable = false, length = 100000)
    private byte[] copy;

	public byte[] getCopy() {
		return copy;
	}

	public void setCopy(byte[] copy) {
		this.copy = copy;
	}


	public RefDocsPK getId() {
		return id;
	}

	public void setId(RefDocsPK id) {
		this.id = id;
	}

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
