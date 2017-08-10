package com.goldcard.goldcardiot.modules.sys.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.goldcard.goldcardiot.common.utils.CommonValue;
import com.goldcard.goldcardiot.common.utils.EasyUIJsonTree;
import com.goldcard.goldcardiot.common.utils.GeneralTree;
import com.goldcard.goldcardiot.common.utils.UtilValidate;
import com.goldcard.goldcardiot.dao.SysRightMapper;
import com.goldcard.goldcardiot.dao.SysUserAndRightMapper;
import com.goldcard.goldcardiot.models.SysRight;
import com.goldcard.goldcardiot.models.SysRightExample;
import com.goldcard.goldcardiot.models.SysRightExample.Criteria;
import com.goldcard.goldcardiot.models.SysUser;
import com.goldcard.goldcardiot.modules.sys.service.ISysRightService;
/**
 * 权限实现类
 * @author 心一
 *
 */
@Service("sysRightService")
@Transactional
public class SysRightServiceImpl implements ISysRightService{

	/**
	 * 处理权限信息
	 */
	@Resource(name="sysRightMapper")
	private SysRightMapper sysRightMapper;
	/**
	 * 处理用户和权限信息
	 */
	@Resource(name="sysUserAndRightMapper")
	private SysUserAndRightMapper sysUserAndRightMapper;  
	
	@Override
	public List<Map<String,Object>> findSysRightOneLevel(SysUser sysUser) {
		// TODO Auto-generated method stub
		Map<String,Object> paramMap=new HashMap<String,Object>();
		paramMap.put("user", sysUser);
		return sysRightMapper.findSysRightOneLevel(paramMap);
	}

	@Override
	public List<Map<String, Object>> findSysRightByFatherId(Integer fatherId) {
		// TODO Auto-generated method stub
		return sysRightMapper.findSysRightByFatherId(fatherId);
	}
	
	// findCurrentUserSysRightByFatherId
	@Override
	public List<Map<String, Object>> findCurrentUserSysRightByFatherId(Map<String, Object> paraMap) {
		// TODO Auto-generated method stub
		//findCurrentUserSysRightByFatherId
		return sysRightMapper.findCurrentUserSysRightByFatherId(paraMap);
	}
	
