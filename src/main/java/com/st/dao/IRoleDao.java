package com.st.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestParam;

@Repository
public interface IRoleDao {
	List role_list(Map params);

	int role_list_total(Map params);

	void role_add(Map params);

	void role_del(Map params);

	void role_del_row(Map params);

	void role_upd(Map params);

	List role_permission_list(String role_id);

	void save_role_perm(@RequestParam Map params);
	
	void del_role_perm(Map params);
}
