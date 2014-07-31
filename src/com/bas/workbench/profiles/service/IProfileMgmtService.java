package com.bas.workbench.profiles.service;

import java.util.List;

import com.bas.common.models.User;
import com.bas.workbench.profiles.va.Files;
import com.bas.workbench.profiles.va.ProfileObject;

public interface IProfileMgmtService {	

	// BookingRequest API's
	List<User> findAll();

	void save(User user);
	
	void saveRefDocs();

	User findById(String userId);

	void deleteById(String userId);

	boolean createAccount(User user);

	boolean saveProfile(ProfileObject prof);

	boolean saveRefDocs(Files file);

	boolean processDocumentUploads(List<Files> filesUploaded);
}
