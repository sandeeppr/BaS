/**
 * 
 */
package com.bas.common.models;

import java.io.Serializable;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

import org.codehaus.jackson.annotate.JsonAutoDetect;
import org.codehaus.jackson.annotate.JsonIgnoreProperties;
import org.codehaus.jackson.annotate.JsonManagedReference;

/**
 * @author Sandy
 *
 */
@Entity
@Table(name="bookings_master")
@JsonAutoDetect
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class BookingRequest implements Serializable{

	private static final long serialVersionUID = -5520756447686371686L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "booking_id", unique = true, nullable = false)
    private Long booking_id;
	
	@NotNull
	@Column(name="service_id")
	private String service_id;
	
	@NotNull
	@Column(name="pkg_code")
	private String pkg_code;
	
	@NotNull
	@Column(name="customer_id")
	private String customer_id;
	
	@Column(name="contact_no")
	private String contact_no;
	
	@Column(name="booking_status_code")
	private String booking_status_code;
	
	@Column(name="payment_id")
	private String payment_id;
	
	@Column(name="cost")
	private double cost;
	
	@NotNull
	@Column(name="booking_start_date")
	private String booking_startDate;
	
	@Column(name="booking_end_date")
	private String booking_endDate;
	
	@Column(name="booked_date")
	private String booked_date;
	
	@JsonManagedReference
	@OneToOne(cascade=CascadeType.ALL,fetch=FetchType.LAZY)
	@JoinColumn(name="booking_id")
	private BookingMisc misc;

	public BookingRequest(){
		
	}
	/**
	 * @return the booking_id
	 */
	public Long getBooking_id() {
		return booking_id;
	}

	/**
	 * @param booking_id the booking_id to set
	 */
	public void setBooking_id(Long booking_id) {
		this.booking_id = booking_id;
	}

	/**
	 * @return the service_id
	 */
	public String getService_id() {
		return service_id;
	}

	/**
	 * @param service_id the service_id to set
	 */
	public void setService_id(String service_id) {
		this.service_id = service_id;
	}

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
	 * @return the customer_id
	 */
	public String getCustomer_id() {
		return customer_id;
	}

	/**
	 * @param customer_id the customer_id to set
	 */
	public void setCustomer_id(String customer_id) {
		this.customer_id = customer_id;
	}

	/**
	 * @return the booking_status_code
	 */
	public String getBooking_status_code() {
		return booking_status_code;
	}

	/**
	 * @param booking_status_code the booking_status_code to set
	 */
	public void setBooking_status_code(String booking_status_code) {
		this.booking_status_code = booking_status_code;
	}

	/**
	 * @return the payment_id
	 */
	public String getPayment_id() {
		return payment_id;
	}

	/**
	 * @param payment_id the payment_id to set
	 */
	public void setPayment_id(String payment_id) {
		this.payment_id = payment_id;
	}

	/**
	 * @return the cost
	 */
	public double getCost() {
		return cost;
	}

	/**
	 * @param cost the cost to set
	 */
	public void setCost(double cost) {
		this.cost = cost;
	}

	/**
	 * @return the booking_startDate
	 */
	public String getBooking_startDate() {
		return booking_startDate;
	}

	/**
	 * @param booking_startDate the booking_startDate to set
	 */
	public void setBooking_startDate(String booking_startDate) {
		this.booking_startDate = booking_startDate;
	}

	/**
	 * @return the booking_endDate
	 */
	public String getBooking_endDate() {
		return booking_endDate;
	}

	/**
	 * @param booking_endDate the booking_endDate to set
	 */
	public void setBooking_endDate(String booking_endDate) {
		this.booking_endDate = booking_endDate;
	}

	/**
	 * @return the booked_date
	 */
	public String getBooked_date() {
		return booked_date;
	}

	/**
	 * @param booked_date the booked_date to set
	 */
	public void setBooked_date(String booked_date) {
		this.booked_date = booked_date;
	}

	/**
	 * @return the miscs
	 */
	public BookingMisc getMisc() {
		return misc;
	}
	/**
	 * @param miscs the miscs to set
	 */
	public void setMisc(BookingMisc misc) {
		this.misc = misc;
	}
	public String getContact_no() {
		return contact_no;
	}
	public void setContact_no(String contact_no) {
		this.contact_no = contact_no;
	}
	
}
