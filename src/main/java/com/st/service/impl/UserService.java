package com.st.service.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.st.bean.User;
import com.st.dao.IUserDao;
import com.st.service.IUserService;
import com.st.util.Context;
@Service
public class UserService implements IUserService{

	@Autowired
	IUserDao userD;
	
	
	@Override
	public List user_list(Map params) {
		Context.STATE_DEL_NO(params);
		Context.page_limit(params);
		List list=userD.user_list(params);
		return list;
	}

	@Override
	public int user_list_total(Map params) {
		Context.STATE_DEL_NO(params);
		int i=userD.user_list_total(params);
		return i;
	}

	@Override
	public void user_add(Map params) {
		Context.uuid(params);
		Context.STATE_DEL_NO(params);
		params.put("birthday", "1998");
		//将密码通过MD5盐值加密
		SimpleHash sh=new SimpleHash("md5", "123456", params.get("uuid"));
		params.put("userpass", sh.toString());
		userD.user_add(params);
	}

	@Override
	public void user_del(Map params) {
		Context.STATE_DEL_YES(params);
		String userids=Context.toArraystr(params.get("userids").toString());
		params.put("userids", userids);
		userD.user_del(params);
	}

	@Override
	public void user_del_row(Map params) {
		Context.STATE_DEL_YES(params);
		userD.user_del_row(params);
	}
	
	@Override
	public void user_upd(Map params) {
		userD.user_upd(params);
		
	}

	/*
	 * @Override public List user_role_list(Map params) { List
	 * list=userD.user_role_list(params); return list; }
	 */
	
	
	
	
	@Override
	public User getuser(String str) {
		return userD.getuser(str);
		
	}


	
}
