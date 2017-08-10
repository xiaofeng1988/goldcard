package com.goldcard.goldcardiot.common.utils;

import java.io.File;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

/**
 * 处理系统要使用的公用数据和变量
 * 
 * @author 心一
 *
 */
public class CommonValue {

	public static int PAGE_SIZE_SIXTH = 60; // 默认的前台分页信息，每页显示多少条数据
	public static int PAGE_SIZE_THREETH = 30; // 默认的前台分页信息，每页显示多少条数据
	public static int PAGE_SIZE = 15; // 默认的前台分页信息，每页显示多少条数据
	public static int PAGE_SIZE_TEN = 10; // 默认的前台分页信息，每页显示多少条数据
	public static int PAGE_SIZE_TWENTY = 20; // 默认的前台分页信息，每页显示多少条数据
	public static int PAGE_SIZE_FORTY = 40; // 默认的前台分页信息，每页显示多少条数据

	public static final String UPLOAD_FILE_PATH = "uploadfile";// 上传文件路径
	public static final String FILL_DOC_PATH = "filldoc";// 填报文档保存路径
															// 隶属于UPLOAD_FILE_PATH下
	public static final String UPLOAD_CONTINGPLAN_FILE_PATH = UPLOAD_FILE_PATH + File.separator + "contingplan";// 上传文件路径
	public static final String UPLOAD_CONTINGPLAN_WEB_PATH = UPLOAD_FILE_PATH + "/contingplan";// 上传文件WEB访问路径
	public static final String UPLOAD_LFM_FILE_PATH = UPLOAD_FILE_PATH + File.separator + "lfm";// 上传文件路径
	public static final String CHARSET_GBK = "GBK";
	public static final String CHARSET_UTF8 = "UTF-8";
	public static final String CHARSET_ISO88951 = "ISO-8859-1";
	public static final String CHECK_ORACLE_HOUR_TIME_FORMATE = "HH24"; // 考核管理oracle数据库中的小时时间格式
	public static final String CHECK_ORACLE_DAY_TIME_FORMATE = "dd"; // 考核管理oracle数据库中的天时间格式

	public static String STSHOW = "浏览"; // 浏览

	public static String DEFAULT_NODEID_UNABLE = "0"; // 默认的系统中不可用节点id
	public static String CHAR_ENCODING = "UTF-8"; // 默认的字符编码
	public static String GLOBAL_YES = "Y"; // 默认的yes
	public static String GLOBAL_NO = "N"; // 默认的no

	public static int GLOBAL_ZERO_NUMBER = 0; // 全局的数字0
	public static int GLOBAL_ONE_NUMBER = 1; // 全局的数字1

	/**
	 * session存储的当前用户键值变量
	 */
	public static final String SESSION_CURRENT_USER = "sysuser";
	/**
	 * tree的状态为closed的值
	 */
	public static String TREE_CLOSED_STATE = "closed";
	/**
	 * tree的状态为open的值
	 */
	public static String TREE_OPEN_STATE = "open";
	/**
	 * 当前用户访问连接的权限
	 */
	public static Map<String, String> CURRENTUSERRIGHTMAP = null;
	/**
	 * 定义的所有权限
	 */
	public static Map<String, Integer> ALLFUNS = null;
	/**
	 * UI权限标识MAP
	 */
	public static Map<String, Integer> UI_Right_Maps = null;
	/**
	 * 缓存当前用户所有菜单路径<菜单路径url,菜单id>,支持线程安全
	 */
	public static Map<String, Integer> CURRENTUSERRIGHTURLMAP = null;

	// 操作对象类型
	public static enum OOT {
		部门, 用户, 权限, 部门类型, 角色, 功能注册, 文档
	}

	// 静态代码块
	static {
		if (ALLFUNS == null) {
			ALLFUNS = new HashMap<String, Integer>(); // 这个是定义的全局权限，无需同步
			ALLFUNS.put("浏览", 1 << 0); // 浏览
			ALLFUNS.put("添加", 1 << 1); // 添加
			ALLFUNS.put("修改", 1 << 2); // 修改
			ALLFUNS.put("删除", 1 << 3); // 删除
			ALLFUNS.put("设置", 1 << 4); // 设置
			ALLFUNS.put("上传", 1 << 5); // 上传
			ALLFUNS.put("下载", 1 << 6); // 下载
		}
		// 存储当前用户访问每个页面的临时权限，控制页面元素的显示与隐藏
		if (CURRENTUSERRIGHTMAP == null) {
			CURRENTUSERRIGHTMAP = Collections.synchronizedMap(new HashMap<String, String>());
			CURRENTUSERRIGHTMAP.put("浏览", "CANSHOW");   // 浏览
			CURRENTUSERRIGHTMAP.put("添加", "CANADD");    // 添加
			CURRENTUSERRIGHTMAP.put("修改", "CANUPDATE"); // 修改
			CURRENTUSERRIGHTMAP.put("删除", "CANDELETE"); // 删除
			CURRENTUSERRIGHTMAP.put("设置", "CANMANAGER");// 设置
			CURRENTUSERRIGHTMAP.put("上传", "CANUP");     // 上传
			CURRENTUSERRIGHTMAP.put("下载", "CANDOWN");   // 下载
		}
		if(CURRENTUSERRIGHTURLMAP == null){
			CURRENTUSERRIGHTURLMAP = Collections.synchronizedMap(new HashMap<String, Integer>());
		}

	}

}
