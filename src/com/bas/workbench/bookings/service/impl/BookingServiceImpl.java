/**
 * 
 */
package com.bas.workbench.bookings.service.impl;

import java.util.List;

import javax.mail.MessagingException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bas.common.exceptions.DataAccessLayerException;
import com.bas.common.exceptions.ServiceLayerException;
import com.bas.common.models.BookingRequest;
import com.bas.common.notification.email.NotificationUtil;
import com.bas.workbench.bookings.dao.BookingRequestDao;
import com.bas.workbench.bookings.service.IBookingService;
import com.bas.workbench.bookings.vo.SearchResponse;

/**
 * @author Sandy
 *
 */
@Service
@Transactional
public class BookingServiceImpl implements IBookingService {
	
	@Autowired
	private BookingRequestDao bookingDao;
	
	@Autowired
	private NotificationUtil notify;
	
	public BookingServiceImpl(){}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<BookingRequest> findAll() {
		return bookingDao.findAll();
	}

	@Override
	public List<BookingRequest> findByUser(String customerId) {
		return bookingDao.findByUser(customerId);
	}

	@Override
	@Transactional
	public void save(BookingRequest argEntity) {
		
		try {
			bookingDao.saveOrUpdate(argEntity);
			notify.notifyBookingConfirmation(argEntity);			
		} catch (DataAccessLayerException | MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			throw new ServiceLayerException(e.getMessage());
		}
	}

	@Override
	public void deleteById(Long bookingId) {
		bookingDao.delete(bookingId);
	}
	
	@Override
	public BookingRequest findById(Long bookingId) {
		return bookingDao.findById(bookingId);
	}

	@Override
	public List<SearchResponse> searchServiceProviders(String service, String city,
			String locality) {
		List<SearchResponse> providers = null;
		try{
			providers = bookingDao.searchProviders(service, city, locality);
		}catch(DataAccessLayerException dale){
			//TODO
		}
		return providers;
	}
}
