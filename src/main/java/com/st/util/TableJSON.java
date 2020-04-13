package com.st.util;

import java.util.List;

public class TableJSON {

	private String msg;
	private int code=0;
	private int count;
	private List data;
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public int getCode() {
		return code;
	}
	public void setCode(int code) {
		this.code = code;
	}
	
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public List getData() {
		return data;
	}
	public void setData(List data) {
		this.data = data;
	}
	
	public static TableJSON tablejson(List list,int i) {
		TableJSON tablejson=new TableJSON();
		tablejson.setData(list);
		tablejson.setCount(i);
		return tablejson;
	}
	
	public static TableJSON tablejson_perm(List list) {
		TableJSON tablejson=new TableJSON();
		tablejson.setData(list);
		return tablejson;
	}
}
