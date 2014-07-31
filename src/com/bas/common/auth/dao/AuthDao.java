/**
 * 
 */
package com.bas.common.auth.dao;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.awt.image.DataBufferByte;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.imageio.stream.ImageInputStream;
import javax.transaction.Transactional;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCallback;
import org.springframework.stereotype.Service;

import com.bas.common.core.util.HibernateFactory;
import com.bas.common.exceptions.DataAccessLayerException;
import com.bas.common.exceptions.ServiceLayerException;
import com.bas.common.models.Address;
import com.bas.common.models.User;
import com.bas.workbench.profiles.va.BadgesOwned;
import com.bas.workbench.profiles.va.Files;
import com.bas.workbench.profiles.va.ProfileObject;
import com.bas.workbench.profiles.va.ProfileReferences;

/**
 * @author Sandy
 *
 */
@Service
@Transactional
public class AuthDao {
	
	//private Session session;
    private Transaction tx;
    
    @Autowired
    JdbcTemplate jdbcTemplate = null;
	
   /* public AuthDao() {
        HibernateFactory.buildIfNeeded();
    }*/
	
   /* *//**
     * Insert a new BookingRequest into the database.
     * @param booking
     *//*
    public void save(User user) throws DataAccessLayerException {
        try {
            startOperation();
            session.saveOrUpdate(user);
            tx.commit();
        } catch (HibernateException e) {
            handleException(e);
        } finally {
            HibernateFactory.close(session);
        }
    }*/
    
    
    
    
   /* public List<User> findByUser(String id) throws DataAccessLayerException {
    	User user = null;
        try {
        	// TODO
            startOperation();
            booking = (BookingRequest) session.load(BookingRequest.class, id);
            tx.commit();
        } catch (HibernateException e) {
            handleException(e);
        } finally {
            //HibernateFactory.close(session);
        }
        return null;//booking;
    }
    
    public boolean delete(String id){
    	// TODO
    	return true;
    }*/
    
    /**
     * Finds all Events in the database.
     * @return
     *//*
    @SuppressWarnings("unchecked")
	public List<User> findAll() throws DataAccessLayerException{
        List<User> user = null;
        try {
            startOperation();
            Query query = session.createQuery(" from User");
            user =  query.list();
            tx.commit();
        } catch (HibernateException e) {
            handleException(e);
        } finally {
            //HibernateFactory.close(session);
        }
        return user;
    }
    
    private void startOperation() throws HibernateException {
        session = HibernateFactory.openSession();
        tx = session.beginTransaction();
    }
    
    private void handleException(HibernateException e) throws DataAccessLayerException {
        HibernateFactory.rollback(tx);
        throw new DataAccessLayerException(e);
    }
    
    *//**
     * Find a Booking by its primary key.
     * @param id
     * @return
     *//*
    public User findById(String id) throws DataAccessLayerException {
    	User user = null;
        try {
            startOperation();
            user = (User) session.load(User.class, id);
            tx.commit();
        } catch (HibernateException e) {
            handleException(e);
            return null;
        } finally {
            //HibernateFactory.close(session);
        }
        return user;
    }*/
    
    public User findById(String id) throws DataAccessLayerException {
    	
    	return null;
    }
    public boolean findAvailability(String id){
    	
    	StringBuffer query = new StringBuffer("select id from users where id = ?");
    	List<Map<String,Object>> rows = null;
    	try{
    		rows = jdbcTemplate.queryForList(query.toString(),new Object[]{id});
    	}catch(DataAccessException dae){
    		//TODO
    		dae.printStackTrace();
    		System.out.println(dae.getMessage());
    		throw new DataAccessLayerException("Failed to find availability - "+id+" : "+dae.getMessage());
    	}
    	
    	// login failed
    	if(rows == null || rows.size() == 0 || rows.size() > 1){
    		return false;
    	}else 
    		return true;
    }
    
    // use for login or find a user object
    public User findUserById(String id, String pwd){
    	
    	StringBuffer query = new StringBuffer("select id, address_id, customer_name, customer_mobile, type, service_id from users where id = ? and password = ?");
    	List<Map<String,Object>> rows = null;
    	try{
    		rows = jdbcTemplate.queryForList(query.toString(),new Object[]{id,pwd});
    	}catch(DataAccessException dae){
    		//TODO
    		dae.printStackTrace();
    		System.out.println(dae.getMessage());
    	}
    	
    	// login failed
    	if(rows.size() != 1){
    		return null;
    	}
    	
    	Map<String,Object> row = rows.get(0);
    	// convert to user
    	User user = new User();
    	user.setId(row.get("id").toString());
    	user.setType(row.get("type").toString());
    	user.setName(row.get("customer_name").toString());
    	user.setMobile(row.get("customer_mobile").toString());
    	user.setPassword(pwd);
    	
	    if(user.getType().equals("PROVIDER")) {
	    	query = new StringBuffer("select address_id,line_1, line_2, line_3, city, zipcode, state, country from addresses where address_id = ?");
	    	
	    	try{
	    		rows = jdbcTemplate.queryForList(query.toString(),new Object[]{Integer.parseInt(row.get("address_id").toString())});
	    	}catch(DataAccessException dae){
	    		//TODO
	    		dae.printStackTrace();
	    		System.out.println(dae.getMessage());
	    	}
	    	
	    	// build address
	    	row = rows.get(0);    	
	    	Address address = new Address();
	    	address.setAddress_id(row.get("address_id").toString());
	    	address.setLine_1(row.get("line_1").toString());
	    	address.setLine_2(row.get("line_2").toString());
	    	address.setLine_3(row.get("line_3").toString());
	    	address.setCity(row.get("city").toString());
	    	address.setState(row.get("zipcode").toString());
	    	address.setZipcode(row.get("state").toString());
	    	address.setCountry(row.get("country").toString());
	    	
	    	user.setAddress(address);
	    }
    	// TODO
    	// ref docs for provider
    	
    	return user;
    }
    
