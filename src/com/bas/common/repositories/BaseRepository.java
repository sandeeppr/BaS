/**
 * 
 */
package com.bas.common.repositories;

import java.io.Serializable;
import java.util.List;

import org.springframework.dao.DataAccessException;

/**
 * @author Sandy
 *
 */
public interface BaseRepository<E extends BaseEntity<I>, I extends Serializable> {

	E findById(I argId) throws DataAccessException;

	List<E> findAll() throws DataAccessException;
	
	I save(E argEntity) throws DataAccessException;

	void delete(E argEntity) throws DataAccessException;

	void delete(I argId) throws DataAccessException;

}
