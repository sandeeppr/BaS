package com.bas.common.core.util;

import java.io.File;

import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.map.SerializationConfig;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.bas.common.core.exceptions.JsonException;

public class JsonUtil {
	private static final Logger logger = LoggerFactory
			.getLogger(JsonUtil.class);
	private static ObjectMapper objectMapper = createObjectMapper();

	private static ObjectMapper createObjectMapper() {
		logger.debug("Initializing {}", JsonUtil.class.getName());
		ObjectMapper temp = new ObjectMapper();
		// objectMapper.registerModule(new JodaModule());
		temp.configure(SerializationConfig.Feature.INDENT_OUTPUT, true);
		temp.configure(SerializationConfig.Feature.WRITE_DATES_AS_TIMESTAMPS,
				false);
		return temp;
	}

	public static <T> T toObject(String argJsonString, Class<T> argClass) {
		if (argJsonString != null && !argJsonString.isEmpty()) {
			if (argClass != null) {
				try {
					return objectMapper.readValue(argJsonString, argClass);
				} catch (Exception e) {
					JsonException jsonException = new JsonException(
							String.format(
									"Exception while unmarshalling json string %s to class %s",
									argJsonString, argClass), e);
					throw jsonException;
				}
			} else {
				throw new IllegalArgumentException("argClass cannot be null");
			}
		} else {
			throw new IllegalArgumentException(
					"argJsonString cannot be null or empty");
		}
	}

	public static String toString(Object argObject) {
		if (argObject != null) {
			try {
				return objectMapper.writeValueAsString(argObject);
			} catch (Exception e) {
				JsonException jsonException = new JsonException(
						String.format(
								"Exception while marshalling object of type %s to string",
								argObject.getClass().getName()), e);
				throw jsonException;
			}
		} else {
			throw new IllegalArgumentException("argObject cannot be null");
		}
	}

	public static <T> T toObject(File argFile, Class<T> argClass) {
		try {
			return objectMapper.readValue(argFile, argClass);
		} catch (Exception e) {
			JsonException jsonException = new JsonException(
					String.format(
							"Exception while unmarshalling json string from file %s to class %s",
							argFile.toPath().toAbsolutePath(), argClass), e);
			throw jsonException;
		}
	}
}
