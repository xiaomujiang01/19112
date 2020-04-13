package com.st.conf;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

@Configuration
public class SpringConfig {

	//视图解析器
	@Bean
	public InternalResourceViewResolver setivr() {
		InternalResourceViewResolver irv = new InternalResourceViewResolver();
		irv.setPrefix("/WEB-INF/");
		irv.setSuffix(".jsp");
		return irv;
	}
	

}