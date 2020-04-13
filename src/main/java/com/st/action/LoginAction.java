package com.st.action;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.st.service.ITipService;
import com.st.util.Context;

@Controller
public class LoginAction {
	
	@Autowired
	ITipService tipS;
	

	@RequestMapping("/login")
	public String login(@RequestParam Map params,HttpSession session) {
		//获得令牌
		UsernamePasswordToken token=new UsernamePasswordToken(params.get("username").toString(), params.get("password").toString());
		//当前用户拿着令牌去认证登录
		Subject subject=SecurityUtils.getSubject();
		try {
		subject.login(token);
		//查询当前用户的提示信息的数量
		int count=tipS.loginUser_tip_count(session);
		session.setAttribute(Context.TIP_COUNT, count);
		return "sys/system";
		}catch(AuthenticationException e) {
			//捕捉到异常，登录失败
			return "sys/login_page";
		}
	}
	
	@RequestMapping("/login_page")
	public String login_page() {
		return "sys/login_page";
	}
}
