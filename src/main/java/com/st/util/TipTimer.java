package com.st.util;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TimerTask;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.st.service.ICustomerService;

@Component
public class TipTimer extends TimerTask {
	@Autowired
	ICustomerService custS;

	@Override
	public void run() {
		while (true) {
			try {
//				Thread.sleep(1000*3);
				Thread.sleep(1000 * 60*60);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			// 到达零点执行该方法
			Date date = new Date();
			int h = date.getHours();
			if (h == 0) {
				// 查询出所有两天没有回放的客户信息
				Map params = new HashMap();
				List<Map> list = custS.no_visit_list(params);
				// 根据以上客户信息生成提示信息
				// 每一条数据添加一个ID,拼接提示信息
				for (Map map : list) {
					Context.uuid(map);
					tip_info(map);
					Context.TIP_YES(map);
				}
				params.put("tip_infos", list);
				// 生成提示信息,保存数据库
				custS.init_tip(params);
			}
		}

	}

	private void tip_info(Map map) {
		try {
			String customer_id = map.get("customer_id").toString();
			String customer_name = map.get("customer_name").toString();
			String tip_info = "你跟单<a href='sys/tip_customer/" + customer_id + "'>" + customer_name
					+ "</a>客户已经超过两天没有回访了";
			map.put("tip_info", tip_info);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
