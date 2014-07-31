/**
 * 
 */
package com.bas.workbench.bookings.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bas.common.core.util.HibernateFactory;
import com.bas.common.exceptions.DataAccessLayerException;
import com.bas.common.models.BookingMisc;
import com.bas.common.models.BookingRequest;
import com.bas.common.models.User;
import com.bas.workbench.bookings.vo.SearchResponse;

/**
 * @author Sandy
 * 
 */
@Service
@Transactional
public class BookingRequestDao {

	@Autowired
	JdbcTemplate jdbcTemplate = null;

	private Session session;
	private Transaction tx;

	public BookingRequestDao() {
		HibernateFactory.buildIfNeeded();
	}

	/**
	 * Insert a new BookingRequest into the database.
	 * 
	 * @param booking
	 */
	/*public void create(BookingRequest booking) throws DataAccessLayerException {
		try {
			startOperation();
			session.saveOrUpdate(booking);
			tx.commit();
		} catch (HibernateException e) {
			handleException(e);
		} finally {
			HibernateFactory.close(session);
		}
	}*/

	/**
	 * Updates the state of a Booking.
	 * 
	 * @param booking
	 */
	/*public void update(BookingRequest booking) throws DataAccessLayerException {
		try {
			startOperation();
			session.update(booking);
			tx.commit();
		} catch (HibernateException e) {
			handleException(e);
		} finally {
			HibernateFactory.close(session);
		}
	}*/

	/**
	 * Find a Booking by its primary key.
	 * 
	 * @param id
	 * @return
	 */
	public BookingRequest findById(Long id) throws DataAccessLayerException {
		BookingRequest booking = null;
		try {
			startOperation();
			booking = (BookingRequest) session.load(BookingRequest.class, id);
			tx.commit();
		} catch (HibernateException e) {
			handleException(e);
		} finally {
			// HibernateFactory.close(session);
		}
		return booking;
	}

	public List<BookingRequest> findByUser(String id)
			throws DataAccessLayerException {
		BookingRequest booking = null;
		try {
			// TODO
			/*
			 * startOperation(); booking = (BookingRequest)
			 * session.load(BookingRequest.class, id); tx.commit();
			 */
		} catch (HibernateException e) {
			handleException(e);
		} finally {
			// HibernateFactory.close(session);
		}
		return null;// booking;
	}

	public boolean delete(Long id) {
		// TODO
		return true;
	}

