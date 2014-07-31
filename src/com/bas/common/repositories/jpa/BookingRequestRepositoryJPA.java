/**
 * 
 */
package com.bas.common.repositories.jpa;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.bas.common.models.BookingRequest;
import com.bas.common.repositories.BookingRepository;

/**
 * @author Sandy
 *
 */
@Repository
public class BookingRequestRepositoryJPA extends BaseRepositoryJPA<BookingRequest, Long>
		implements BookingRepository {
	
	@PersistenceContext
	private EntityManager entityMgr;

	@Override
	public List<BookingRequest> findByUser(String userId)
			throws DataAccessException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	protected Class<BookingRequest> getEntityClass() {
		return BookingRequest.class;
	}

	@Override
	protected EntityManager getEntityManager() {
		return this.entityMgr;
	}

}
