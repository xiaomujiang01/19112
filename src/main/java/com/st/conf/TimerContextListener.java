package com.st.conf;

import java.util.Timer;
import java.util.TimerTask;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.st.service.ICustomerService;
import com.st.util.TipTimer;
@WebListener
@Component
public class TimerContextListener implements ServletContextListener{
	@Autowired
	TipTimer tt;
	@Autowired
	ICustomerService custS;
	@Override	public void contextInitialized(ServletContextEvent sce) {
		//项目启动时即执行该方法
		
		//创建一个计时器--每隔一天时间(时间点)-做一件事情
		//任务
		
			Timer timer=new Timer();
			TimerTask timert=new TimerTask() {
				@Override
				public void run() {
					// TODO Auto-generated method stub
					
				}
			};
			timer.schedule(tt,1000);
//			timer.
		
		//将2天未回访的客户信息生成提示信息数据
		
	}
	
	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		// TODO Auto-generated method stub
		ServletContextListener.super.contextDestroyed(sce);
	}

}
