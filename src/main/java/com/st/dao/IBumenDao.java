package com.st.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository
public interface IBumenDao {
	List bumen_list(Map params);

	int bumen_list_total(Map params);

	void bumen_add(Map params);

	void bumen_del(Map params);
	
	void bumen_del_row(Map params);
	
	void bumen_upd(Map params);
}
