/**
 * 
 */
package com.bas.common.models;

import java.io.Serializable;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.codehaus.jackson.annotate.JsonAutoDetect;
import org.codehaus.jackson.annotate.JsonBackReference;
import org.codehaus.jackson.annotate.JsonIgnoreProperties;
import org.codehaus.jackson.annotate.JsonManagedReference;

/**
 * @author Sandy
 *
 */
@Entity
@Table(name = "package_codes")
@JsonAutoDetect
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class Packages implements Serializable{	
	
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "pkg_code" , nullable = false, unique = true)
	private String pkg_code;
	
	@Column(name = "pkg_name", nullable = false)
	private String pkg_name;
	
	@Column(name = "description")
	private String description;
	
	@JsonManagedReference
	@OneToOne(cascade=CascadeType.ALL)
	@JoinColumn(name="pkg_code")
	private Tariff tariff_details; 
	
	@JsonBackReference
	@ManyToOne
	@JoinColumn(name = "service_id")
	private Services service;

	/**
	 * @return the pkg_code
	 */
	public String getPkg_code() {
		return pkg_code;
	}

	/**
	 * @param pkg_code the pkg_code to set
	 */
	public void setPkg_code(String pkg_code) {
		this.pkg_code = pkg_code;
	}

	/**
	 * @return the pkg_name
	 */
	public String getPkg_name() {
		return pkg_name;
	}

	/**
	 * @param pkg_name the pkg_name to set
	 */
	public void setPkg_name(String pkg_name) {
		this.pkg_name = pkg_name;
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
	 * @return the tariff_details
	 */
	public Tariff getTariff_details() {
		return tariff_details;
	}

	/**
	 * @param tariff_details the tariff_details to set
	 */
	public void setTariff_details(Tariff tariff_details) {
		this.tariff_details = tariff_details;
	}

	/**
	 * @return the service
	 */
	public Services getService() {
		return service;
	}

	/**
	 * @param service the service to set
	 */
	public void setService(Services service) {
		this.service = service;
	}
	
	
}
