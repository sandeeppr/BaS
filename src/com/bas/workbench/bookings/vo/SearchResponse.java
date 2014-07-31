/**
 * 
 */
package com.bas.workbench.bookings.vo;

import java.util.HashMap;
import java.util.Map;

/**
 * @author Sandy
 *
 */
public class SearchResponse {

	private String service;
	private String provider;
	private String name;
	private String locality;
	private double tariff;  
	private int rating;
	private String pic;
	private Map<String,String> badges = new HashMap<>();
	
	public String getService() {
		return service;
	}
	public void setService(String service) {
		this.service = service;
	}
	public String getProvider() {
		return provider;
	}
	public void setProvider(String provider) {
		this.provider = provider;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getLocality() {
		return locality;
	}
	public void setLocality(String locality) {
		this.locality = locality;
	}

	public void setBadges(Map<String, String> badges) {
		this.badges = badges;
	}
	public Map<String, String> getBadges() {
		return badges;
	}
	public double getTariff() {
		return tariff;
	}
	public void setTariff(double tariff) {
		this.tariff = tariff;
	}
	public int getRating() {
		return rating;
	}
	public void setRating(int rating) {
		this.rating = rating;
	}
	public String getPic() {
		return pic;
	}
	public void setPic(String pic) {
		this.pic = pic;
	}
	
	
}
