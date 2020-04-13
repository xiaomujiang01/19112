package com.st.dao;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Repository;

@Repository
public interface ICustomerDao {

	List customer_list(Map params);

	int customer_list_total(Map params);

	void customer_add(Map params);

	void customer_del(Map params);
	
	void customer_del_row(Map params);
	
	void customer_upd(Map params);

	int public_customer_list_total(Map params);

	List public_customer_list(Map params);
	
	void public_customer_add(Map params);

	void public_customer_private_row(Map params);
	
	void public_customer_private(Map params);
	
	void public_customer_upd(Map params);

	int private_customer_list_total(Map params);

	List private_customer_list(Map params);
	
	List private_all_customer_list(Map params);
	void public_customer(Map params);
	
	List visit_partten_list();
	
	void visit_customer( Map params);
	void visit_selected_email(Map params);
	
	List no_visit_list(Map params);
	void init_tip(Map params);
	List visit_infos(Map params);
	int visit_infos_total(Map params);
}
