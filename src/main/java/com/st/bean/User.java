package com.st.bean;

import java.util.ArrayList;
import java.util.List;

public class User {

	private String userid;
	private String username;
	private String userpass;
	private List roles;
	
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getUserpass() {
		return userpass;
	}
	public void setUserpass(String userpass) {
		this.userpass = userpass;
	}
	public List getRoles() {
		return roles;
	}
	public void setRoles(List roles) {
		this.roles = roles;
	}
	/**
	 * 方法作用：获得用户所有权限
	 * @return
	 */
	public List allPermissions() {
		List list =new ArrayList();
		for(int i=0;i<roles.size();i++) {
			Role role=(Role)roles.get(i);
			list.addAll(role.getPermissions());
		}
		return list;
	}
	
	public List<String> permissionCodes(){
		List<Permission> list=allPermissions();
		List<String> list_code=new ArrayList();
		for(Permission p:list) {
			list_code.add(p.getPerm_code());
		}
		return list_code;
	}
	
}
