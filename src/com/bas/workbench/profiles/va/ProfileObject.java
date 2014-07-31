/**
 * 
 */
package com.bas.workbench.profiles.va;

import java.util.List;

import com.bas.common.models.Address;
import com.bas.common.models.User;

/**
 * @author Sandy
 *
 */
public class ProfileObject {
	
	private User user;
	
	private String service;
	
	private String city_id;
	
	private String customer_id;
	
	private String lang;

	private BadgesOwned badgesOwned;
	
	private Address address;
	
	private List<ProfileReferences> refs;
	
	private List<Files> files;

	public BadgesOwned getBadgesOwned() {
		return badgesOwned;
	}

	public void setBadgesOwned(BadgesOwned badgesOwned) {
		this.badgesOwned = badgesOwned;
	}

	public Address getAddress() {
		return address;
	}

	public void setAddress(Address address) {
		this.address = address;
	}

	public List<ProfileReferences> getRefs() {
		return refs;
	}

	public void setRefs(List<ProfileReferences> refs) {
		this.refs = refs;
	}

	public String getService() {
		return service;
	}

	public void setService(String service) {
		this.service = service;
	}

	public String getCustomer_id() {
		return customer_id;
	}

	public void setCustomer_id(String customer_id) {
		this.customer_id = customer_id;
	}

	public String getCity_id() {
		return city_id;
	}

	public void setCity_id(String city_id) {
		this.city_id = city_id;
	}

	public List<Files> getFiles() {
		return files;
	}

	public void setFiles(List<Files> files) {
		this.files = files;
	}

	public String getLang() {
		return lang;
	}

	public void setLang(String lang) {
		this.lang = lang;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
}
