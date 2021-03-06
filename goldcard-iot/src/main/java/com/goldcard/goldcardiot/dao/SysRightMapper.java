package com.goldcard.goldcardiot.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.goldcard.goldcardiot.models.SysRight;
import com.goldcard.goldcardiot.models.SysRightExample;

public interface SysRightMapper {

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table sys_right
	 * @mbggenerated  Sat Feb 04 16:21:42 CST 2017
	 */
	int countByExample(SysRightExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table sys_right
	 * @mbggenerated  Sat Feb 04 16:21:42 CST 2017
	 */
	int deleteByExample(SysRightExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table sys_right
	 * @mbggenerated  Sat Feb 04 16:21:42 CST 2017
	 */
	int deleteByPrimaryKey(Integer id);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table sys_right
	 * @mbggenerated  Sat Feb 04 16:21:42 CST 2017
	 */
	int insert(SysRight record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table sys_right
	 * @mbggenerated  Sat Feb 04 16:21:42 CST 2017
	 */
	int insertSelective(SysRight record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table sys_right
	 * @mbggenerated  Sat Feb 04 16:21:42 CST 2017
	 */
	List<SysRight> selectByExample(SysRightExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table sys_right
	 * @mbggenerated  Sat Feb 04 16:21:42 CST 2017
	 */
	SysRight selectByPrimaryKey(Integer id);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table sys_right
	 * @mbggenerated  Sat Feb 04 16:21:42 CST 2017
	 */
	int updateByExampleSelective(@Param("record") SysRight record, @Param("example") SysRightExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table sys_right
	 * @mbggenerated  Sat Feb 04 16:21:42 CST 2017
	 */
	int updateByExample(@Param("record") SysRight record, @Param("example") SysRightExample example);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table sys_right
	 * @mbggenerated  Sat Feb 04 16:21:42 CST 2017
	 */
	int updateByPrimaryKeySelective(SysRight record);

	/**
	 * This method was generated by MyBatis Generator. This method corresponds to the database table sys_right
	 * @mbggenerated  Sat Feb 04 16:21:42 CST 2017
	 */
	int updateByPrimaryKey(SysRight record);
	/**
	 * 心一：按照层次查询最大的排序号
	 * @param level
	 * @return
	 */
	int findMaxOrderByLevel(Integer level);
	
	
	
	/**
     * 方法名称: findSysRightOneLevel ；
     * 方法描述: 查询一级菜单   ；
     * 返回类型: List<SysRight> ；
     * 创建人：心一  ；
     * 创建时间：2017年2月5日 下午2:43:45；
     * @throws
     */
	 List<Map<String,Object>> findSysRightOneLevel(Map<String,Object> paramMap);
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
	 * 心一：当前用户的下级菜单
	 * @param paraMap
	 * @return
	 */
	 List<Map<String,Object>> findCurrentUserSysRightByFatherId(Map<String,Object> paraMap);
	/**
	 * 心一：获取当前角色的所有菜单
	 * @param paraMap
	 * @return
	 */
	List<Map<String,Object>> findSysRightListByCurrentUserId(Map<String,Object> paraMap);
	/**
	 * 心一：根据父节点查询是否有子节点
	 * @param fatherId
	 * @return
	 */
	int findSysRightCountByFatherId(Integer fatherId);
	/**
	 * 心一：获取当前角色的所有菜单
	 * @param paraMap
	 * @return
	 */
	List<Map<String,Object>> findSysRightListByCurrentRoleId(Map<String,Object> paraMap);
	
}