	/**
	 * Finds all Events in the database.
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<BookingRequest> findAll() throws DataAccessLayerException {
		List<BookingRequest> bookings = null;
		try {
			startOperation();
			Query query = session.createQuery(" from BookingRequest");
			bookings = query.list();
			tx.commit();
		} catch (HibernateException e) {
			handleException(e);
		} finally {
			// HibernateFactory.close(session);
		}
		return bookings;
	}

	private void startOperation() throws HibernateException {
		session = HibernateFactory.openSession();
		tx = session.beginTransaction();
	}

	private void handleException(HibernateException e)
			throws DataAccessLayerException {
		HibernateFactory.rollback(tx);
		throw new DataAccessLayerException(e);
	}

	/**
	 * Insert a new BookingRequest into the database.
	 * 
	 * @param booking
	 */
	@Transactional
	public void saveOrUpdate(final BookingRequest booking) throws DataAccessLayerException {
		
		//StringBuffer query = new StringBuffer();
		final String query = "insert into bookings_master(service_id, pkg_code, customer_id, booking_status_code, booking_start_date, booking_end_date, booked_date, cost, contact_no) values(?,?,?,?,?,?,?,?,?)";
		Object[] params = {booking.getService_id(), booking.getPkg_code(), booking.getCustomer_id(), 
				booking.getBooking_status_code(), booking.getBooking_startDate(), booking.getBooking_endDate(), 
				booking.getBooked_date(), booking.getCost(), booking.getContact_no()};
		int[] types = {Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, 
				Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, 
				Types.VARCHAR, Types.DOUBLE, Types.VARCHAR};
		
		
		try {
			/*jdbcTemplate.
			jdbcTemplate.update(query.toString(), params, types);*/
			
			KeyHolder keyHolder = new GeneratedKeyHolder();
			jdbcTemplate.update(new PreparedStatementCreator() {
				public PreparedStatement createPreparedStatement(
						Connection connection) throws SQLException {
					PreparedStatement ps = connection.prepareStatement(query,
							new String[] { "booking_id" });
					ps.setString(1, booking.getService_id());
					ps.setString(2, booking.getPkg_code());
					ps.setString(3, booking.getCustomer_id());
					ps.setString(4, booking.getBooking_status_code());
					ps.setString(5, booking.getBooking_startDate());
					ps.setString(6, booking.getBooking_endDate());
					ps.setString(7, booking.getBooked_date());
					ps.setDouble(8, booking.getCost());
					ps.setString(9, booking.getContact_no());
					return ps;
				}
			}, keyHolder);

			booking.setBooking_id(keyHolder.getKey().longValue());
			System.out.println("booking id "+booking.getBooking_id());
			
		} catch (DataAccessException e) {
			e.printStackTrace();
			throw new DataAccessLayerException("Failed to create an order : "+e.getMessage());
		}
		
		StringBuffer miscQry = new StringBuffer();
		miscQry.append("insert into booking_misc_info(booking_id,info0,info1,info2,info3,info4,info5,info6,info7,info8) values(?,?,?,?,?,?,?,?,?,?)");
		BookingMisc misc = booking.getMisc();
		Object[] miscParams = {booking.getBooking_id(),misc.getInfo0(), misc.getInfo1(),
								misc.getInfo2(), misc.getInfo3(),misc.getInfo4(), 
								misc.getInfo5(),misc.getInfo6(), misc.getInfo7(),
								misc.getInfo8()};
		int[] miscTypes = {Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, 
							Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, 
							Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, 
							Types.VARCHAR};
		
		try {
			jdbcTemplate.update(miscQry.toString(), miscParams, miscTypes);
		} catch (DataAccessException e) {
			e.printStackTrace();
			throw new DataAccessLayerException("Failed to create an order misc: "+e.getMessage());
		}
		
	}

	
	/**
	 * Should perform search based on a few coordinates and returns a list of
	 * service providers out.
	 * 
	 * @param service
	 * @param city
	 * @param locality
	 * @return
	 */
	public List<SearchResponse> searchProviders(String service, String city,
			String locality) {

		StringBuffer query = new StringBuffer();
		query.append(
				"select distinct u.id provider_id, u.customer_name provider_name, a.line_3 locality, bo.badge_code badge, bo.badge_value")
				.append(" from users u, addresses a, badges_owned bo, badge_ref_codes brc")
				.append(" where a.address_id = u.address_id")
				.append(" and u.service_id = ?").append(" and a.city = ?")
				.append(" and a.line_3 = ?")
				.append(" and u.id = bo.provider_id")
				.append(" and bo.badge_code = brc.badge_id;");

		List<Map<String, Object>> results = jdbcTemplate.queryForList(
				query.toString(), new Object[] { service, city, locality });
		
		List<SearchResponse> searchResponse = new ArrayList<>();
		List<String> providersAdded = new ArrayList<>();
		
		for (Map<String, Object> row : results) {
			SearchResponse resp = new SearchResponse();
			String provider = row.get("provider_id").toString();
			resp.setProvider(provider);
			resp.setLocality(row.get("locality").toString());
			resp.setName(row.get("provider_name").toString());
			resp.setService(service);
			
			if (providersAdded.size() > 0 && providersAdded.contains(provider)) {		
				System.out.println("found a provider in list : "+provider);
				for(SearchResponse obj : searchResponse){
					System.out.println("obj provider :"+obj.getProvider());
					if(obj.getProvider().equalsIgnoreCase(provider)){
						obj.getBadges().put(row.get("badge").toString(),row.get("badge_value").toString());
						System.out.println("added badge_value : "+row.get("badge_value").toString()+" to provider : "+provider);
						break;
					}
					
				}
				
			}else {
				System.out.println("added provider to list : "+provider);
				resp.getBadges().put(row.get("badge").toString(),row.get("badge_value").toString());
				searchResponse.add(resp);
				providersAdded.add(row.get("provider_id").toString());
			}

		}
		return searchResponse;
	}
	
	public User create(User user){
		return user;
	}

}
