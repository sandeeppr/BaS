/**
 * 
 */
package com.bas.workbench.bookings.service;

import java.util.List;

import com.bas.common.models.BookingRequest;
import com.bas.common.models.User;
import com.bas.workbench.bookings.vo.SearchResponse;

/**
 * @author Sandy
 *
 */
public interface IBookingService {	

	// BookingRequest API's
	List<BookingRequest> findAll();

	List<BookingRequest> findByUser(String customerId);

	void save(BookingRequest argEntity);

	BookingRequest findById(Long bookingId);

	void deleteById(Long bookingId);
	
	List<SearchResponse> searchServiceProviders(String service, String city, String locality);
}
