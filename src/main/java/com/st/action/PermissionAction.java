package com.st.action;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.st.service.IPermissionService;

@Controller
@RequestMapping("/sys")
public class PermissionAction {

	@Autowired
	IPermissionService permissionS;

	@RequestMapping("/permission_page")
	public String user_page() {
		System.out.println("访问到了permission_page");
		return "sys/permission_page";
	}

	@RequestMapping("/treeJson")
	@ResponseBody
	public List treeJson() {
		List list = permissionS.treeJson();
		return list;
	}

}
