package com.bas.common.core.exceptions;

public class JsonException extends RuntimeException {

	private static final long serialVersionUID = 1L;

	public JsonException() {
		super();
	}

	public JsonException(String argMessage, Throwable argCause,
			boolean argEnableSuppression, boolean argWritableStackTrace) {
		super(argMessage, argCause, argEnableSuppression, argWritableStackTrace);
	}

	public JsonException(String argMessage, Throwable argCause) {
		super(argMessage, argCause);
	}

	public JsonException(String argMessage) {
		super(argMessage);
	}

	public JsonException(Throwable argCause) {
		super(argCause);
	}

}
