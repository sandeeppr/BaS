/**
 * 
 */
package com.bas.common.models;

import java.io.Serializable;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.codehaus.jackson.annotate.JsonAutoDetect;
import org.codehaus.jackson.annotate.JsonIgnoreProperties;
import org.codehaus.jackson.annotate.JsonManagedReference;

/**
 * @author Sandy
 *
 */
@Entity
@Table(name = "services")
@JsonAutoDetect
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class Services implements Serializable{

	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "service_id" , nullable = false, unique = true)
	private String serviceId;
	
	@Column(name = "service_name", nullable = false)
	private String name;
	
	@Column(name = "description")
	private String description;
	
	@JsonManagedReference
	@OneToMany(mappedBy = "service", fetch=FetchType.EAGER)
	private List<Packages> pkgs;

	/**
	 * @return the serviceId
	 */
	public String getServiceId() {
		return serviceId;
	}

	/**
	 * @param serviceId the serviceId to set
	 */
	public void setServiceId(String serviceId) {
		this.serviceId = serviceId;
	}

	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}

	/**
	 * @param name the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * @return the description
	 */
	public String getDescription() {
		return description;
	}

	/**
	 * @param description the description to set
	 */
	public void setDescription(String description) {
		this.description = description;
	}

	/**
	 * @return the pkgs
	 */
	public List<Packages> getPkgs() {
		return pkgs;
	}

	/**
	 * @param pkgs the pkgs to set
	 */
	public void setPkgs(List<Packages> pkgs) {
		this.pkgs = pkgs;
	}

}
