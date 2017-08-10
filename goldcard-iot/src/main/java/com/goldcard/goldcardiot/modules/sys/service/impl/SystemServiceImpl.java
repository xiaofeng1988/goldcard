package com.goldcard.goldcardiot.modules.sys.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.goldcard.goldcardiot.common.utils.CommonValue;
import com.goldcard.goldcardiot.common.utils.EasyUIJsonTree;
import com.goldcard.goldcardiot.common.utils.Paging;
import com.goldcard.goldcardiot.common.utils.UtilValidate;
import com.goldcard.goldcardiot.dao.SysDeptAndTypeMapper;
import com.goldcard.goldcardiot.dao.SysDeptMapper;
import com.goldcard.goldcardiot.dao.SysDeptTypeMapper;
import com.goldcard.goldcardiot.dao.SysRoleAndRightMapper;
import com.goldcard.goldcardiot.dao.SysRoleAndUserMapper;
import com.goldcard.goldcardiot.dao.SysRoleMapper;
import com.goldcard.goldcardiot.dao.SysUserAndRightMapper;
import com.goldcard.goldcardiot.dao.SysUserMapper;
import com.goldcard.goldcardiot.dao.SysUserTypeMapper;
import com.goldcard.goldcardiot.models.SysDept;
import com.goldcard.goldcardiot.models.SysDeptAndType;
import com.goldcard.goldcardiot.models.SysDeptType;
import com.goldcard.goldcardiot.models.SysRole;
import com.goldcard.goldcardiot.models.SysRoleAndRight;
import com.goldcard.goldcardiot.models.SysRoleAndRightExample;
import com.goldcard.goldcardiot.models.SysRoleAndRightExample.Criteria;
import com.goldcard.goldcardiot.models.SysRoleAndUser;
import com.goldcard.goldcardiot.models.SysUser;
import com.goldcard.goldcardiot.models.SysUserAndRight;
import com.goldcard.goldcardiot.models.SysUserType;
import com.goldcard.goldcardiot.modules.sys.service.ISystemService;

@Service("systemService")
@Transactional
public class SystemServiceImpl implements ISystemService{
	@Resource(name="sysDeptMapper")
	private SysDeptMapper sysDeptMapper;  // 处理部门信息的Mapper对象
	
	@Resource(name="sysDeptTypeMapper")
	private SysDeptTypeMapper sysDeptTypeMapper; //处理部门类型的Mapper对象
	
	@Resource(name="sysDeptAndTypeMapper")
	private SysDeptAndTypeMapper sysDeptAndTypeMapper; //处理部门和类型关系Mapper对象
	
	@Resource(name="sysUserMapper")
	private SysUserMapper sysUserMapper;   //处理用户信息的Mapper对象
	
	@Resource(name="sysUserTypeMapper")
	private SysUserTypeMapper sysUserTypeMapper;   //处理用户类型的Mapper对象
	
	@Resource(name="sysRoleMapper")
	private SysRoleMapper sysRoleMapper;   //处理角色的Mapper对象
	
	@Resource(name="sysRoleAndUserMapper")
	private SysRoleAndUserMapper sysRoleAndUserMapper;   //处理角色和用户关系的Mapper对象
	
	@Resource(name="sysRoleAndRightMapper")
	private SysRoleAndRightMapper sysRoleAndRightMapper;   //处理角色和菜单关系的Mapper对象
	
	@Resource(name="sysUserAndRightMapper")
	private SysUserAndRightMapper sysUserAndRightMapper;   //处理角色和用户关系的Mapper对象
	
