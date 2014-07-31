/**
 * 
 */
package com.bas.workbench.profiles.dao;

import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bas.common.core.util.HibernateFactory;
import com.bas.common.exceptions.DataAccessLayerException;
import com.bas.common.models.User;

/**
 * @author Sandy
 *
 */
@Service
@Transactional
public class ProfileMgmtDao {
	
	private Session session;
    private Transaction tx;
	
    public ProfileMgmtDao() {
        HibernateFactory.buildIfNeeded();
    }
	
    /**
     * Insert a new BookingRequest into the database.
     * @param user
     */
    /*public void create(User user) throws DataAccessLayerException {
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
    
    /**
     * Updates the state of a Booking.
     *
     * @param user
     */
    /*public void update(User user) throws DataAccessLayerException {
        try {
            startOperation();
            session.update(user);
            tx.commit();
        } catch (HibernateException e) {
            handleException(e);
        } finally {
            HibernateFactory.close(session);
        }
    }*/
	
    
    /**
     * Find a Booking by its primary key.
     * @param id
     * @return
     */
    /*public User findById(Long id) throws DataAccessLayerException {
    	User user = null;
        try {
            startOperation();
            user = (User) session.load(User.class, id);
            tx.commit();
        } catch (HibernateException e) {
            handleException(e);
        } finally {
            //HibernateFactory.close(session);
        }
        return user;
    }*/
    
    /*public List<User> findByUser(String id) throws DataAccessLayerException {
    	User user = null;
        try {
        	// TODO
            startOperation();
            user = (BookingRequest) session.load(BookingRequest.class, id);
            tx.commit();
        } catch (HibernateException e) {
            handleException(e);
        } finally {
            //HibernateFactory.close(session);
        }
        return null;//user;
    }*/
    
    public boolean delete(Long id){
    	// TODO
    	return true;
    }
    
    /**
     * Finds all Events in the database.
     * @return
     */
    @SuppressWarnings("unchecked")
	public List<User> findAll() throws DataAccessLayerException{
        List<User> users = null;
        try {
            startOperation();
            Query query = session.createQuery(" from User");
            users =  query.list();
            tx.commit();
        } catch (HibernateException e) {
            handleException(e);
        } finally {
            //HibernateFactory.close(session);
        }
        return users;
    }
    
    private void startOperation() throws HibernateException {
        session = HibernateFactory.openSession();
        tx = session.beginTransaction();
    }
    
    private void handleException(HibernateException e) throws DataAccessLayerException {
        HibernateFactory.rollback(tx);
        throw new DataAccessLayerException(e);
    }

}
