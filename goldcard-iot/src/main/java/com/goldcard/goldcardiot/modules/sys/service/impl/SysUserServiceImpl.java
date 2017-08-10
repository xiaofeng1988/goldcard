package com.goldcard.goldcardiot.modules.sys.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.goldcard.goldcardiot.dao.SysRightMapper;
import com.goldcard.goldcardiot.dao.SysUserAndRightMapper;
import com.goldcard.goldcardiot.dao.SysUserMapper;
import com.goldcard.goldcardiot.dao.SysUserOnlineMapper;
import com.goldcard.goldcardiot.dao.SysUserTypeMapper;
import com.goldcard.goldcardiot.models.SysUser;
import com.goldcard.goldcardiot.models.SysUserAndRight;
import com.goldcard.goldcardiot.models.SysUserOnline;
import com.goldcard.goldcardiot.modules.sys.service.ISysUserService;

@Service("sysUserService")
@Transactional
public class SysUserServiceImpl implements ISysUserService {
	
	@Resource(name="sysUserMapper")
	private SysUserMapper sysUserMapper; //处理用户信息的Mapper对象
	
	@Resource(name="sysUserTypeMapper")
	private SysUserTypeMapper sysUserTypeMapper; //处理用户信息的Mapper对象
	
	@Resource(name="sysUserAndRightMapper")
	private SysUserAndRightMapper sysUserAndRightMapper; //处理用户和权限信息的Mapper对象
	
	@Resource(name="sysRightMapper")
	private SysRightMapper sysRightMapper; //处理权限信息的Mapper对象
	
	@Resource(name="sysUserOnlineMapper")
	private SysUserOnlineMapper sysUserOnlineMapper; //在线人员信息的Mapper对象
	
	public SysUser findUserById(int id) {
		return this.sysUserMapper.selectByPrimaryKey(id);
	}

	public SysUser findUserByLoginfo(SysUser sysUser) {
		return sysUserMapper.findUserByLoginfo(sysUser);
	}

	public void updateUserPasswd(Long uid, String pwd) {
		
	}
	
	public void updateUserPasswd(SysUser usr) {
//		int rtn = 0;
//		rtn = this.sysUserMapper.updateByPrimaryKey(usr);
//		usr.setLoginName(usr.getLoginName()+"2");
//		rtn = this.sysUserMapper.updateByPrimaryKey(usr);
	}

	@Override
	public int findSysUserCount() {
		// TODO Auto-generated method stub
		SysUser as=sysUserMapper.selectByPrimaryKey(1);
		System.out.println(as.getLoginname());
		return 0;
	}

	@Override
	public List<Map<String, Object>> findAllSysUserList() {
		// TODO Auto-generated method stub
		
		return null;
	}

	/**
	 * 心一：权限map集[sysright:childrights]
	 */
	@Override
	public Map<String,Integer> findSysRightsByUserId(Integer userId) {
		// TODO Auto-generated method stub
		Map<String,Integer> resultMap=new HashMap<String, Integer>();
		Map<String,Object> paramMap=new HashMap<String, Object>();
		paramMap.put("sysuser", userId);
		List<SysUserAndRight> suarList = sysUserAndRightMapper.findListByCondition(paramMap);
	    for(SysUserAndRight suar:suarList){
	    	resultMap.put(String.valueOf(suar.getSysright()), suar.getChildrights());
	    }
		return resultMap;
	}

	@Override
	public Map<String, Integer> findSysRightsByUserIdAndRightId(Integer userId, Integer rightId) {
		// TODO Auto-generated method stub
		Map<String,Integer> resultMap=new HashMap<String, Integer>();
		Map<String,Object> paramMap=new HashMap<String, Object>();
		paramMap.put("sysuser", userId);
		paramMap.put("sysright", rightId);
		List<SysUserAndRight> suarList = sysUserAndRightMapper.findListByCondition(paramMap);
		//根据业务知道此处只有一条信息：（单一用户） + （单一菜单） = （单一权限）
	    for(SysUserAndRight suar:suarList){
	    	resultMap.put(String.valueOf(suar.getSysright()), suar.getChildrights());
	    }
		return resultMap;
	}

	
	@Override
	public Map<String, Integer> findAllUrlByUserId(Integer userId) {
		// TODO Auto-generated method stub
		Map<String, Integer> resultMap = new HashMap<String, Integer>();
		Map<String, Object> paraMap = new HashMap<String, Object>();
		paraMap.put("userId", userId);
		List<Map<String,Object>>  resultMapList = sysRightMapper.findSysRightListByCurrentUserId(paraMap);
		for(Map<String,Object> map:resultMapList){
			// <url,rightId> = <路径,菜单id>
			resultMap.put(String.valueOf(map.get("url")), Integer.parseInt(map.get("id").toString()));
		}
		return resultMap;
	}

	@Override
	public Map<String, Object> findSysUserOnlineByUserId(Integer userId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void saveSysUserOnline(SysUserOnline sysUserOnline) {
		// TODO Auto-generated method stub
		sysUserOnlineMapper.insert(sysUserOnline);
	}

	@Override
	public void updateSysUserOnline(SysUserOnline sysUserOnline) {
		// TODO Auto-generated method stub
		sysUserOnlineMapper.updateByPrimaryKeySelective(sysUserOnline);
	}

	@Override
	public Map<String, Object> findSysUserOnlineRemarkByUserId(Integer userId) {
		// TODO Auto-generated method stub
		return sysUserOnlineMapper.findSysUserOnlineRemarkByUserId(userId);
	}


}