	@Override
	public void updateSysDept(SysDept sysDept, String deptTypeIds) {
		// TODO Auto-generated method stub
		//1.修改部门表
		sysDeptMapper.updateByPrimaryKey(sysDept);
		//2.修改部门和类型关系表
		Map<String,Object> paraMap=new HashMap<String, Object>();
		paraMap.put("deptId", sysDept.getId());
		sysDeptAndTypeMapper.deleteByCondition(paraMap); //删除
		String [] typeIds=deptTypeIds.split(",");  //添加
		for(int i=0;i<typeIds.length;i++){
			SysDeptAndType sysDeptAndType = new SysDeptAndType();
			sysDeptAndType.setDeptid(sysDept.getId());
			sysDeptAndType.setTypeid(Integer.parseInt(typeIds[i]));
			sysDeptAndTypeMapper.insert(sysDeptAndType);
		}
	}

	@Override
	public void saveSysDept(SysDept sysDept, String deptTypeIds) {
		// TODO Auto-generated method stub
		//1.保存部门信息
		int maxOrderId = sysDeptMapper.findMaxOrderIdByFatherId(sysDept.getFatherId());
		sysDept.setOrderid(maxOrderId);
		sysDeptMapper.insert(sysDept);
		int deptId =sysDept.getId(); //mybatis返回id属性值
		//2.保存部门与类型的关系表信息
		String []deptTypeIdArr=deptTypeIds.split(",");
		for(int i=0;i<deptTypeIdArr.length;i++){
			String typeId = deptTypeIdArr[i];
			SysDeptAndType deptAndType=new SysDeptAndType();
			deptAndType.setDeptid(deptId);
			deptAndType.setTypeid(Integer.parseInt(typeId));
			sysDeptAndTypeMapper.insert(deptAndType);
		}
		
	}

	@Override
	public void deleteSysDept(String deptId) {
		// TODO Auto-generated method stub
		//1.删除关系表信息
		Map<String,Object> paramMap = new HashMap<String, Object>();
		paramMap.put("deptId", deptId); //封装部门ID
		sysDeptAndTypeMapper.deleteByCondition(paramMap);
		//2.删除部门表信息
		sysDeptMapper.deleteByPrimaryKey(Integer.parseInt(deptId));
	}

	@Override
	public SysDept findSysDeptByPK(String deptId) {
		// TODO Auto-generated method stub
		return sysDeptMapper.selectByPrimaryKey(Integer.parseInt(deptId));
	}
	/**
	 * 心一：查询部门列表
	 * @return
	 */
	@Override
	public List<SysDept> findSysDeptList() {
		// TODO Auto-generated method stub
//		SysDeptExample example = new SysDeptExample();
//		Criteria criteria=example.createCriteria();
		// Criteria criteria = example.createCriteria();
//		criteria.andIdEqualTo(1);
		List<SysDept>  deptList=sysDeptMapper.selectByExample(null);
		return deptList;
	}

	@Override
	public SysDept detailSysDept(String id) {
		// TODO Auto-generated method stub
		return sysDeptMapper.selectByPrimaryKey(Integer.parseInt(id));
	}



	/**
	 * 心一：查询部门类型
	 * @return
	 */
	@Override
	public List<SysDeptType> getSysDeptType() {
		// TODO Auto-generated method stub
		return sysDeptTypeMapper.selectByExample(null);
	}

	/**
	 * 心一：部门树<br>
	 * 查询部门信息树
	 * list =》 Tree
	 */
	@Override
	public List<EasyUIJsonTree> findSysDeptTree(SysDept sysDeptForparam) {
		// TODO Auto-generated method stub
		List<SysDept> sysDeptList=sysDeptMapper.findSysDeptListByCondition(sysDeptForparam);
		List<EasyUIJsonTree> easyUIJsonTreeList=new ArrayList<EasyUIJsonTree>();
		EasyUIJsonTree easyUIJsonTree=null;
		for(SysDept sd:sysDeptList){
			easyUIJsonTree = new EasyUIJsonTree();
			easyUIJsonTree.setId(String.valueOf(sd.getId()));
			easyUIJsonTree.setPno(String.valueOf(sd.getFatherId()));
			easyUIJsonTree.setText(String.valueOf(sd.getShortname()));
			easyUIJsonTreeList.add(easyUIJsonTree);
		}
		//集合列表结构=》为树形结构
		 List<EasyUIJsonTree> nodeList = new ArrayList<EasyUIJsonTree>(); 
		 for(EasyUIJsonTree node1 : easyUIJsonTreeList){ 
		     boolean mark = false; 
		     for(EasyUIJsonTree node2 : easyUIJsonTreeList){ 
		         if(node1.getPno()!=null && node1.getPno().equals(node2.getId())){ 
		             mark = true; 
		             if(node2.getChildren() == null) 
		                 node2.setChildren(new ArrayList<EasyUIJsonTree>()); 
		             node2.getChildren().add(node1);  
		             break; 
		         } 
		     } 
		     if(!mark){ 
		         nodeList.add(node1);  
		     }
		 }
		return nodeList;
	}
	

