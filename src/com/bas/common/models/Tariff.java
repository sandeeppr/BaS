/**
 * 
 */
package com.bas.common.models;

import java.io.Serializable;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.codehaus.jackson.annotate.JsonAutoDetect;
import org.codehaus.jackson.annotate.JsonBackReference;
import org.codehaus.jackson.annotate.JsonIgnoreProperties;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Parameter;

/**
 * @author Sandy
 *
 */
@Entity
@Table(name = "tariffs")
@JsonAutoDetect
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class Tariff implements Serializable{
	
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "pkg_code" , nullable = false, unique = true)
	@GeneratedValue(generator="gen")
    @GenericGenerator(name="gen", strategy="foreign", parameters=@Parameter(name="property", value="pkg"))
	private String pkg_code;
	
	@Column(name = "tariff", nullable = false)
	private double tariff;
	
	@OneToOne(mappedBy="tariff_details", cascade=CascadeType.ALL)
	@JsonBackReference
	private Packages pkg;

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
	 * @return the tariff
	 */
	public double getTariff() {
		return tariff;
	}

	/**
	 * @param tariff the tariff to set
	 */
	public void setTariff(double tariff) {
		this.tariff = tariff;
	}

	/**
	 * @return the pkg
	 */
	public Packages getPkg() {
		return pkg;
	}

	/**
	 * @param pkg the pkg to set
	 */
	public void setPkg(Packages pkg) {
		this.pkg = pkg;
	}
	
	
}
