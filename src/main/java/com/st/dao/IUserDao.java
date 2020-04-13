package com.st.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.st.bean.User;

@Repository
public interface IUserDao {

	List user_list(Map params);
	
	int user_list_total(Map params);
	
	void user_add(Map params);
	
	void user_del(Map params);
	
	void user_del_row(Map params);
	
	void user_upd(Map params);
	
	/* List user_role_list(Map params); */
	
	
	
	User getuser(String str);
}