	@Override
	public List<SysDeptType> findAllSysDeptType() {
		// TODO Auto-generated method stub
		return sysDeptTypeMapper.selectByExample(null);
	}

	@Override
	public List<Map<String,Object>> findSysDeptTypeListByDeptId(String deptId) {
		// TODO Auto-generated method stub
		Map<String,Object> paraMap = new HashMap<String, Object>();
		paraMap.put("deptId", deptId);
		return sysDeptTypeMapper.findSysDeptTyptByDeptId(paraMap);
	}

	@Override
	public SysDeptType findSysDeptTypeByPK(String id) {
		// TODO Auto-generated method stub
		return sysDeptTypeMapper.selectByPrimaryKey(Integer.parseInt(id));
	}

	@Override
	public int findNextSysDeptTypeNo() {
		// TODO Auto-generated method stub
		return sysDeptTypeMapper.findMaxId()+1;
	}

	@Override
	public int saveSysDeptType(SysDeptType sysDeptType) {
		// TODO Auto-generated method stub
		return sysDeptTypeMapper.insert(sysDeptType);
	}

	@Override
	public int updateSysDeptType(SysDeptType sysDeptType) {
		// TODO Auto-generated method stub
		return sysDeptTypeMapper.updateByPrimaryKey(sysDeptType);
	}

	@Override
	public void deleteSysDeptByIds(String ids) {
		// TODO Auto-generated method stub
		String [] idsArr=ids.split(",");
		for(int i=0;i<idsArr.length;i++){
			sysDeptTypeMapper.deleteByPrimaryKey(Integer.parseInt(idsArr[i]));
		}
		
	}

	@Override
	public List<Map<String,Object>> findSysUserPageByCondition(Map<String, Object> paraMap) {
		// TODO Auto-generated method stub
		return sysUserMapper.findSysUserPageByCondition(paraMap);
	}

	@Override
	public int findSysUserCountByCondition(Map<String, Object> paraMap) {
		// TODO Auto-generated method stub
		return sysUserMapper.findSysUserCountByCondition(paraMap);
	}

	@Override
	public void saveSysUser(SysUser sysUser,String roleids) {
		// TODO Auto-generated method stub
		//1.添加用户
		sysUserMapper.insertSelective(sysUser);
		//2.添加用户角色
		String [] roleidsArr= roleids.split(",");
		for(int i=0;i<roleidsArr.length;i++){
			int roleId = Integer.parseInt(roleidsArr[i]);
			SysRoleAndUser sysRoleAndUser = new SysRoleAndUser();
			sysRoleAndUser.setRole(roleId);
			sysRoleAndUser.setSysuser(sysUser.getId());
			sysRoleAndUserMapper.insert(sysRoleAndUser);
		}
	}

	@Override
	public void updateSysUser(SysUser sysUser,String roleids) {
		// TODO Auto-generated method stub
		//一、修改用户信息
		sysUserMapper.updateByPrimaryKeySelective(sysUser);
		//二、修改所属角色信息
		//1.先删除
		sysRoleAndUserMapper.deleteByUserId(sysUser.getId());
		//2.后添加
		if(UtilValidate.isNotEmpty(roleids)){
			String [] roleidsArr= roleids.split(",");
			for(int i=0;i<roleidsArr.length;i++){
				int roleId = Integer.parseInt(roleidsArr[i]);
				SysRoleAndUser sysRoleAndUser = new SysRoleAndUser();
				sysRoleAndUser.setRole(roleId);
				sysRoleAndUser.setSysuser(sysUser.getId());
				sysRoleAndUserMapper.insert(sysRoleAndUser);
			}
		}
		
		
	}

