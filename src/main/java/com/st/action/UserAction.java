package com.st.action;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.st.service.IUserService;
import com.st.util.TableJSON;

@Controller
@RequestMapping("/sys")
public class UserAction {
	@Autowired
	IUserService userS;

	@RequestMapping("/tosystem")
	public String toSystem() {
		return "sys/system";
	}

	@RequestMapping("/user_page")
	public String user_page() {
		System.out.println("访问到了user_page");
		return "sys/user_page";
	}

	@RequestMapping("/user_list")
	@ResponseBody
	public TableJSON user_list(@RequestParam Map params) {
		List list=userS.user_list(params);
		int total=userS.user_list_total(params);
		return TableJSON.tablejson(list, total);
	}
	
	@RequestMapping("/user_add")
	@ResponseBody
	public void user_add(@RequestParam Map params) {
		userS.user_add(params);
	}
	
	@RequestMapping("/user_del")
	@ResponseBody
	public void user_del(@RequestParam Map params) {
		userS.user_del(params);
	}
	
	@RequestMapping("/user_del_row")
	@ResponseBody
	public void user_del_row(@RequestParam Map params) {
		userS.user_del_row(params);
	}
	
	@RequestMapping("/user_upd")
	@ResponseBody
	public void user_upd(@RequestParam Map params) {
		userS.user_upd(params);
	}
	
	
	/*
	 * @RequestMapping("/user_role_list")
	 * 
	 * @ResponseBody public TableJSON user_role_list(@RequestParam Map params) {
	 * List list=userS.user_list(params); return TableJSON.tablejson_perm(list); }
	 */
}
