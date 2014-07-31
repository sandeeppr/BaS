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
@Table(name="booking_misc_info")
@JsonAutoDetect
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class BookingMisc implements Serializable{

	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "booking_id", unique = true, nullable = false)
	@GeneratedValue(generator="gen")
    @GenericGenerator(name="gen", strategy="foreign", parameters=@Parameter(name="property", value="booking"))
    private Long booking_id;
	
	@JsonBackReference
	@OneToOne(mappedBy="misc", cascade=CascadeType.ALL)
	private BookingRequest booking;
	
	@Column(name="info1")
	private String info1;
	
	@Column(name="info2")
	private String info2;
	
	@Column(name="info3")
	private String info3;
	
	@Column(name="info4")
	private String info4;
	
	@Column(name="info5")
	private String info5;
	
	@Column(name="info6")
	private String info6;
	
	@Column(name="info7")
	private String info7;
	
	@Column(name="info8")
	private String info8;
	
	@Column(name="info9")
	private String info9;
	
	@Column(name="info0")
	private String info0;

	/**
	 * @return the booking_id
	 */
	public Long getBooking_id() {
		return this.booking.getBooking_id();
	}

	/**
	 * @return the info1
	 */
	public String getInfo1() {
		return info1;
	}

	/**
	 * @param info1 the info1 to set
	 */
	public void setInfo1(String info1) {
		this.info1 = info1;
	}

	/**
	 * @return the info2
	 */
	public String getInfo2() {
		return info2;
	}

	/**
	 * @param info2 the info2 to set
	 */
	public void setInfo2(String info2) {
		this.info2 = info2;
	}

	/**
	 * @return the info3
	 */
	public String getInfo3() {
		return info3;
	}

	/**
	 * @param info3 the info3 to set
	 */
	public void setInfo3(String info3) {
		this.info3 = info3;
	}

	/**
	 * @return the info4
	 */
	public String getInfo4() {
		return info4;
	}

	/**
	 * @param info4 the info4 to set
	 */
	public void setInfo4(String info4) {
		this.info4 = info4;
	}

	/**
	 * @return the info5
	 */
	public String getInfo5() {
		return info5;
	}

	/**
	 * @param info5 the info5 to set
	 */
	public void setInfo5(String info5) {
		this.info5 = info5;
	}

	/**
	 * @return the info6
	 */
	public String getInfo6() {
		return info6;
	}

	/**
	 * @param info6 the info6 to set
	 */
	public void setInfo6(String info6) {
		this.info6 = info6;
	}

	/**
	 * @return the info7
	 */
	public String getInfo7() {
		return info7;
	}

	/**
	 * @param info7 the info7 to set
	 */
	public void setInfo7(String info7) {
		this.info7 = info7;
	}

	/**
	 * @return the info8
	 */
	public String getInfo8() {
		return info8;
	}

	/**
	 * @param info8 the info8 to set
	 */
	public void setInfo8(String info8) {
		this.info8 = info8;
	}

	/**
	 * @return the info9
	 */
	public String getInfo9() {
		return info9;
	}

	/**
	 * @param info9 the info9 to set
	 */
	public void setInfo9(String info9) {
		this.info9 = info9;
	}

	/**
	 * @return the info0
	 */
	public String getInfo0() {
		return info0;
	}

	/**
	 * @param info10 the info10 to set
	 */
	public void setInfo0(String info0) {
		this.info0 = info0;
	}

	/**
	 * @return the booking
	 */
	public BookingRequest getBooking() {
		return booking;
	}

	/**
	 * @param booking the booking to set
	 */
	public void setBooking(BookingRequest booking) {
		this.booking = booking;
	}

}
