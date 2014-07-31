/**
 * 
 */
package com.bas.common.repositories;

import java.io.Serializable;

/**
 * @author Sandy
 *
 */
public interface BaseEntity<I extends Serializable> extends Serializable {
	I getId();
}
