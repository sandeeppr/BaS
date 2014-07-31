/**
 * 
 */
package com.bas.common.repositories;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.bas.common.models.BookingRequest;

/**
 * @author Sandy
 *
 */
public interface BookingRepository extends BaseRepository<BookingRequest, Long> {

	List<BookingRequest> findByUser(String userId) throws DataAccessException;
}
