package com.st.action;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.st.service.IRoleService;
import com.st.util.TableJSON;

@Controller
@RequestMapping("/sys")
public class RoleAction {

	@Autowired
	IRoleService roleS;

	/**
	 * 跳转角色页面
	 * 
	 * @return
	 */
	@RequestMapping("/role_page")
	public String user_page() {
		return "sys/role_page";
	}

	/**
	 * 角色分配权限
	 * 
	 * @param params role_id --分配权限的角色ID
	 * @return
	 */
	@RequestMapping("/role_permission_page/{role_id}")
	public String role_permission_page(@PathVariable String role_id, HttpServletRequest request) {
		request.setAttribute("role_id", role_id);
		return "sys/role_permission_page";
	}

	@RequestMapping("/role_list")
	@ResponseBody
	public TableJSON bumen_list(@RequestParam Map params) {
		List list = roleS.role_list(params);
		int total = roleS.role_list_total(params);
		return TableJSON.tablejson(list, total);
	}

	@RequestMapping("/role_add")
	@ResponseBody
	public void role_add(@RequestParam Map params) {
		roleS.role_add(params);
	}

	@RequestMapping("/role_del")
	@ResponseBody
	public void role_del(@RequestParam Map params) {
		roleS.role_del(params);
	}

	@RequestMapping("/role_del_row")
	@ResponseBody
	public void role_del_row(@RequestParam Map params) {
		roleS.role_del_row(params);
	}

	@RequestMapping("/role_upd")
	@ResponseBody
	public void role_upd(@RequestParam Map params) {
		roleS.role_upd(params);
	}

	/**
	 * 查询权限数据 --最好能够有已选中的数据
	 * 
	 * @return
	 */
	@RequestMapping("/role_permission_list/{role_id}")
	@ResponseBody
	public List role_permission_list(@PathVariable String role_id) {
		return roleS.role_permission_list(role_id);

	}

	@RequestMapping("/save_role_perm")
	@ResponseBody
	public void save_role_perm(@RequestParam Map params) {
		roleS.save_role_perm(params);

	}

//	@RequestMapping("/permission_list")
//	@ResponseBody
//	public List permission_list() {
////		roleS.role_upd(params);
//	}

}
