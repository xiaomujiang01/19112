package com.st.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.bind.annotation.RequestParam;

public interface IRoleService {

	List role_list(Map params);

	int role_list_total(Map params);

	void role_add(Map params);

	void role_del(Map params);

	void role_del_row(Map params);

	void role_upd(Map params);

	List role_permission_list(String role_id);

	void save_role_perm(@RequestParam Map params);

}
