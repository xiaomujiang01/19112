package com.st.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.st.dao.IBumenDao;
import com.st.service.IBumenService;
import com.st.util.Context;
@Service
public class BumenService implements IBumenService{

	@Autowired
	IBumenDao bumenD;
	
	@Override
	public List bumen_list(Map params) {
		Context.page_limit(params);
		List list=bumenD.bumen_list(params);
		return list;
	}

	@Override
	public int bumen_list_total(Map params) {
		int i=bumenD.bumen_list_total(params);
		return i;
	}

	@Override
	public void bumen_add(Map params) {
		Context.uuid(params);
		bumenD.bumen_add(params);
	}

	@Override
	public void bumen_del(Map params) {
		String bumen_ids=Context.toArraystr(params.get("bumen_ids").toString());
		params.put("bumen_ids", bumen_ids);
		bumenD.bumen_del(params);
	}

	@Override
	public void bumen_del_row(Map params) {
		bumenD.bumen_del_row(params);
		
	}

	@Override
	public void bumen_upd(Map params) {
		bumenD.bumen_upd(params);
		
	}

}
