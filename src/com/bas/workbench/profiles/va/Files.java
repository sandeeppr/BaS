package com.bas.workbench.profiles.va;

import org.springframework.web.multipart.MultipartFile;

public class Files {
	
	private String provider;
	private String doc_id;
	private MultipartFile files;
	private String file_loc;

	public MultipartFile getFiles() {
		return files;
	}

	public void setFiles(MultipartFile files) {
		this.files = files;
	}

	public String getDoc_id() {
		return doc_id;
	}

	public void setDoc_id(String doc_id) {
		this.doc_id = doc_id;
	}

	public String getProvider() {
		return provider;
	}

	public void setProvider(String provider) {
		this.provider = provider;
	}

	public String getFile_loc() {
		return file_loc;
	}

	public void setFile_loc(String file_loc) {
		this.file_loc = file_loc;
	}


	
}
