package com.st.action;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.st.service.ICustomerService;
import com.st.util.TableJSON;

@Controller
@RequestMapping("/sys")
public class CustomerAction {

	@Autowired
	ICustomerService customerS;
	
	@RequestMapping("/customer_page")
	public String user_page() {
		System.out.println("访问到了customer_page");
		return "sys/customer_page";
	}
	
	@RequestMapping("/customer_list")
	@ResponseBody
	public TableJSON customer_list(@RequestParam Map params) {
		List list=customerS.customer_list(params);
		int total=customerS.customer_list_total(params);
		return TableJSON.tablejson(list, total);
	}
	
	@RequestMapping("/customer_add")
	@ResponseBody
	public void customer_add(@RequestParam Map params) {
		customerS.customer_add(params);
	}
	
	@RequestMapping("/customer_del")
	@ResponseBody
	public void customer_del(@RequestParam Map params) {
		customerS.customer_del(params);
	}
	
	@RequestMapping("/customer_del_row")
	@ResponseBody
	public void customer_del_row(@RequestParam Map params) {
		customerS.customer_del_row(params);
	}
	
	@RequestMapping("/customer_upd")
	@ResponseBody
	public void customer_upd(@RequestParam Map params) {
		customerS.customer_upd(params);
	}
	
	@RequestMapping("/public_customer_page")
	public String public_user_page() {
		return "sys/public_customer_page";
	}
	
	@RequestMapping("/public_customer_list")
	@ResponseBody
	public TableJSON public_customer_list(@RequestParam Map params) {
		List list=customerS.public_customer_list(params);
		int total=customerS.public_customer_list_total(params);
		return TableJSON.tablejson(list, total);
	}
	
	@RequestMapping("/public_customer_add")
	@ResponseBody
	public void public_customer_add(@RequestParam Map params) {
		customerS.public_customer_add(params);
	}
	
	@RequestMapping("/public_customer_private_row")//跟单操作
	@ResponseBody
	public void public_customer_private_row(@RequestParam Map params,HttpSession session) {
		customerS.public_customer_private_row(params,session);
	}
	
	@RequestMapping("/public_customer_private")//跟单操作
	@ResponseBody
	public void public_customer_private(@RequestParam Map params,HttpSession session) {
		customerS.public_customer_private(params,session);
	}
	/**
	 * 放弃跟单
	 * @param params
	 * @param session
	 */
	@RequestMapping("/public_customer")
	@ResponseBody
	public void public_customer(@RequestParam Map params) {
		customerS.public_customer(params);
	}
	
	
	
	
	
	@RequestMapping("/public_customer_upd")
	@ResponseBody
	public void public_customer_upd(@RequestParam Map params) {
		customerS.public_customer_upd(params);
	}
	
	@RequestMapping("/private_customer_page")
	public String private_user_page() {
		return "sys/private_customer_page";
	}
	
	@RequestMapping("/private_customer_list")
	@ResponseBody
	public TableJSON private_customer_list(@RequestParam Map params,HttpSession session) {
		List list=customerS.private_customer_list(params,session);
		int total=customerS.private_customer_list_total(params,session);
		return TableJSON.tablejson(list, total);
	}
	
	@RequestMapping("/visit_partten_list")
	@ResponseBody
	public List visit_partten_list() {
		List list=customerS.visit_partten_list();
		return list;
	}
	
	@RequestMapping("/visit_customer")
	@ResponseBody
	public void visit_customer(@RequestParam Map params,HttpSession session) {
		customerS.visit_customer(params, session);
	}
	@RequestMapping("/visit_all_customer")
	@ResponseBody
	public void visit_all_customer(@RequestParam Map params,HttpSession session) {
		customerS.visit_all_customer(params, session);
	}
	@RequestMapping("/visit_selected_email")
	@ResponseBody
	public void visit_selected_email(@RequestParam Map params) {
		customerS.visit_selected_email(params);
	}
	
	@RequestMapping("/visit_all_email")
	@ResponseBody
	public void visit_all_email(@RequestParam Map params,HttpSession session) {
		customerS.visit_all_email(params,session);
	}
	/**
	 * 	跳转到指定客户的回访信息页面
	 * @param customer_id
	 * @return
	 */
	@RequestMapping("/visit_infos_page/{customer_id}")
	public String visit_infos(@PathVariable String customer_id,HttpServletRequest request) {
		request.setAttribute("customer_id", customer_id);
		return "sys/visit_infos";
	}
	
	@RequestMapping("/visit_infos/{customer_id}")
	@ResponseBody
	public TableJSON visit_infos(@PathVariable String customer_id,@RequestParam Map params) {
		//查询customer_id对应的回访信息数据
		params.put("customer_id", customer_id);
		System.out.println(params);
		List list=customerS.visit_infos(params);
		int total=customerS.visit_infos_total(params);
		return TableJSON.tablejson(list, total);
	}
	
}
