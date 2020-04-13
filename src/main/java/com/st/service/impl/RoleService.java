package com.st.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.st.dao.IRoleDao;
import com.st.service.IRoleService;
import com.st.util.Context;

@Service
public class RoleService implements IRoleService {
	@Autowired
	IRoleDao roleD;

	@Override
	public List role_list(Map params) {
		Context.STATE_DEL_NO(params);
		Context.page_limit(params);
		List list = roleD.role_list(params);
		return list;
	}

	@Override
	public int role_list_total(Map params) {
		int i = roleD.role_list_total(params);
		return i;
	}

	@Override
	public void role_add(Map params) {
		Context.uuid(params);
		Context.STATE_DEL_NO(params);
		roleD.role_add(params);

	}

	@Override
	public void role_del(Map params) {
		Context.STATE_DEL_YES(params);
		String role_ids = Context.toArraystr(params.get("role_ids").toString());
		params.put("role_ids", role_ids);
		roleD.role_del(params);
	}

	@Override
	public void role_del_row(Map params) {
		Context.STATE_DEL_YES(params);
		roleD.role_del_row(params);

	}

	@Override
	public void role_upd(Map params) {
		roleD.role_upd(params);

	}

	/**
	 * 查询所有的权限数据
	 */
	@Override
	public List role_permission_list(String role_id) {

		return roleD.role_permission_list("0");
	}

	/**
	 * 角色付权限
	 */
	@Transactional
	@Override
	public void save_role_perm(Map params) {
		// 删除该角色之前的权限信息
		roleD.del_role_perm(params);
		// 处理数据--string--list
		String perm_arr = (String) params.get("perm_arr");
		List list = Context.toListstr(perm_arr);
		params.put("perm_arr", list);
		// 保存新的权限数据
		roleD.save_role_perm(params);
	}

}
