package com.bas.common.repositories.jpa;

import java.io.Serializable;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Set;

import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;

import org.springframework.dao.DataAccessException;

import com.bas.common.core.util.ValidationUtil;
import com.bas.common.exceptions.EntityValidationFailedException;
import com.bas.common.exceptions.NoDataFoundException;
import com.bas.common.repositories.BaseEntity;

public class EntityUtil {
	public static <T, I> T findById(I argId, Class<T> argEntityClass,
			EntityManager argEm) {
		T result = argEm.find(argEntityClass, argId);
		return result;
	}

	public static <T> List<T> findAll(Class<T> argEntityClass,
			EntityManager argEntityManager) throws DataAccessException {
		CriteriaBuilder builder = argEntityManager.getCriteriaBuilder();
		CriteriaQuery<T> cq = builder.createQuery(argEntityClass);
		Root<T> entityRoot = cq.from(argEntityClass);
		cq.select(entityRoot);
		List<T> result = emptyIfNull(argEntityManager.createQuery(cq)
				.getResultList());
		return result;
	}

	public static <T> List<T> emptyIfNull(List<T> results) {
		if (ValidationUtil.notNullAndNotEmpty(results)) {
			return results;
		} else {
			return Collections.emptyList();
		}
	}

	public static <T extends BaseEntity<I>, I extends Serializable> I save(
			I argId, T argEntity, EntityManager argEntityManager) {
		if (argId != null) {
			argEntityManager.merge(argEntity);
		} else {
			argEntityManager.persist(argEntity);
		}
		return argEntity.getId();
	}

	public static <T, I> void delete(I argId, Class<T> argEntityClass,
			EntityManager argEntityManager) {
		T scopeRef = argEntityManager.getReference(argEntityClass, argId);
		argEntityManager.remove(scopeRef);
	}

	//
	public static <T> TypedQuery<T> getTypedQuery(String argNamedQuery,
			Class<T> argEntityClass, EntityManager argEntityManager) {
		return argEntityManager.createNamedQuery(argNamedQuery, argEntityClass);
	}

	public static NoDataFoundException noDatFoundException(
			String argNamedQuery, Object... argParams) {
		return new NoDataFoundException(String.format(
				"namedQuery: %s parameters: %s", argNamedQuery,
				Arrays.toString(argParams)));
	}

	public static <E> EntityValidationFailedException entityValidationFailedException(
			Class<E> argEntityClass, ConstraintViolationException e) {
		StringBuilder beanValidationErrors = new StringBuilder(
				String.format(
						"VALIDATION ERRORS:\nJavaBean validation failed for entity: %s\n",
						argEntityClass.getName()));
		Set<ConstraintViolation<?>> constraintViolations = e
				.getConstraintViolations();
		String beanValidationErrorsString = beanValidationErrors.append(
				toString(constraintViolations)).toString();
		return new EntityValidationFailedException(beanValidationErrorsString,
				e);
	}

	public static String toString(
			Set<ConstraintViolation<?>> constraintViolations) {
		if (ValidationUtil.notNullAndNotEmpty(constraintViolations)) {
			StringBuilder beanValidationErrors = new StringBuilder();
			for (ConstraintViolation<?> constraintViolation : constraintViolations) {
				beanValidationErrors
						.append(String
								.format("VALIDATION ERROR: \trootBean: %s\n\tpropertyPath: %s\n\terrorMessage: %s\n\tinvalidValue: %s\n\tdescriptor: %s\n",
										constraintViolation.getRootBeanClass(),
										constraintViolation.getPropertyPath(),
										constraintViolation.getMessage(),
										constraintViolation.getInvalidValue(),
										constraintViolation
												.getConstraintDescriptor()));
			}
			String beanValidationErrorsString = beanValidationErrors.toString();
			return beanValidationErrorsString;
		}
		return null;
	}

}