	/**
	 * 获取当前用户的权限列表
	 * 集合转换为树形结构：list->tree(N*N的复杂度)
	 */
	@Override
	public List<EasyUIJsonTree> findSysRightListByCurrentUserId(String userId) {
		// TODO Auto-generated method stub
		 Map<String, Object> paraMap = new HashMap<String, Object>();
		 paraMap.put("userId", userId);
		 List<Map<String, Object>> sysRightMapList = sysRightMapper.findSysRightListByCurrentUserId(paraMap);
		 List<EasyUIJsonTree> easyUIJsonTreeList = new ArrayList<EasyUIJsonTree>();
		 EasyUIJsonTree easyUIJsonTree = null;
		 for(Map<String, Object> map:sysRightMapList){
		 easyUIJsonTree = new EasyUIJsonTree();
		 easyUIJsonTree.setId(String.valueOf(map.get("id")));
		 easyUIJsonTree.setText(String.valueOf(map.get("name")));
		 easyUIJsonTree.setPno(String.valueOf(map.get("father_id")));
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
	public SysRight findSysRightByPK(String id) {
		// TODO Auto-generated method stub
		return sysRightMapper.selectByPrimaryKey(Integer.parseInt(id));
	}

	@Override
	public int addSysRight(SysRight sysRight) {
		// TODO Auto-generated method stub
		int maxOrder= sysRightMapper.findMaxOrderByLevel(sysRight.getLevel());
		sysRight.setOrderid(maxOrder+1); //插入的下一个序号
		return sysRightMapper.insert(sysRight);
	}

	@Override
	public int updateSysRight(SysRight sysRight) {
		// TODO Auto-generated method stub
		return sysRightMapper.updateByPrimaryKeySelective(sysRight);
	}

	@Override
	public List<EasyUIJsonTree> findSysRightsByUserId(String userId) {
		// TODO Auto-generated method stub
		List<EasyUIJsonTree>  easyUIJsonTreeList = new ArrayList<EasyUIJsonTree>();
		EasyUIJsonTree easyUIJsonTree = null;
		Map<String,Object> paraMap = new HashMap<String, Object>();
		paraMap.put("userId", userId);
		List<Map<String,Object>> resultMapList = sysRightMapper.findSysRightListByCurrentUserId(paraMap);
		Map<Integer,Integer> userRightsMap=new HashMap<Integer,Integer>();
		for(Map<String,Object> userRights:resultMapList){
			userRightsMap.put(Integer.parseInt(userRights.get("id").toString()), Integer.parseInt(userRights.get("userrights").toString()));
		}
		//全查询所有可用菜单集合
		List<SysRight> sysRightList = sysRightMapper.selectByExample(null);
		//封装数据结构-Tree数据体
		GeneralTree tree = new GeneralTree();  
		for (SysRight sysRight : sysRightList) {
			tree.addNode(sysRight.getFatherId().toString(), sysRight.getId().toString());
		}
		for(SysRight sysRight:sysRightList){
			easyUIJsonTree = new EasyUIJsonTree();
			easyUIJsonTree.setId(String.valueOf(sysRight.getId()));
			easyUIJsonTree.setText(String.valueOf(sysRight.getName()));
			easyUIJsonTree.setPno(String.valueOf(sysRight.getFatherId()));
			// 因为要标识当前节点是否是有子节点，并且有fatherId代替
			easyUIJsonTree.setState(String.valueOf(sysRight.getFatherId())); 
			
			//判断是否叶子节点,这样查询不好，又犯了调用数据库的错误，看能否有直接程序处理的办法*****add by xiaofeng优化（去除数据库连接，直接在GeneralTree中判断）
			boolean isLeaf = tree.getChild(sysRight.getId().toString()).size() < 1;
			if(isLeaf){
				int childrights = 0; //初始化菜单权限为0
				if(sysRight.getChildrights() != null && !"".equals(sysRight.getChildrights())){
					childrights = sysRight.getChildrights();
				}
				int userrights = 0;  //初始化用户所属的菜单权限为0
				if(userRightsMap.get(sysRight.getId()) != null && !"".equals(userRightsMap.get(sysRight.getId()))){
					userrights = userRightsMap.get(sysRight.getId());
				}
				List<EasyUIJsonTree> jsonTrees = new ArrayList<EasyUIJsonTree>(); //  声明一个集合用来存储子权限
				Set<Entry<String, Integer>> entries = CommonValue.ALLFUNS.entrySet(); // 获取所有的权限集合
				for(Entry<String, Integer> entity : entries){ 
					EasyUIJsonTree uiJsonTree = new EasyUIJsonTree();
					int rightval = entity.getValue() & childrights; // 判断当前模块是否有权限
					if (rightval > 0) {
						uiJsonTree.setId(sysRight.getId() + "_" + entity.getValue()); // 拼装当前权限的id
						uiJsonTree.setText(entity.getKey()); //  权限的名称
						uiJsonTree.setState(CommonValue.TREE_OPEN_STATE); // 设置节点的状态 
						jsonTrees.add(uiJsonTree);
						if((entity.getValue() & userrights) > 0){
							uiJsonTree.setChecked(true);
						}
					}
				}
				easyUIJsonTree.setChildren(jsonTrees); // 设置当前节点的子节点
			}
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
	public List<EasyUIJsonTree> findSysRightsByRoleId(String roleId) {
		// TODO Auto-generated method stub
		List<EasyUIJsonTree>  easyUIJsonTreeList = new ArrayList<EasyUIJsonTree>();
		EasyUIJsonTree easyUIJsonTree = null;
		Map<String,Object> paraMap = new HashMap<String, Object>();
		paraMap.put("roleId", roleId);
		//当前角色的菜单集合
		List<Map<String,Object>> resultMapList = sysRightMapper.findSysRightListByCurrentRoleId(paraMap);
		//封装当前角色的权限Map
		Map<Integer, Integer> roleRightsMaps= new HashMap<Integer, Integer>();
		for(Map<String,Object> resultMap:resultMapList){
			roleRightsMaps.put(Integer.parseInt(resultMap.get("id").toString()), Integer.parseInt(resultMap.get("rolerights").toString()));
		}
		// 全查询所有可用菜单集合,并封装成Tree
		List<SysRight> sysRightList = sysRightMapper.selectByExample(null);
		//封装数据结构-Tree数据体
		GeneralTree tree = new GeneralTree();  
		for (SysRight sysRight : sysRightList) {
			tree.addNode(sysRight.getFatherId().toString(), sysRight.getId().toString());
		}
		for (SysRight sysRight : sysRightList) {
			easyUIJsonTree = new EasyUIJsonTree();
			easyUIJsonTree.setId(String.valueOf(sysRight.getId()));
			easyUIJsonTree.setText(String.valueOf(sysRight.getName()));
			easyUIJsonTree.setPno(String.valueOf(sysRight.getFatherId()));
			//判断是否是叶子节点
			boolean isLeaf = tree.getChild(sysRight.getId().toString()).size() < 1;
			if(isLeaf){
				int childrights = 0; //初始化菜单权限为0
				if(sysRight.getChildrights() != null && !"".equals(sysRight.getChildrights())){
					childrights = sysRight.getChildrights();
				}
				int rolerights = 0;  //初始化角色所属的菜单权限为0
				if(roleRightsMaps.get(sysRight.getId()) != null && !"".equals(roleRightsMaps.get(sysRight.getId()))){
					rolerights = roleRightsMaps.get(sysRight.getId());
				}
				List<EasyUIJsonTree> jsonTrees = new ArrayList<EasyUIJsonTree>(); //  声明一个集合用来存储子权限
				Set<Entry<String, Integer>> entries = CommonValue.ALLFUNS.entrySet(); // 获取所有的权限集合
				for(Entry<String, Integer> entity : entries){ 
					EasyUIJsonTree uiJsonTree = new EasyUIJsonTree();
					int rightval = entity.getValue() & childrights; // 判断当前模块是否有权限
					if (rightval > 0) {
						uiJsonTree.setId(sysRight.getId() + "_" + entity.getValue()); // 拼装当前权限的id
						uiJsonTree.setText(entity.getKey()); //  权限的名称
						uiJsonTree.setState(CommonValue.TREE_OPEN_STATE); // 设置节点的状态 
						jsonTrees.add(uiJsonTree);
						if((entity.getValue() & rolerights) > 0){
							uiJsonTree.setChecked(true);
						}
					}
				}
				easyUIJsonTree.setChildren(jsonTrees); // 设置当前节点的子节点
			}
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

	/**
	 * 心一：删除菜单信息
	 * 1.如果此菜单没有子菜单则删除此菜单
	 * 2.如果此菜单有子菜单则删除子菜单
	 * @param sysRight  菜单对象
	 * @return
	 */
	@Override
	public int deleteSysRight(int id) {
		// TODO Auto-generated method stub
		deleteSysRightDiGui(id);
		return 0;
	}
	
	//递归删除(若有子节点则删除)
	public void deleteSysRightDiGui(int id){
		 sysRightMapper.deleteByPrimaryKey(id);
		 List<Map<String,Object>> childSysRights = sysRightMapper.findSysRightByFatherId(id);
		 if(childSysRights.size()>0){
			 for(Map<String,Object> map:childSysRights){
				 deleteSysRightDiGui(Integer.parseInt(map.get("id").toString()));
			 }
		 }
	}

	@Override
	public SysRight findSysRightByUrl(String URL) {
		// TODO Auto-generated method stub
		SysRight sysRight = null;
		SysRightExample example = new SysRightExample();
		Criteria criteria=example.createCriteria();
		criteria.andUrlEqualTo(URL);
		List<SysRight> sysRightList= sysRightMapper.selectByExample(example);
		if(sysRightList.size()>0){
			sysRight = sysRightList.get(0);
		}
		return sysRight;
	}

	@Override
	public void moveUpSysright(String nodeId, String preNodeId) {
		// TODO Auto-generated method stub
		if(UtilValidate.isNotEmpty(nodeId) && UtilValidate.isNotEmpty(preNodeId)){
			int swapOrderId = 0;
			SysRight upSysRight = sysRightMapper.selectByPrimaryKey(Integer.parseInt(nodeId));
			SysRight DownSysRight = sysRightMapper.selectByPrimaryKey(Integer.parseInt(preNodeId));
			//互换orderId
			swapOrderId = upSysRight.getOrderid();
			upSysRight.setOrderid(DownSysRight.getOrderid());
			DownSysRight.setOrderid(swapOrderId);
			sysRightMapper.updateByPrimaryKeySelective(upSysRight);
			sysRightMapper.updateByPrimaryKeySelective(DownSysRight);
		}
	
		
	}

	@Override
	public void moveDownSysright(String nodeId, String preNodeId) {
		// TODO Auto-generated method stub
		if(UtilValidate.isNotEmpty(nodeId) && UtilValidate.isNotEmpty(preNodeId)){
			int swapOrderId = 0;
			SysRight upSysRight = sysRightMapper.selectByPrimaryKey(Integer.parseInt(nodeId));
			SysRight DownSysRight = sysRightMapper.selectByPrimaryKey(Integer.parseInt(preNodeId));
			//互换orderId
			swapOrderId = upSysRight.getOrderid();
			upSysRight.setOrderid(DownSysRight.getOrderid());
			DownSysRight.setOrderid(swapOrderId);
			sysRightMapper.updateByPrimaryKeySelective(upSysRight);
			sysRightMapper.updateByPrimaryKeySelective(DownSysRight);
		}
	
	}
	
	
	
	
	
}
