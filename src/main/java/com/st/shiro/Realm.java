package com.st.shiro;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.st.bean.User;
import com.st.service.IUserService;
import com.st.util.Context;

@Component
public class Realm extends AuthorizingRealm {

	@Autowired
	IUserService userS;
	@Autowired
	HttpSession session;

	/**
	 * 每当需要权限认证时，shiro会自动调用该方法
	 */
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
		User user=(User)session.getAttribute(Context.LOGIN_USER);
		List<String> list=user.permissionCodes();
		SimpleAuthorizationInfo sai=new SimpleAuthorizationInfo();
		sai.addStringPermissions(list);
		return sai;
	}

	@Override
	// 登录认证
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
		// 获得前台用户登录的用户名和密码
		String username = token.getPrincipal().toString();
		String password = new String((char[]) token.getCredentials());
		// 通过用户名查询用户相关数据
		User user = userS.getuser(username);
		System.out.println(user.allPermissions().size());
		session.setAttribute(Context.LOGIN_USER, user);
		// 校验密码是否正确
		// 用户输入的是123456，需要将用户输入的密码加密成MD5字符串，和数据库当中的数据进行校验，如果正确登录成功。
		SimpleHash sh = new SimpleHash("md5", password, user.getUserid());
		if (sh.toString().equals(user.getUserpass())) {
			return new SimpleAuthenticationInfo(username, password, getName());
		} else {
			throw new AuthenticationException("登陆失败");
		}
	}

}
