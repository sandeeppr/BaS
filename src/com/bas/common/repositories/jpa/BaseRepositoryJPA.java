/**
 * 
 */
package com.bas.common.repositories.jpa;

import java.io.Serializable;
import java.util.List;

import javax.persistence.EntityManager;
import javax.validation.ConstraintViolationException;

import org.springframework.dao.DataAccessException;

import com.bas.common.repositories.BaseEntity;
import com.bas.common.repositories.BaseRepository;


/**
 * @author Sandy
 *
 */
public abstract class BaseRepositoryJPA<E extends BaseEntity<I>, I extends Serializable>
implements BaseRepository<E, I> {

public BaseRepositoryJPA() {
	super();
}

protected abstract Class<E> getEntityClass();

protected abstract EntityManager getEntityManager();

@Override
public E findById(I argId) throws DataAccessException {
return EntityUtil.findById(argId, getEntityClass(),
		this.getEntityManager());
}

@Override
public void delete(I argId) throws DataAccessException {
EntityUtil.delete(argId, getEntityClass(), this.getEntityManager());
}

@Override
public I save(E argScope) throws DataAccessException {
try {
	return EntityUtil.save(argScope.getId(), argScope,this.getEntityManager());
} catch (ConstraintViolationException e) {
	throw EntityUtil.entityValidationFailedException(
			this.getEntityClass(), e);
}
}

@Override
public void delete(E argEntity) throws DataAccessException {
EntityUtil.delete(argEntity.getId(), getEntityClass(),
		this.getEntityManager());
}

@Override
public List<E> findAll() throws DataAccessException {
return EntityUtil.findAll(getEntityClass(), this.getEntityManager());
}

}
