/**
 * 
 */
package com.bas.common.metadata.dao;

import java.io.IOException;
import java.io.InputStream;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.transaction.Transactional;

import org.apache.catalina.util.Base64;
import org.apache.commons.io.IOUtils;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.bas.common.core.util.HibernateFactory;
import com.bas.common.exceptions.DataAccessLayerException;
import com.bas.common.models.Packages;
import com.bas.common.models.Services;
import com.bas.common.models.Tariff;
import com.bas.workbench.bookings.vo.SearchResponse;

/**
 * @author Sandy
 *
 */
@Service
@Transactional
public class MetadataDao {
	
	@Autowired
	JdbcTemplate jdbcTemplate = null;
	
	private Session session;
    private Transaction tx;
	
    public MetadataDao(){
    	HibernateFactory.buildIfNeeded();
    }
    
    public List<Services> findAllServices(){
    	List<Services> services = null;
        try {
            startOperation();            
            org.hibernate.Query query = session.createQuery(" from Services");
            services = query.list();
            tx.commit();
        } catch (HibernateException e) {
            handleException(e);
        } finally {
            HibernateFactory.close(session);
        }
        return services;
    }
    
    /**
     * Find a Service by its primary key.
     * @param id
     * @return
     */
    public Services findServiceById(String id) throws DataAccessLayerException {
    	Services service = null;
        try {
            startOperation();
            service = (Services) session.load(Services.class, id);
            tx.commit();
        } catch (HibernateException e) {
            handleException(e);
        } finally {
            //HibernateFactory.close(session);
        }
        return service;
    }
    
    /**
     * Finds a list of package for a service.
     * @param sId
     * @return
     */
    public List<Packages> findPkgsByService(String sId) throws DataAccessLayerException{
    	List<Packages> pkgs = null;
        try {
            startOperation();
            Criteria criteria = session.createCriteria(Packages.class).add(Restrictions.eq("service.serviceId", sId));
            pkgs =  criteria.list();
            tx.commit();
        } catch (HibernateException e) {
            handleException(e);
        } finally {
            //HibernateFactory.close(session);
        }
        return pkgs;
    }
    
    public String findTariffByPkg(String pkgCode){
    	Tariff tariff = null;
    	try{
    		startOperation();
    		Criteria criteria = session.createCriteria(Tariff.class).add(Restrictions.eq("pkg.pkg_code", pkgCode));
    		tariff = (Tariff) criteria.uniqueResult();
    	} catch (HibernateException e) {
            handleException(e);
        } finally {
            //HibernateFactory.close(session);
        }
    	return String.valueOf(tariff.getTariff());
    }
    
    
    private void startOperation() throws HibernateException {
        session = HibernateFactory.openSession();
        tx = session.beginTransaction();
    }
    
    private void handleException(HibernateException e) throws DataAccessLayerException {
        HibernateFactory.rollback(tx);
        throw new DataAccessLayerException(e);
    }
    
    /**
     * Returns a list of localities per city
     * @param city
     * @return
     */
    public List<String> findLocsByCity(String city){
    	
    	StringBuffer query = new StringBuffer();
    	query.append("select distinct locality from city_zone_locality_matrix where city = ?");
    	
    	List<Map<String, Object>> results =  jdbcTemplate.queryForList(query.toString(),new Object[]{city});
    	List<String> localities = new ArrayList<>();
    	for(Map<String,Object> row : results){
    		localities.add(row.get("locality").toString());
    	}
    	
    	return localities;
    }
    
    /**
	 * Should perform search based on a few coordinates and returns a list of
	 * service providers out.
	 * 
	 * select u.id provider_id, u.customer_name provider_name, a.line_3 locality, bo.badge_code badge, bo.badge_value, bo.level
		from users u, addresses a, badges_owned bo, badge_ref_codes brc
		where a.address_id = u.address_id
		and (a.line_3 = "Madhapur" or a.line_3 in (select locality from city_zone_locality_matrix where zone = (select zone from city_zone_locality_matrix where locality = 'Madhapur')))
		and u.id = bo.provider_id
		and bo.badge_code = brc.badge_id
		order by bo.level;
	 * @param service
	 * @param city
	 * @param locality
	 * @param param1 is model
	 * @param param2 is duration
	 * @return
	 */
	public List<SearchResponse> searchProviders(String service, String city,
			String locality, String param1, String param2) {

		final String exact_loc = " and a.line_3 = ?";
		final String within_central = " and ( a.line_3 != ? and a.line_3 in ( select locality from city_zone_locality_matrix where zone = '5'  ) )";
		final String outside_zones = " and ( a.line_3 != ? and a.line_3 in ( select locality from city_zone_locality_matrix where zone not in (?,'5')  ) )";
		final String within_desiredZone = " and ( a.line_3 != ? and a.line_3 in ( select locality from city_zone_locality_matrix where zone = (select zone from city_zone_locality_matrix where locality = ?)  ) )";
		int FOUR = 4;
		
		StringBuffer query = new StringBuffer();
		query.append("select badge_code from badge_category_matrix where service = ?")
				.append(" and category = (select category from vehicle_categories where car_model = ?)");
		
		
		String badgeCode = jdbcTemplate.queryForObject(query.toString(), new Object[]{service, param1}, String.class);
		
		
		Object[] params = new Object[] { service, city, locality, badgeCode };
		List<SearchResponse> searchResponse = new ArrayList<>();
		
		// find inside exact locality
		searchForServiceProviders(searchResponse, exact_loc, params);
		
		if (searchResponse.size() < FOUR) {
			// find within zone
			params = new Object[] { service, city, locality, locality, badgeCode };
			searchForServiceProviders(searchResponse, within_desiredZone,
					params);
			if (searchResponse.size() < FOUR) {
				params = new Object[] { service, city, locality, badgeCode };

				// find within central zone
				searchForServiceProviders(searchResponse, within_central,
						params);

				if (searchResponse.size() < FOUR) {
					params = new Object[] { service, city, locality, locality, badgeCode };

					searchForServiceProviders(searchResponse, outside_zones,
							params);
				}
			}
		}
		
		// determine prices
		query = new StringBuffer();
		query.append("select tariff from category_wise_tariff where category = (select category from vehicle_categories where car_model = ?) and duration = ?");
		double baseTariff = jdbcTemplate.queryForObject(query.toString(), new Object[]{param1, Integer.parseInt(param2.toString())}, Double.class);
		for(SearchResponse resp : searchResponse){
			if(resp.getRating() >= FOUR){
				resp.setTariff(baseTariff+100); //TODO this 100 should come from properties file
			}else
				resp.setTariff(baseTariff);
		}
		
		// pull images
		for(SearchResponse provider : searchResponse){
			byte[] image = getImageBytes(provider.getProvider(), "PROFILE_PIC");
			provider.setPic(Base64.encode(image));
		}
		
		return searchResponse;
	}
	
