package com.st.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.st.dao.IPermissionDao;
import com.st.service.IPermissionService;

@Service
public class PermissionService implements IPermissionService{

	@Autowired
	IPermissionDao permissionD;

	public List treeJson() {
		return permissionD.treeJson();
	}

}
