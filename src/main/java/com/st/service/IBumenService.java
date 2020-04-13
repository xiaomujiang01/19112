package com.st.service;

import java.util.List;
import java.util.Map;

public interface IBumenService {

	List bumen_list(Map params);
	int bumen_list_total(Map params);
	void bumen_add(Map params);
	void bumen_del(Map params);
	void bumen_del_row(Map params);
	void bumen_upd(Map params);
	
}
