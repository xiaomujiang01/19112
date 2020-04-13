package com.st.service.impl;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.st.bean.User;
import com.st.dao.ITipDao;
import com.st.service.ITipService;
import com.st.util.Context;
@Service
public class TipService implements ITipService{
@Autowired
	ITipDao tipD;
	@Override
	public int loginUser_tip_count(HttpSession session) {
		User user=(User)session.getAttribute(Context.LOGIN_USER);
		Map map =new HashMap();
		map.put("userid", user.getUserid());
		Context.TIP_YES(map);
		int count=tipD.loginUser_tip_count(map);
		return count;
	}

}
