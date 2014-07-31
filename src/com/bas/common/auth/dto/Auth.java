/**
 * 
 */
package com.bas.common.auth.dto;

import java.io.Serializable;

/**
 * @author Sandy
 *
 * This class is to handle authorizations only !!
 * ** FOR ALL OTHER NEEDS, PLEASE USE 'USER' model **
 */
public class Auth implements Serializable{
	
	private String userid;
	private String pwd;
	
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
}
