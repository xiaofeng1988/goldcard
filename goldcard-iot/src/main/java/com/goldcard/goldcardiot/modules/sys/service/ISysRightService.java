package com.goldcard.goldcardiot.modules.sys.service;

import java.util.List;
import java.util.Map;

import com.goldcard.goldcardiot.common.utils.EasyUIJsonTree;
import com.goldcard.goldcardiot.models.SysRight;
import com.goldcard.goldcardiot.models.SysUser;

/**
 * 权限服务接口
 * @author 心一
 *
 */
public interface ISysRightService {
	
    /**
     * 方法名称: findSysRightOneLevel ；
     * 方法描述: 一级菜单   ；
     * 返回类型: List<SysRight> ；
     * 创建人：心一  ；
     * 创建时间：2017年2月5日 下午2:43:45；
     * @throws
     */
	List<Map<String,Object>> findSysRightOneLevel(SysUser sysUser);
	/**
	 * 方法名称: findSysRightByFatherId ；
	 * 方法描述: 下级菜单   ；
	 * 返回类型: List<Map<String,Object>> ；
	 * 创建人：心一  ；
	 * 创建时间：2017年2月6日 下午3:05:44；
	 * @throws
	 */
	List<Map<String,Object>> findSysRightByFatherId(Integer fatherId);
	
	/**
	 * 心一：查询当前用户的下级菜单
	 * @param fatherId
	 * @param userId
	 * @return
	 */
	List<Map<String,Object>> findCurrentUserSysRightByFatherId(Map<String, Object> paraMap);
	
	/**
	 * 心一：获取当前用户的菜单树
	 * @param userId
	 * @return
	 */
	List<EasyUIJsonTree> findSysRightListByCurrentUserId(String userId);
	/**
	 * 心一：添加菜单
	 * @param userId
	 * @return
	 */
	int addSysRight(SysRight sysRight);
	/**
	 * 心一：删除菜单
	 * @param sysRight
	 * @return
	 */
	int deleteSysRight(int id);
	/**
	 * 心一：修改菜单
	 * @param userId
	 * @return
	 */
	int updateSysRight(SysRight sysRight);
	/**
	 * 心一：查询菜单信息
	 * @param id
	 * @return
	 */
	SysRight findSysRightByPK(String id);
	/**
	 * 心一：根据用户查询当前菜单列表
	 * @param userId
	 * @return
	 */
	List<EasyUIJsonTree> findSysRightsByUserId(String userId);
	/**
	 * 心一：获取当前角色所有菜单的权限信息
	 * @param roleId
	 * @return
	 */
	List<EasyUIJsonTree> findSysRightsByRoleId(String roleId);

	/**
	 * 心一：按照路径查询菜单信息
	 * @param id
	 * @return
	 */
	SysRight findSysRightByUrl(String URL);
	/**
	 * 心一：上移菜单
	 * @param nodeId
	 * @param preNodeId
	 */
	void moveUpSysright(String nodeId, String preNodeId);
	/**
	 * 心一：下移菜单
	 * @param nodeId
	 * @param preNodeId
	 */
	void moveDownSysright(String nodeId, String preNodeId);
	
}
