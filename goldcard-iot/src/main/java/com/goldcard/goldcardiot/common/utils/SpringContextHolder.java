package com.goldcard.goldcardiot.common.utils;

import org.apache.commons.lang3.Validate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.DisposableBean;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;

/**
 * 以静态变量保存Spring ApplicationContext, 
 * 可在任何代码任何地方任何时候取出ApplicaitonContext.
 *
 * @author shil
 */
public class SpringContextHolder implements ApplicationContextAware, DisposableBean {
	
	private static ApplicationContext applicationContext = null;

	private static Logger logger = LoggerFactory.getLogger(SpringContextHolder.class);
	
	/**
	 * 取得ApplicationContext.
	 */
	public static ApplicationContext getApplicationContext() {
		assertContextInjected();
		return applicationContext;
	}
	
	/**
	 * 通过名称取得Bean, 自动转型为所赋值对象的类型.
	 */
	@SuppressWarnings("unchecked")
	public static <T> T getBean(String name) {
		assertContextInjected();
		return (T) applicationContext.getBean(name);
	}

	/**
	 * 通过类型取得Bean, 自动转型为所赋值对象的类型.
	 */
	public static <T> T getBean(Class<T> requiredType) {
		assertContextInjected();
		return applicationContext.getBean(requiredType);
	}
	
	public void destroy() throws Exception {
		SpringContextHolder.clearHolder();
	}
	
	public void setApplicationContext(ApplicationContext applicationContext)
			throws BeansException {
		if (SpringContextHolder.applicationContext != null) {
			logger.warn("SpringContextHolder中的ApplicationContext被覆盖, 原有ApplicationContext为:" + SpringContextHolder.applicationContext);
		}

		SpringContextHolder.applicationContext = applicationContext;
	}
	
	/**
	 * 清除SpringContextHolder中的ApplicationContext为Null.
	 */
	public static void clearHolder() {
		logger.debug("清除SpringContextHolder中的ApplicationContext:"
				+ applicationContext);
		applicationContext = null;
	}
	
	/**
	 * 检查ApplicationContext
	 */
	private static void assertContextInjected() {
		Validate.validState(applicationContext != null, "applicaitonContext属性未注入, 请在applicationContext.xml中定义SpringContextHolder.");
	}
}
