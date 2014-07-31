/**
 * 
 */
package com.bas.workbench.profiles.service.impl;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;

import javax.mail.MessagingException;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bas.common.auth.dao.AuthDao;
import com.bas.common.exceptions.DataAccessLayerException;
import com.bas.common.exceptions.ServiceLayerException;
import com.bas.common.models.User;
import com.bas.common.notification.email.NotificationUtil;
import com.bas.workbench.profiles.service.IProfileMgmtService;
import com.bas.workbench.profiles.va.Files;
import com.bas.workbench.profiles.va.ProfileObject;

/**
 * @author Sandy
 *
 */
@Service
public class ProfileMgmtServiceImpl implements IProfileMgmtService {

	@Autowired
	private AuthDao authDao;
	
	@Autowired
	private NotificationUtil notify;
	
	/*@Override
	public List<User> findAll() {
		return authDao.findAll();
	}

	@Override
	public void save(User user) {
		authDao.save(user);
	}

	@Override
	public User findById(String userId) {
		return authDao.findById(userId);
	}

	@Override
	public void deleteById(String userId) {
		authDao.delete(userId);
	}

	@Override
	public void saveRefDocs() {
		// TODO Auto-generated method stub
		
	}*/
	
	@Override
	@Transactional
	public boolean createAccount(User user){
		boolean accountCreated = false;
		
		try{
			accountCreated = authDao.createAccount(user);
		}catch(DataAccessLayerException dale){
			throw new ServiceLayerException(dale.getMessage());
		}
		
		if(accountCreated == true ){
			
			boolean isCustomer = user.getType().equals("USER");
			// send notification
			System.out.println("sending email notification");
			try {
				notify.notifyAccountConfirmation(user, isCustomer);
			} catch (MessagingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				throw new ServiceLayerException(e.getMessage());
			}
		}		
		return accountCreated;
	}
	
	@Override
	@Transactional
	public boolean saveProfile(ProfileObject prof){
		return authDao.saveProfile(prof);
	}

	@Override
	public boolean saveRefDocs(Files file) {
		return authDao.saveRefDocs(file);
	}
	
	@SuppressWarnings("resource")
	@Override
	public boolean processDocumentUploads(List<Files> filesUploaded){
		
		InputStream inputStream = null;
		OutputStream outputStream = null;
		String fileName = null;
		String loc = "C:\\tools\\";
		for (Files file : filesUploaded) {
			try {

				inputStream = file.getFiles().getInputStream();
				fileName = filesUploaded.get(0).getFiles()
						.getOriginalFilename();
				outputStream = new FileOutputStream(new File(loc + fileName));
				int read = 0;
				byte[] bytes = new byte[1024];

				while ((read = inputStream.read(bytes)) != -1) {
					outputStream.write(bytes, 0, read);
				}

			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				throw new ServiceLayerException("Issue processing uploaded docs : "+e.getMessage());
			}
			
			// add location
			file.setFile_loc(loc + fileName);
		}
			
		return true;
	}

	@Override
	public List<User> findAll() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void save(User user) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void saveRefDocs() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public User findById(String userId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void deleteById(String userId) {
		// TODO Auto-generated method stub
		
	}
	

}
