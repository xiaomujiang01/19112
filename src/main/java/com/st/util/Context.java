package com.st.util;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

public class Context {
	

	public static final int STATE_DEL_NO = 1;
	public static final int STATE_DEL_YES = 0;
	public static final int PUBLIC_NO = 1;
	public static final int PUBLIC_YES = 0;
	public static final int TIP_YES = 0;
	public static final int TIP_NO = 1;
	public static final String TIP_COUNT = "TIP_COUNT";
	public static final String LOGIN_USER = "login_user";
	
	public static void TIP_YES(Map map) {
		map.put("state", TIP_YES);
	}
	public static void TIP_NO(Map map) {
		map.put("state", TIP_NO);
	}

	public static void STATE_DEL_NO(Map map) {
		map.put("state", STATE_DEL_NO);
	}

	public static void STATE_DEL_YES(Map map) {
		map.put("state", STATE_DEL_YES);
	}

	public static void PUBLIC_NO(Map map) {
		map.put("public", PUBLIC_NO);
	}

	public static void PUBLIC_YES(Map map) {
		map.put("public", PUBLIC_YES);
	}

	public static void page_limit(Map params) {
		int page = Integer.parseInt(params.get("page") + "");
		int limit = Integer.parseInt(params.get("limit") + "");
		int start = (page - 1) * limit;
		params.put("start", start);
	}

	public static void uuid(Map params) {
		UUID uuid = UUID.randomUUID();
		params.put("uuid", uuid.toString());
	}

	public static String toArraystr(String str) {
		String[] s_arr = str.split(",");
		StringBuffer str_b = new StringBuffer();
		for (String s : s_arr) {
			if (!s.trim().equals(""))
				str_b.append("'" + s + "'");
		}
		return str_b.toString().replace("''", "','");
	}
	
	public static List toListstr(String str) {
		String[] s_arr = str.split(",");
		List list=new ArrayList();
		for (String s : s_arr) {
			if (!s.trim().equals(""))
				list.add(s);
		}
		return list;
	}
	
}