    public boolean activateUserById(String id){
    	StringBuffer query = new StringBuffer();
    	query.append("update users set status = '"+"ACTIVE"+"' where id = '"+id+"'");
    	
    	try{
    		jdbcTemplate.execute(query.toString());
    	}catch(DataAccessException dae){
    		dae.printStackTrace();
    		System.out.println(dae.getMessage());
    		throw new DataAccessLayerException("Failed to Activate account - "+id+" : "+dae.getMessage());
    		//return false;
    	}
    	return true;
    }
    
    public boolean createAccount(User user){
    	
    	StringBuffer query = new StringBuffer();
    	String column = ",status";
    	String value = ",'ACTIVE'";
    	if(user.getType().equals("USER")){
    		column = "";
    		value = "";
    	}
    	query.append("insert into users(id,password,customer_name,customer_mobile,type,service_id"+column+") values('"+user.getId()+"','"+user.getPassword()+"','"
    									+user.getName()+"','"+user.getMobile()+"','"+user.getType()+"','"+user.getService_id()+"'"+value+")");
    	
    	try{
    		jdbcTemplate.execute(query.toString());
    	}catch(DataAccessException dae){
    		dae.printStackTrace();
    		System.out.println(dae.getMessage());
    		throw new DataAccessLayerException("Failed to create account : "+dae.getMessage());
    		//return false;
    	}
    	
    	return true;
    }
    
    @Transactional
    public boolean saveProfile(ProfileObject prof){
    	final String provider_id = prof.getCustomer_id();
    	
    	// create account
    	createAccount(prof.getUser());
    	
    	// create address.
    	StringBuffer query = new StringBuffer();
    	
    	query.append("insert into addresses(userid, addr_type, line_1, line_2, line_3, city, state, zipcode, country) "
    			+ "values('"+provider_id+"','PROFILE_ADDR','"+prof.getAddress().getLine_1()+"','"+prof.getAddress().getLine_2()+"','"+prof.getAddress().getLine_3()+"','"+prof.getAddress().getCity()+"','"
    			+prof.getAddress().getState()+"','"+prof.getAddress().getZipcode()+"','"+prof.getAddress().getCountry()+"')");
    	
    	try{
    		jdbcTemplate.execute(query.toString());
    	}catch(DataAccessException dae){
    		//TODO
    		dae.printStackTrace();
    		System.out.println(dae.getMessage());
    		throw new DataAccessLayerException("Failed to insert address : "+dae.getMessage());
    	}
    	
    	// badges
    	BadgesOwned badges = prof.getBadgesOwned();
    	Map<String,String> rows = parseBadges(badges);
    	for(Map.Entry<String, String> entry : rows.entrySet()){
    		query = new StringBuffer();
	    	query.append("insert into badges_owned(provider_id,badge_code,badge_value,level) values('"+prof.getCustomer_id()+"','"+entry.getKey()+"','"+entry.getValue()+"','3')");
	    	try{
	    		jdbcTemplate.execute(query.toString());
	    	}catch(DataAccessException dae){
	    		//TODO
	    		dae.printStackTrace();
	    		System.out.println(dae.getMessage());
	    		throw new DataAccessLayerException("Failed to insert badges : "+dae.getMessage());
	    	}
    	}
    	
    	// create reference    	
    	if(prof.getRefs() != null){
    		for(ProfileReferences ref : prof.getRefs()){    			
    			if(ref.getRefName() != null && ref.getRefContactNum() != null && ref.getRefName().length() > 0 && ref.getRefContactNum().length() > 0 ){
    				query = new StringBuffer();
    		    	query.append("insert into provider_reference_contacts values('"+prof.getCustomer_id()+"','"+ref.getRefName()+"','"+ref.getRefContactNum()+"')");
    		    	try{
    		    		jdbcTemplate.execute(query.toString());
    		    	}catch(DataAccessException dae){
    		    		//TODO
    		    		dae.printStackTrace();
    		    		System.out.println(dae.getMessage());
    		    		throw new DataAccessLayerException("Failed to insert references : "+dae.getMessage());
    		    	}
    			}
    		}
    	}
    	
    	// add docs 
    	for(Files file : prof.getFiles()){ 
    		final String doc_id = file.getDoc_id();
    		byte[] bytes = convertFileToBytes(file);
    		//System.out.println("original image size : "+bytes.length);
			
    		final InputStream stream = convertToInputStream(file);
    		query = new StringBuffer();
    		query.append("insert into proof_documents(provider_id, doc_id, doc_copy) values(?,?,?)");
    		
    		 
    		try{
    			jdbcTemplate.execute(query.toString(),new PreparedStatementCallback<Boolean>(){  
        		    @Override  
        		    public Boolean doInPreparedStatement(PreparedStatement ps)  
        		            throws SQLException, DataAccessException {  
        		        
        		    	ps.setString(1, provider_id);
        		    	ps.setString(2, doc_id);
        		    	ps.setBinaryStream(3, stream);
        		    	
        		        return ps.execute();  
        		              
        		    }  
        		    }); 
	    	}catch(DataAccessException dae){
	    		//TODO
	    		dae.printStackTrace();
	    		System.out.println(dae.getMessage());
	    		throw new DataAccessLayerException("Failed to insert proof_documents : "+dae.getMessage());	    		
	    	}
    	}
    	return true;
    }
    