	@Override
	public int deleteSysUser(String ids) {
		// TODO Auto-generated method stub
		int result = 0;
		String [] idsArr=ids.split(",");
		for(int i=0;i<idsArr.length;i++){
			result = sysUserMapper.deleteByPrimaryKey(Integer.parseInt(idsArr[i]));
		}
		return result;
	}

	@Override
	public List<SysUserType> findSysUserTypesByDeptId(String deptId) {
		// TODO Auto-generated method stub
		SysUserType sysUserType = new SysUserType();
		sysUserType.setDeptid(Integer.parseInt(deptId));
		return sysUserTypeMapper.findSysUserTypeListByDeptId(sysUserType);
	}

	@Override
	public List<SysRole> findAllSysRole() {
		// TODO Auto-generated method stub
		return sysRoleMapper.selectByExample(null);
	}

	@Override
	public int findCountByLoginName(String loginName) {
		// TODO Auto-generated method stub
		return sysUserMapper.findCountByLoginName(loginName);
	}

	@Override
	public SysUser findSysUserByPK(String id) {
		// TODO Auto-generated method stub
		return sysUserMapper.selectByPrimaryKey(Integer.parseInt(id));
	}

	@Override
	public List<SysRole> findRolesByUserId(String userId) {
		// TODO Auto-generated method stub
		return sysRoleMapper.findRolesByUserId(Integer.parseInt(userId));
	}

	@Override
	public void saveSysUserPermission(SysUser sysUser) {
		//1.根据用户id删除权限信息
		sysUserAndRightMapper.deleteByUserId(sysUser.getId());
		//2.插入权限信息
		List<SysUserAndRight> userAndRights = new ArrayList<SysUserAndRight>();
		String permission = sysUser.getEmail(); // 获取控制权限的总权限的ids
		if(permission != null && !("").equals(permission.trim())){ 
			int totalRights = 0;  //对应菜单总权限
			for(String perval : permission.split(",")){
				if(!("").equals(perval.trim())){
					totalRights = totalRights | (Integer.valueOf(perval));  //权限的加法|或
				}
			}
			//菜单权限MAP<rightId,rightVal>
			Map<String, Integer> rightMaps =new HashMap<String, Integer>(); //存储菜单ID和子权限
			// 获取所有选中的节点值(包括勾选状态和半勾选状态)
			String nodes = sysUser.getTypeofwork();
			if(nodes != null && !"".equals(nodes)){
				String[] nodesArr = nodes.split(","); //选中权限数组
				for(String node:nodesArr){
					if(node.contains("_")){  //1.是叶子节点（叶子节点=rightId_rightVal）
						String[] arr=node.split("_");
						String rightId= arr[0];
						String rightVal= arr[1];
						if ((totalRights & Integer.parseInt(rightVal)) > 0) {  //校验是否在菜单总权限之内
							if(rightMaps.containsKey(rightId)){
								rightMaps.put(rightId, rightMaps.get(rightId) | Integer.parseInt(rightVal));
							}else{
								rightMaps.put(rightId, Integer.parseInt(rightVal));
							}
						}
						
					}else{                  //2.不是叶子节点
						rightMaps.put(node, CommonValue.ALLFUNS.get(CommonValue.STSHOW));
					}
				}
				
				//封装SysUserAndRight对象
				if(rightMaps.entrySet().size() > 0){
					SysUserAndRight sysUserAndRight = null;
					for(Entry<String, Integer> entry : rightMaps.entrySet()){
						sysUserAndRight = new SysUserAndRight();
						sysUserAndRight.setSysuser(sysUser.getId());
						sysUserAndRight.setSysright(Integer.parseInt(entry.getKey()));
						sysUserAndRight.setChildrights(entry.getValue());
						userAndRights.add(sysUserAndRight);
					}
				}
				
				//批量插入用户所属权限集合
				sysUserAndRightMapper.saveSysUserAndRightByList(userAndRights);
			}	
			
		}
	}
	


