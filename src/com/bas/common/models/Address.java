/**
 * 
 */
package com.bas.common.models;

import java.io.Serializable;


/**
 * @author Sandy
 *
 */
public class Address implements Serializable{ 

	private static final long serialVersionUID = 1L;


	private String address_id;
	

	private User user;
	
	private String line_1;
	
	private String line_2;
	
	private String line_3;
	
	private String zipcode;
	
	private String city;
	
	private String state;
	
	private String country;

	public String getAddress_id() {
		return address_id;
	}

	public void setAddress_id(String address_id) {
		this.address_id = address_id;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getLine_1() {
		return line_1;
	}

	public void setLine_1(String line_1) {
		this.line_1 = line_1;
	}

	public String getLine_2() {
		return line_2;
	}

	public void setLine_2(String line_2) {
		this.line_2 = line_2;
	}

	public String getLine_3() {
		return line_3;
	}

	public void setLine_3(String line_3) {
		this.line_3 = line_3;
	}

	public String getZipcode() {
		return zipcode;
	}

	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}
	
	
	
}
