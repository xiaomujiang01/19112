package com.st.service.impl;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.MessagingException;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.st.bean.User;
import com.st.dao.ICustomerDao;
import com.st.service.ICustomerService;
import com.st.util.Context;
import com.st.util.Email;
@Service
public class CustomerService implements ICustomerService{

	@Autowired
	ICustomerDao customerD;
	
	@Override
	public List customer_list(Map params) {
		Context.STATE_DEL_NO(params);
		Context.page_limit(params);
		List list=customerD.customer_list(params);
		return list;
	}

	@Override
	public int customer_list_total(Map params) {
		Context.STATE_DEL_NO(params);
		int i=customerD.customer_list_total(params);
		return i;
	}

	@Override
	public void customer_add(Map params) {
		Context.uuid(params);
		Context.STATE_DEL_NO(params);
		customerD.customer_add(params);
	}

	@Override
	public void customer_del(Map params) {
		Context.STATE_DEL_YES(params);
		String customer_ids=Context.toArraystr(params.get("customer_ids").toString());
		params.put("customer_ids", customer_ids);
		customerD.customer_del(params);
		
	}
	
	@Override
	public void customer_del_row(Map params) {
		Context.STATE_DEL_YES(params);
		customerD.customer_del_row(params);
		
	}

	@Override
	public void customer_upd(Map params) {
		customerD.customer_upd(params);
		
	}
	
	@Override
	public List public_customer_list(Map params) {
		Context.STATE_DEL_NO(params);
		Context.page_limit(params);
		Context.PUBLIC_YES(params);
		List list=customerD.public_customer_list(params);
		return list;
	}

	@Override
	public int public_customer_list_total(Map params) {
		Context.STATE_DEL_NO(params);
		Context.PUBLIC_YES(params);
		int i=customerD.public_customer_list_total(params);
		return i;
	}
	
	@Override
	public void public_customer_add(Map params) {
		Context.uuid(params);
		Context.STATE_DEL_NO(params);
		Context.PUBLIC_YES(params);
		customerD.public_customer_add(params);
	}
	
	@Override
	public void public_customer_private_row(Map params,HttpSession session) {
		Context.PUBLIC_NO(params);
		params.put("userid", ((User)(session.getAttribute(Context.LOGIN_USER))).getUserid());
		customerD.public_customer_private_row(params);
	}

	@Override
	public void public_customer_private(Map params,HttpSession session) {
		Context.PUBLIC_NO(params);
		params.put("userid", ((User)(session.getAttribute(Context.LOGIN_USER))).getUserid());
		String customer_ids=Context.toArraystr(params.get("customer_ids").toString());
		params.put("customer_ids", customer_ids);
		customerD.public_customer_private(params);
	}
	
	@Override
	public void public_customer_upd(Map params) {
		customerD.public_customer_upd(params);
		
	}
	
	@Override
	public List private_customer_list(Map params,HttpSession session) {
		params.put("userid", ((User)(session.getAttribute(Context.LOGIN_USER))).getUserid());
		Context.STATE_DEL_NO(params);
		Context.page_limit(params);
		Context.PUBLIC_NO(params);
		List list=customerD.private_customer_list(params);
		return list;
	}

	@Override
	public int private_customer_list_total(Map params,HttpSession session) {
		params.put("userid", ((User)(session.getAttribute(Context.LOGIN_USER))).getUserid());
		Context.STATE_DEL_NO(params);
		Context.PUBLIC_NO(params);
		int i=customerD.private_customer_list_total(params);
		return i;
	}

	@Override
	public void public_customer(Map params) {
		// TODO Auto-generated method stub
		Context.PUBLIC_YES(params);
		params.put("userid", "");
		String customer_ids=Context.toArraystr(params.get("customer_ids").toString());
		params.put("customer_ids", customer_ids);
		customerD.public_customer(params);
	}

	@Override
	public List visit_partten_list() {
		// TODO Auto-generated method stub
		return customerD.visit_partten_list();
	}

	public void visit_customer( Map params,HttpSession session) {
		//客户的id
		List<String> list=Context.toListstr((String)params.get("customer_arr"));
		List uuid_customer_list=new ArrayList();
		Map map=null;
		for(String  str:list) {
			map=new HashMap();
			map.put("customer_id", str);
			//uuid主键
			Context.uuid(map);
			uuid_customer_list.add(map);
		}
		params.put("customer_list", uuid_customer_list);
		//访问用户的id--当前跟单客户的id--登录用户的id
		User user=(User)session.getAttribute(Context.LOGIN_USER);
		params.put("login_userid", user.getUserid());
		Object visit_pay=params.get("visit_pay");
		if("0".equals(visit_pay)) {
			//未付款
			params.put("visit_money", 0);
		}
		customerD.visit_customer(params);
	}
	public void visit_all_customer( Map params,HttpSession session) {
		//客户的id
		Context.STATE_DEL_NO(params);
		Context.PUBLIC_NO(params);
		User user=(User)session.getAttribute(Context.LOGIN_USER);
		params.put("userid", user.getUserid());
		params.put("login_userid", user.getUserid());
		List<Map> list=customerD.private_all_customer_list(params);
		for(Map  cus:list) {
			//uuid主键
			Context.uuid(cus);
		}
		params.put("customer_list", list);
		//访问用户的id--当前跟单客户的id--登录用户的id
		Object visit_pay=params.get("visit_pay");
		if("0".equals(visit_pay)) {
			//未付款
			params.put("visit_money", 0);
		}
		customerD.visit_customer(params);
	}
	
	public void visit_selected_email(Map params) {
		String title=params.get("title").toString();
		String info=params.get("info").toString();
		String email_arr=params.get("email_arr").toString();
		String[] email_str_arr=email_arr.split(",");
		try {
			Email.sendemail(title, info, email_str_arr);
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public void visit_all_email( Map params,HttpSession session) {
		Context.STATE_DEL_NO(params);
		Context.PUBLIC_NO(params);
		User user=(User)session.getAttribute(Context.LOGIN_USER);
		params.put("userid", user.getUserid());
		params.put("login_userid", user.getUserid());
		List<Map> list=customerD.private_all_customer_list(params);
		String email_str_arr[]=new String[list.size()];
		for(int i=0;i<list.size();i++) {
			email_str_arr[i]=(String)list.get(i).get("customer_email");
		}
		String title=params.get("title").toString();
		String info=params.get("info").toString();
		try {
			Email.sendemail(title, info, email_str_arr);
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
@Override
public List no_visit_list(Map params) {
	return customerD.no_visit_list(params);
}

@Override
public void init_tip(Map params) {
	customerD.init_tip(params);
	
}

@Override
public List visit_infos(Map params) {
	Context.page_limit(params);
	return customerD.visit_infos(params);
}
	
@Override
public int visit_infos_total(Map params) {
	// TODO Auto-generated method stub
	return customerD.visit_infos_total(params);
}
}
