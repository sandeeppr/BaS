/**
 * 
 */
package com.bas.common.core.util;

import java.util.Collection;

/**
 * @author Sandy
 *
 */
public class ValidationUtil {

	public static boolean notNullAndNotEmpty(Collection<?> argCollection) {
		return argCollection != null && !argCollection.isEmpty();
	}

	public static boolean notNull(Object argObject) {
		return argObject != null;
	}

	public static boolean notNullAndNotEmpty(String argString) {
		return argString != null && !argString.isEmpty();
	}

	public static boolean notNullAndNotEmptyTrimmed(String argString) {
		if (argString != null) {
			String temp = argString.trim();
			return temp.isEmpty();
		}
		return false;
	}
}