    public boolean saveRefDocs(Files file){
    	
    	StringBuffer query = new StringBuffer();
    	try {
			query.append("insert into proof_documents(provider_id,doc_id,doc_copy) values ('"+file.getProvider()+"','"+file.getDoc_id()+"','"+file.getFiles().getInputStream()+"')");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	try{
    		jdbcTemplate.execute(query.toString());
    	}catch(DataAccessException dae){
    		//TODO
    		dae.printStackTrace();
    		System.out.println(dae.getMessage());
    		return false;
    	}
    	
    	return true;
    }
    
    public boolean subscribeUser(String email){
    	
    	String query = "insert into subscriptions(id,status) values('"+email+"', 'ACTIVE')";
    	
    	try{
    		jdbcTemplate.execute(query);
    	}catch(DataAccessException dae){
    		dae.printStackTrace();
    		System.out.println(dae.getMessage());
    		return false;
    	}
    	return true;
    	
    }
    
    
    //######### Private methods ###########    
    
    private Map<String, String> parseBadges(BadgesOwned badges){
    	
    	Map<String,String> row = new HashMap<>();
    	
    	if(badges.getParam1() != null && badges.getParam1().length() > 0 && badges.getValue1() != null && badges.getValue1().length() > 0)
    		row.put(badges.getParam1(), badges.getValue1());
    	if(badges.getParam2() != null && badges.getParam2().length() > 0 && badges.getValue2() != null && badges.getValue2().length() > 0)
    		row.put(badges.getParam2(), badges.getValue2());
    	if(badges.getParam3() != null && badges.getParam3().length() > 0 && badges.getValue3() != null && badges.getValue3().length() > 0)
    		row.put(badges.getParam3(), badges.getValue3());
    	if(badges.getParam4() != null && badges.getParam4().length() > 0 && badges.getValue4() != null && badges.getValue4().length() > 0)
    		row.put(badges.getParam4(), badges.getValue4());
    	if(badges.getParam5() != null && badges.getParam5().length() > 0 && badges.getValue5() != null && badges.getValue5().length() > 0)
    		row.put(badges.getParam5(), badges.getValue5());
    	
    	return row;
    }
    
    private byte[] convertFileToBytes(Files file){
    
    	try {
			return file.getFiles().getBytes();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
    }
    
    private InputStream convertToInputStream(Files file){
    	try {
			return resizeImageFile(file.getFiles().getInputStream());
		} catch (IOException e) {
			// TODO Auto-generated catch block			
			e.printStackTrace();
			return null;
		}
    }
    
    private InputStream resizeImageFile(InputStream is){
    	
    	try {
    		BufferedImage originalImage = ImageIO.read(is);
    		
			// not an image
			if(originalImage == null){
				return is;
			}
			int type = originalImage.getType() == 0? BufferedImage.TYPE_INT_ARGB : originalImage.getType();
			//if(type)
			BufferedImage resizedImage = resizeImage(originalImage, type);
			byte[] buffer = ((DataBufferByte)(resizedImage).getRaster().getDataBuffer()).getData();
			
			//System.out.println("resized image size : "+buffer.length);
			return new ByteArrayInputStream(buffer);
			
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	return is;
    }
    
    private static BufferedImage resizeImage(BufferedImage originalImage, int type){
    	final int IMG_WIDTH = 160;
    	final int IMG_HEIGHT = 160;
    	
    	BufferedImage resizedImage = new BufferedImage(IMG_WIDTH, IMG_HEIGHT, type);
    	Graphics2D g = resizedImage.createGraphics();
    	g.drawImage(originalImage, 0, 0, IMG_WIDTH, IMG_HEIGHT, null);
    	g.dispose();
     
    	return resizedImage;
        }
}
