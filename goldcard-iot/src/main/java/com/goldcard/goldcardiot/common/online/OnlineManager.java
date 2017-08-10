package com.goldcard.goldcardiot.common.online;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.goldcard.goldcardiot.models.SysUserOnline;

/**
 * 心一：在线用户管理
 * 
 * @author 心一
 *
 */
public class OnlineManager {

	private Log log = LogFactory.getLog(OnlineManager.class); // 处理日志的对象
	/**
	 * 定义一个静态私有变量(不初始化，不使用final关键字，使用volatile保证了多线程访问时instance变量的可见性，
	 * 避免了instance初始化时其他变量属性还没赋值完时，被另外线程调用)
	 */
	private static volatile OnlineManager instance = null;

	/**
	 * 缓存在线用户MAP
	 */
	private static volatile Map<String, SysUserOnline> onlineMap = null;

	//构造函数，防止New本类的对象
	public OnlineManager() {
		log.info("OnlineManager...");
	}

	/**
	 * 心一：单例模式
	 * 定义一个静态的方法（调用时再初始化OnlineManager，使用synchronized 避免多线程访问时，可能造成重的复初始化问题）
	 * @return
	 */
	public static OnlineManager getInstance() {
		// 对象实例化时与否判断（不使用同步代码块，instance不等于null时，直接返回对象，提高运行效率）
		if (instance  == null) {
			//同步代码块（对象未初始化时，使用同步代码块，保证多线程访问时对象在第一次创建后，不再重复被创建）
			synchronized (OnlineManager.class) {
				 if(instance  == null){
					 instance  = new OnlineManager();
				 }
			 }
		}
		return instance ;
	}

	
	/**
	 * 心一：返回在线用户MAP
	 * 支持线程安全
	 * @return
	 */
	public Map<String, SysUserOnline> getOnlineMap() {
		if (onlineMap == null) {
			onlineMap = Collections.synchronizedMap(new HashMap<String, SysUserOnline>());
		}
		return onlineMap;
	}

	


}
