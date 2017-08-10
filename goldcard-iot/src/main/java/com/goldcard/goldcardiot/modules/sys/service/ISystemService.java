package com.goldcard.goldcardiot.modules.sys.service;

import java.util.List;
import java.util.Map;

import com.goldcard.goldcardiot.common.utils.EasyUIJsonTree;
import com.goldcard.goldcardiot.models.SysDept;
import com.goldcard.goldcardiot.models.SysDeptType;
import com.goldcard.goldcardiot.models.SysRole;
import com.goldcard.goldcardiot.models.SysUser;
import com.goldcard.goldcardiot.models.SysUserType;

/***
 * 心一：项目系统管理模块的接口<br>
 * 主要包括一下模块：<br>
 * 1：部门管理<br>
 * 2：用户管理<br>
 * 3：角色管理<br>
 * 4：注册功能<br>
 */
public interface ISystemService {
	
	
	/* ====================部门管理相关==================== */
	
	SysDept findSysDeptByPK(String deptId);

	void updateSysDept(SysDept sysDept, String deptTypeIds);

	void saveSysDept(SysDept sysDept, String deptTypeIds);

	void deleteSysDept(String deptId);

	List<SysDept> findSysDeptList();

	List<EasyUIJsonTree> findSysDeptTree(SysDept sysDept);

	List<SysDeptType> getSysDeptType();

	SysDept detailSysDept(String id);

	/* =====================部门类型管理相关==================== */
	/**
	 * 心一：获取所有部门类型
	 * 
	 * @return
	 */
	List<SysDeptType> findAllSysDeptType();

	/**
	 * 心一：根据部门ID查询部门类型信息
	 * 
	 * @param deptId
	 * @return
	 */
	List<Map<String, Object>> findSysDeptTypeListByDeptId(String deptId);

	/**
	 * 心一：主键查询部门信息
	 * 
	 * @param id
	 * @return
	 */
	SysDeptType findSysDeptTypeByPK(String id);

	/**
	 * 心一：下一个NO
	 * 
	 * @return
	 */
	int findNextSysDeptTypeNo();

	/**
	 * 心一：保存部门信息
	 * 
	 * @param sysDeptType
	 *            部门类型对象
	 * @return
	 */
	int saveSysDeptType(SysDeptType sysDeptType);

	/**
	 * 心一：修改部门信息
	 * 
	 * @param sysDeptType
	 * @return
	 */
	int updateSysDeptType(SysDeptType sysDeptType);

	/**
	 * 心一：批量删除部门类型信息
	 * 
	 * @param ids
	 */
	void deleteSysDeptByIds(String ids);

	/**
	 * 心一：分页查询用户count
	 * 
	 * @param paraMap
	 * @return
	 */
	int findSysUserCountByCondition(Map<String, Object> paraMap);

	/**
	 * 心一：分页查询用户信息
	 * @param paraMap
	 * @return
	 */
	List<Map<String, Object>> findSysUserPageByCondition(Map<String, Object> paraMap);
	
	
    /* ====================用户管理相关==================== */
	/**
	 * 心一：主键查询用户信息
	 * @param id
	 * @return
	 */
	SysUser findSysUserByPK(String id);
	/**
	 * 心一：添加用户
	 * 
	 * @param sysUser
	 * @return
	 */
	void saveSysUser(SysUser sysUser,String roleids);

	/**
	 * 心一：修改用户
	 * 
	 * @param sysUser
	 * @return
	 */
	void updateSysUser(SysUser sysUser,String roleids);

	/**
	 * 心一：删除用户
	 * 
	 * @param ids
	 * @return
	 */
	int deleteSysUser(String ids);
	/**
	 * 心一：查询用户类型
	 * deptId:部门类型
	 * @return
	 */
	List<SysUserType> findSysUserTypesByDeptId(String deptId);
	/**
	 * 心一：全查询角色
	 * @return
	 */
	List<SysRole> findAllSysRole();
	/**
	 * 心一：校验登录名是否存在
	 * @return
	 */
	int findCountByLoginName(String loginName);
	/**
	 * 心一：用户所拥有的角色
	 * @param userId
	 * @return
	 */
	List<SysRole> findRolesByUserId(String userId);

	/* ====================用户和菜单关系相关==================== */
	/**
	 * 心一：保存用户权限
	 * @param sysUser
	 */
	void saveSysUserPermission(SysUser sysUser);
	/**
	 * 心一：保存用户角色信息
	 * @param sysUser
	 * @param language
	 */
	void savaSysRoleAndUserByUserId(SysUser sysUser, String language);
	
	/* ====================角色管理相关==================== */
	/**
	 * 心一：主键查询角色信息
	 * @param id
	 * @return
	 */
	SysRole findSysRoleById(String id);
	/**
	 * 心一：保存角色权限信息
	 * @param sysRole
	 */
	void updateSysRolePermission(SysRole sysRole);
	/**
	 * 心一：对部门排序
	 * @param currSysDeptId 当前的部门ID
	 * @param moveSysDeptId 移动到的部门ID
	 */
	void moveSysDeptOrder(String currSysDeptId, String moveSysDeptId);
	/**
	 * 心一：当前角色存在的个数
	 * @param id
	 * @param name
	 * @return
	 */
	int findCountRoleNameByRoleId(String id ,String name);
	/**
	 * 心一：修改角色
	 * @param sysRole
	 */
	void updateSysRole(SysRole sysRole);
	/**
	 * 心一：添加角色
	 * @param sysRole
	 */
	void addSysRole(SysRole sysRole);
	/**
	 * 心一：删除角色（按主键ID）
	 * @param id
	 */
	void deleteSysRoleByPK(String id);
	
	/**
	 * 心一：分页查询系统用户类型
	 * @param userType
	 * @return
	 */
	Map<String,Object> findSysUserTypePageByConditions(Map<String,Object> paramMap);
	/**
	 * 心一：添加系统用户类型
	 * @param sysUserType
	 */
	void addSysUserType(SysUserType sysUserType);
	/**
	 * 心一：修改系统用户类型
	 * @param sysUserType
	 */
	void updateSysUserType(SysUserType sysUserType);
	/**
	 * 心一：条件查询系统用户类型的个数
	 * @param sysUserType
	 * @return
	 */
	int findCountTypeNameById(SysUserType sysUserType);
	/**
	 * 心一：主键查询用户类型信息
	 * @param id
	 * @return
	 */
	SysUserType findSysUserTypeByPK(Integer id);
	/**
	 * 心一：删除系统用户类型信息
	 * @param ids
	 */
	void deleteSysUserTypeByIds(String ids);
	/**
	 * 心一：查询所有系统用户类型
	 * @return
	 */
	List<SysUserType> findALlSysUserType();
}