	private void searchForServiceProviders(List<SearchResponse> searchResponse, String zonalSubQuery, Object[] params){
		
		int FOUR = 4;
		StringBuffer query = new StringBuffer();
		query.append(
				"select distinct u.id provider_id, u.customer_name provider_name, a.line_3 locality, bo.badge_code badge, bo.badge_value, bo.level rating")
				.append(" from users u, addresses a, badges_owned bo, badge_ref_codes brc")
				.append(" where u.type = 'PROVIDER' and u.status = 'ACTIVE' and a.userid = u.id")
				.append(" and u.service_id = ?").append(" and a.city = ?")
				.append(zonalSubQuery)
				.append(" and u.id = bo.provider_id")
				.append(" and bo.badge_code = brc.badge_id and bo.badge_code = ?")
				.append(" order by bo.level desc");

		List<Map<String, Object>> results = jdbcTemplate.queryForList(
				query.toString(), params);

		List<SearchResponse> inZone = new ArrayList<>();
		if(results.size() > 0){
			if(searchResponse.size() < 1)
				searchResponse.addAll(buildResponse(results, params[0].toString()));
			else {
				inZone = buildResponse(results, params[0].toString());
				if(searchResponse.size() < FOUR && inZone.size() > 0 && inZone.size() >= FOUR - searchResponse.size()){
					
					for(SearchResponse inObj : inZone){
						searchResponse.add(inObj);
						if(searchResponse.size() == FOUR)
							break;
					}
				 }
			}
		}
		
	}
	
	private List<SearchResponse> buildResponse(List<Map<String, Object>> results, String service){
		
		List<SearchResponse> searchResponse = new ArrayList<>();
		List<String> providersAdded = new ArrayList<>();
		
		for (Map<String, Object> row : results) {
			SearchResponse resp = new SearchResponse();
			String provider = row.get("provider_id").toString();
			resp.setProvider(provider);
			resp.setLocality(row.get("locality").toString());
			resp.setName(row.get("provider_name").toString());
			resp.setService(service);
			
			if (providersAdded.size() > 0 && providersAdded.contains(provider)) {		
				System.out.println("found a provider in list : "+provider);
				for(SearchResponse obj : searchResponse){
					System.out.println("obj provider :"+obj.getProvider());
					if(obj.getProvider().equalsIgnoreCase(provider)){
						obj.getBadges().put(row.get("badge").toString(),row.get("badge_value").toString());
						//obj.getBadges().put(row.get("badge").toString()+"_"+row.get("badge_value").toString(), row.get("rating").toString());
						obj.setRating(Integer.parseInt(row.get("rating").toString()));
						System.out.println("added badge_value : "+row.get("badge_value").toString()+" to provider : "+provider);
						break;
					}
					
				}
				
			}else {
				System.out.println("added provider to list : "+provider);
				resp.getBadges().put(row.get("badge").toString(),row.get("badge_value").toString());
				resp.setRating(Integer.parseInt(row.get("rating").toString()));
				searchResponse.add(resp);
				providersAdded.add(row.get("provider_id").toString());
			}

		}
		
		return searchResponse;
	}
	
	public byte[] getImageBytes(String provider_id, String doc_id){
		
		StringBuffer query = new StringBuffer();
		query.append("select doc_copy from proof_documents where provider_id = '"+provider_id+"' and doc_id = '"+doc_id+"'");
		List<byte[]> rows = null;
		try{
			rows = jdbcTemplate.query(query.toString(),new RowMapper<byte[]>(){
				public byte[] mapRow(ResultSet rs, int rownumber) throws SQLException {  
			        InputStream ins = rs.getBinaryStream("doc_copy");
			        try {
						return IOUtils.toByteArray(ins);
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
						throw new SQLException(e.getMessage());
					}
			        /*ByteArrayOutputStream baos = new ByteArrayOutputStream();
			        int reads = ins.read();
			        while(reads != -1){
			        	baos.write(reads);
			        	reads = ins.read();
			        }
					return baos.toByteArray(); */ 
			    }  
			});
		}catch(DataAccessException dae){
			//TODO
			dae.printStackTrace();
			throw new DataAccessLayerException(dae.getMessage());
		}
		
		return rows.get(0);
		
	}
	
	public List<String> findAllModels(){
		StringBuffer query = new StringBuffer();
		query.append("select distinct car_model from vehicle_categories");
		
		List<String> models = jdbcTemplate.queryForList(query.toString(), String.class);
		
		return models;
	}

}
