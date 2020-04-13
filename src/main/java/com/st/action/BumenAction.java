package com.st.action;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.st.service.IBumenService;
import com.st.util.TableJSON;

@Controller
@RequestMapping("/sys")
public class BumenAction {

	@Autowired
	IBumenService bumenS;

	@RequestMapping("/bumen_page")
	public String user_page() {
		System.out.println("访问到了bumen_page");
		return "sys/bumen_page";
	}

	@RequestMapping("/bumen_list")
	@ResponseBody
	public TableJSON bumen_list(@RequestParam Map params) {
		List list = bumenS.bumen_list(params);
		int total = bumenS.bumen_list_total(params);
		return TableJSON.tablejson(list, total);
	}

	@RequestMapping("/bumen_add")
	@ResponseBody
	public void bumen_add(@RequestParam Map params) {
		bumenS.bumen_add(params);
	}

	@RequestMapping("/bumen_del")
	@ResponseBody
	public void bumen_del(@RequestParam Map params) {
		bumenS.bumen_del(params);
	}

	@RequestMapping("/bumen_del_row")
	@ResponseBody
	public void bumen_del_row(@RequestParam Map params) {
		bumenS.bumen_del_row(params);
	}

	@RequestMapping("/bumen_upd")
	@ResponseBody
	public void bumen_upd(@RequestParam Map params) {
		bumenS.bumen_upd(params);
	}

	
}
