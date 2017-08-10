package com.goldcard.goldcardiot.modules.sys.service;

import java.util.List;
import java.util.Map;

import com.goldcard.goldcardiot.models.SysUser;
import com.goldcard.goldcardiot.models.SysUserOnline;

/**
 * 用户服务接口
 * @author 心一
 *
 */
public interface ISysUserService {
	/**
	 * 心一：主键查询用户
	 * @param id
	 * @return
	 */
	public SysUser findUserById(int id);
	/**
	 * 心一：登陆查询用户 
	 * @param sysUser
	 * @return
	 */
	public SysUser findUserByLoginfo(SysUser sysUser);
	/**
	 * 心一：修改密码
	 * @param uid
	 * @param pwd
	 */
	public void updateUserPasswd(Long uid,String pwd);
	
	public void updateUserPasswd(SysUser usr);
	
	public int findSysUserCount();
	
	public List<Map<String,Object>> findAllSysUserList();
	/**
	 * 心一：查询当前用户所有菜单权限
	 * @param userId
	 * @return
	 */
	Map<String,Integer> findSysRightsByUserId(Integer userId);
	/**
	 * 心一：查询当前用户所有菜单路径
	 * @param userId
	 * @return
	 */
	Map<String,Integer> findAllUrlByUserId(Integer userId);
	/**
	 * 心一：根据用户ID和菜单ID查询当前权限
	 * @param userId： 用户ID
	 * @param rightId：菜单ID
	 * @return
	 */
	Map<String,Integer> findSysRightsByUserIdAndRightId(Integer userId,Integer rightId);
	/**
	 * 心一：查询在线人员详细信息
	 * @param userId：用户ID
	 * @return
	 */
	Map<String, Object> findSysUserOnlineByUserId(Integer userId);
	/**
	 * 心一：保存在线人员信息
	 * @param sysUserOnline
	 */
	void saveSysUserOnline(SysUserOnline sysUserOnline);
	/**
	 * 心一：修改在线人员信息
	 * @param sysUserOnline
	 */
	void updateSysUserOnline(SysUserOnline sysUserOnline);
	/**
	 * 心一：查询在线用户详情
	 * @param userId
	 * @return
	 */
	Map<String, Object> findSysUserOnlineRemarkByUserId(Integer userId);
}
