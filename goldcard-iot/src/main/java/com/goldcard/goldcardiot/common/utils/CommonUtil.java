package com.goldcard.goldcardiot.common.utils;

import java.beans.BeanInfo;
import java.beans.Introspector;
import java.beans.PropertyDescriptor;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;

import com.goldcard.goldcardiot.models.SysUser;

/**
 * 工具类
 * @author sunzhwei add at 2014-08-07
 * 
 */
public class CommonUtil {

	/**
	 * 判断是否为空字符串
	 * @param str
	 * @return
	 */
	public static boolean isEmptyStr(String str) {
		if (null == str) {
			return true;
		} else {
			if (0 == str.trim().length() || str.isEmpty()) {
				return true;
			} else {
				return false;
			}
		}
	}
	
	/**
	 * 获取访问者IP
	 * 
	 * 在一般情况下使用Request.getRemoteAddr()即可，但是经过nginx等反向代理软件后，这个方法会失效。
	 * 
	 * 本方法先从Header中获取X-Real-IP，如果不存在再从X-Forwarded-For获得第一个IP(用,分割)，
	 * 如果还不存在则调用Request .getRemoteAddr()。
	 * 
	 * @param request
	 * @return
	 */
	public static String getIpAddr(HttpServletRequest request) {
		String ip = request.getHeader("X-Real-IP");
		if (!StringUtils.isBlank(ip) && !"unknown".equalsIgnoreCase(ip)) {
			return ip;
		}
		ip = request.getHeader("X-Forwarded-For");
		if (!StringUtils.isBlank(ip) && !"unknown".equalsIgnoreCase(ip)) {
			// 多次反向代理后会有多个IP值，第一个为真实IP。
			int index = ip.indexOf(',');
			if (index != -1) {
				return ip.substring(0, index);
			} else {
				return ip;
			}
		} else {
			return request.getRemoteAddr();
		}
	}
	
	/**
	 * 获取当前登录用户
	 *
	 * @author lingaofeng 
	 * @param request HttpServletRequest
	 * @created 2015-1-30 上午09:43:57
	 */
	public static SysUser getLoginUser(HttpServletRequest request){
		SysUser result = null;
		Object objUser = request.getSession().getAttribute(CommonValue.SESSION_CURRENT_USER);
		result = objUser == null ? null : (SysUser)objUser;
		return result;
	}
	
    // Bean --> Map 1: 利用Introspector和PropertyDescriptor 将Bean --> Map  
    public static Map<String, Object> transBean2Map(Object obj) {  
  
        if(obj == null){  
            return null;  
        }          
        Map<String, Object> map = new HashMap<String, Object>();  
        try {  
            BeanInfo beanInfo = Introspector.getBeanInfo(obj.getClass());  
            PropertyDescriptor[] propertyDescriptors = beanInfo.getPropertyDescriptors();  
            for (PropertyDescriptor property : propertyDescriptors) {  
                String key = property.getName();  
  
                // 过滤class属性  
                if (!key.equals("class")) {  
                    // 得到property对应的getter方法  
                    Method getter = property.getReadMethod();  
                    Object value = getter.invoke(obj);  
  
                    map.put(key, value);  
                }  
  
            }  
        } catch (Exception e) {  
            System.out.println("transBean2Map Error " + e);  
        }  
  
        return map;  
  
    }  
	
}