	@Override
	public void savaSysRoleAndUserByUserId(SysUser sysUser, String language) {
		// TODO Auto-generated method stub
		//1.删除角色信息
		sysRoleAndUserMapper.deleteByUserId(sysUser.getId());
		//2.添加角色信息
				if(UtilValidate.isNotEmpty(language)){
					String [] roleidsArr= language.split(",");
					for(int i=0;i<roleidsArr.length;i++){
						int roleId = Integer.parseInt(roleidsArr[i]);
						SysRoleAndUser sysRoleAndUser = new SysRoleAndUser();
						sysRoleAndUser.setRole(roleId);
						sysRoleAndUser.setSysuser(sysUser.getId());
						sysRoleAndUserMapper.insert(sysRoleAndUser);
					}
				}
		
	}

	@Override
	public SysRole findSysRoleById(String id) {
		// TODO Auto-generated method stub
		return sysRoleMapper.selectByPrimaryKey(Integer.parseInt(id));
	}

	@Override
	public void updateSysRolePermission(SysRole sysRole) {
		// TODO Auto-generated method stub
		//1.删除角色与菜单关联信息
		SysRoleAndRightExample example = new SysRoleAndRightExample();  
		Criteria criteria = example.createCriteria();  
		criteria.andRoleEqualTo(sysRole.getId());
		sysRoleAndRightMapper.deleteByExample(example);
		//2.批量插入角色与菜单的关联信息（注意权限的操作）
		List<SysRoleAndRight> roleAndRights = new ArrayList<SysRoleAndRight>();
		String permission = sysRole.getName(); // 获取控制权限的总权限的ids
		if(permission != null && !("").equals(permission.trim())){ 
			int totalRights = 0;  //对应菜单总权限
			for(String perval : permission.split(",")){
				if(!("").equals(perval.trim())){
					totalRights = totalRights | (Integer.valueOf(perval));  //权限的加法|或
				}
			}
			//菜单权限MAP<rightId,rightVal>
			Map<String, Integer> rightMaps =new HashMap<String, Integer>(); //存储菜单ID和子权限
			// 获取所有选中的节点值(包括勾选状态和半勾选状态)
			String nodes = sysRole.getRemark();
			if(nodes != null && !"".equals(nodes)){
				String[] nodesArr = nodes.split(","); //选中权限数组
				for(String node:nodesArr){
					if(node.contains("_")){  //1.是叶子节点（叶子节点=rightId_rightVal）
						String[] arr=node.split("_");
						String rightId= arr[0];
						String rightVal= arr[1];
						if ((totalRights & Integer.parseInt(rightVal)) > 0) {  //校验是否在菜单总权限之内
							if(rightMaps.containsKey(rightId)){
								rightMaps.put(rightId, rightMaps.get(rightId) | Integer.parseInt(rightVal));
							}else{
								rightMaps.put(rightId, Integer.parseInt(rightVal));
							}
						}
					}else{                  //2.不是叶子节点,默认给一个浏览权限
						rightMaps.put(node, CommonValue.ALLFUNS.get(CommonValue.STSHOW));
					}
				}
				//封装SysRoleAndRight对象
				if(rightMaps.entrySet().size() > 0){
					SysRoleAndRight sysRoleAndRight = null;
					for(Entry<String, Integer> entry : rightMaps.entrySet()){
						sysRoleAndRight = new SysRoleAndRight();
						sysRoleAndRight.setRole(sysRole.getId());
						sysRoleAndRight.setSysright(Integer.parseInt(entry.getKey()));
						sysRoleAndRight.setChildrights(entry.getValue());
						roleAndRights.add(sysRoleAndRight);
					}
				}
				//批量插入用户所属权限集合
				sysRoleAndRightMapper.saveSysRoleAndRightByList(roleAndRights);
			
			}
		}
	}

