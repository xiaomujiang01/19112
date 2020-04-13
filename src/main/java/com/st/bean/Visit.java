package com.st.bean;

public class Visit {
	
	private String visit_id;
	private String visit_customer_id;
	private String visit_user_id;
	private String visit_time;
	private String visit_info;
	private String visit_pattern;
	private String visit_pay;
	private String visit_pay_text;
	private String visit_money;
	
	private Customer visit_customer_bean;
	private User visit_user_bean;
	private Partten visit_partten_bean;
	
	
	
	public String getVisit_pay_text() {
		return visit_pay_text;
	}
	public void setVisit_pay_text(String visit_pay_text) {
		this.visit_pay_text = visit_pay_text;
	}
	public String getVisit_id() {
		return visit_id;
	}
	public void setVisit_id(String visit_id) {
		this.visit_id = visit_id;
	}
	public String getVisit_customer_id() {
		return visit_customer_id;
	}
	public void setVisit_customer_id(String visit_customer_id) {
		this.visit_customer_id = visit_customer_id;
	}
	public String getVisit_user_id() {
		return visit_user_id;
	}
	public void setVisit_user_id(String visit_user_id) {
		this.visit_user_id = visit_user_id;
	}
	public String getVisit_time() {
		return visit_time;
	}
	public void setVisit_time(String visit_time) {
		this.visit_time = visit_time;
	}
	public String getVisit_info() {
		return visit_info;
	}
	public void setVisit_info(String visit_info) {
		this.visit_info = visit_info;
	}
	public String getVisit_pattern() {
		return visit_pattern;
	}
	public void setVisit_pattern(String visit_pattern) {
		this.visit_pattern = visit_pattern;
	}
	public String getVisit_pay() {
		return visit_pay;
	}
	public void setVisit_pay(String visit_pay) {
		if("0".equals(visit_pay)) {
			this.visit_pay_text="未付款";
		}else {
			this.visit_pay_text="付款";
		}
		this.visit_pay = visit_pay;
	}
	public String getVisit_money() {
		return visit_money;
	}
	public void setVisit_money(String visit_money) {
		this.visit_money = visit_money;
	}
	public Customer getVisit_customer_bean() {
		return visit_customer_bean;
	}
	public void setVisit_customer_bean(Customer visit_customer_bean) {
		this.visit_customer_bean = visit_customer_bean;
	}
	public User getVisit_user_bean() {
		return visit_user_bean;
	}
	public void setVisit_user_bean(User visit_user_bean) {
		this.visit_user_bean = visit_user_bean;
	}
	public Partten getVisit_partten_bean() {
		return visit_partten_bean;
	}
	public void setVisit_partten_bean(Partten visit_partten_bean) {
		this.visit_partten_bean = visit_partten_bean;
	}
	

}