	@Override
	public void moveSysDeptOrder(String currSysDeptId, String moveSysDeptId) {
		// TODO Auto-generated method stub
		//交换两部门的orderId
		SysDept sysDept = new SysDept();
		SysDept currSysDept = sysDeptMapper.selectByPrimaryKey(Integer.parseInt(currSysDeptId));
		SysDept moveSysDept = sysDeptMapper.selectByPrimaryKey(Integer.parseInt(moveSysDeptId));
		Integer orderId = currSysDept.getOrderid();
		currSysDept.setOrderid(moveSysDept.getOrderid());
		moveSysDept.setOrderid(orderId);
		sysDeptMapper.updateByPrimaryKeySelective(currSysDept);
		sysDeptMapper.updateByPrimaryKeySelective(moveSysDept);
	}

	@Override
	public int findCountRoleNameByRoleId(String id, String name) {
		// TODO Auto-generated method stub
		Map<String,Object> paraMap = new HashMap<String,Object>();
		paraMap.put("id", id);
		paraMap.put("name", name);
		return sysRoleMapper.findCountRoleNameByRoleId(paraMap);
	}

	@Override
	public void updateSysRole(SysRole sysRole) {
		// TODO Auto-generated method stub
		sysRoleMapper.updateByPrimaryKeySelective(sysRole);
	}

	@Override
	public void addSysRole(SysRole sysRole) {
		// TODO Auto-generated method stub
		sysRoleMapper.insert(sysRole);
	}

	@Override
	public void deleteSysRoleByPK(String id) {
		// TODO Auto-generated method stub
		sysRoleMapper.deleteByPrimaryKey(Integer.parseInt(id));
	}
	
	
	@Override
	public Map<String, Object> findSysUserTypePageByConditions(Map<String,Object> paramMap) {
		// TODO Auto-generated method stub
		Map<String,Object> resultMap=new HashMap<String, Object>();
		List<SysUserType> sysUserTypePage = null;
		int total = sysUserTypeMapper.findSysUserTypeCountByConditions(paramMap); //总条数
		Paging paging=(Paging) paramMap.get("paging");
		paging.setTotal(total);
		if(total > 0){
			sysUserTypePage = sysUserTypeMapper.findSysUserTypePageByConditions(paramMap);
		}
		resultMap.put("rows", sysUserTypePage);
		resultMap.put("total", total);
		resultMap.put("paging", paging);
		return resultMap;
	}

	@Override
	public void addSysUserType(SysUserType sysUserType) {
		// TODO Auto-generated method stub
		sysUserTypeMapper.insert(sysUserType);
		
	}

	@Override
	public void updateSysUserType(SysUserType sysUserType) {
		// TODO Auto-generated method stub
		sysUserTypeMapper.updateByPrimaryKeySelective(sysUserType);
	}

	@Override
	public int findCountTypeNameById(SysUserType sysUserType) {
		// TODO Auto-generated method stub
		return sysUserTypeMapper.findCountTypeNameById(sysUserType);
	}

	@Override
	public SysUserType findSysUserTypeByPK(Integer id) {
		// TODO Auto-generated method stub
		return sysUserTypeMapper.selectByPrimaryKey(id);
	}

	@Override
	public void deleteSysUserTypeByIds(String ids) {
		// TODO Auto-generated method stub
		String[] idsArr = ids.split(",");
		for(int i=0;i<idsArr.length;i++){
			Integer id = Integer.parseInt(idsArr[i]);
			sysUserTypeMapper.deleteByPrimaryKey(id);
		}
		
	}

	@Override
	public List<SysUserType> findALlSysUserType() {
		// TODO Auto-generated method stub
		return sysUserTypeMapper.selectByExample(null);
	}

}
