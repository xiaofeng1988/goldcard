package com.goldcard.goldcardiot.modules.sys.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.goldcard.goldcardiot.common.utils.CommonValue;
import com.goldcard.goldcardiot.common.utils.EasyUIJsonTree;
import com.goldcard.goldcardiot.common.utils.SessionUtil;
import com.goldcard.goldcardiot.common.utils.UtilValidate;
import com.goldcard.goldcardiot.models.SysRight;
import com.goldcard.goldcardiot.models.SysUser;
import com.goldcard.goldcardiot.modules.sys.service.ISysRightService;

/**
 * 权限管理控制器
 * 
 * @author 心一
 *
 */
@Controller
@RequestMapping("/sysRightController")
public class SysRightController {
	private Log log = LogFactory.getLog(SysRightController.class); // 处理日志的对象
	// private static MethodUtil util = new MethodUtil(); // 信息传递公用类

	@Resource(name = "sysRightService")
	private ISysRightService sysRightService; // 处理用户信息的服务类

	/**
	 * 心一：一级菜单
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/findSysRightOneLevel")
	@ResponseBody
	public List<EasyUIJsonTree> findSysRightOneLevel(HttpServletRequest request) {
		log.info("findSysRightOneLevel-load");
		List<Map<String, Object>> sysRightList = null;
		SysUser sysUser = (SysUser) SessionUtil.getAttr(request, CommonValue.SESSION_CURRENT_USER);
		if (sysUser != null && !"".equals(sysUser.getId())) {
			sysRightList = sysRightService.findSysRightOneLevel(sysUser);
		}
		// 封装成树形结构JSON对象
		List<EasyUIJsonTree> easyUIJsonTrees = new ArrayList<EasyUIJsonTree>();
		for (Map<String, Object> sysRightMap : sysRightList) {
			EasyUIJsonTree easyUIJsonTree = new EasyUIJsonTree();
			easyUIJsonTree.setId(String.valueOf(sysRightMap.get("id")));
			easyUIJsonTree.setIconCls(String.valueOf(sysRightMap.get("icon")));
			// 前台显示的格式是：名称（节点值）
			easyUIJsonTree.setText(String.valueOf(sysRightMap.get("name")));
			// 因为要标识当前节点是否是有子节点，并且有fatherId代替
			easyUIJsonTree.setState(String.valueOf(sysRightMap.get("father_id")));
			if (sysRightMap.get("url") != null) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("url", sysRightMap.get("url"));
				easyUIJsonTree.setAttributes(map);
			}
			easyUIJsonTrees.add(easyUIJsonTree);
		}
		return easyUIJsonTrees;
	}

	/**
	 * 心一：根据父菜单ID查询所有子菜单（父节点查询子节点）
	 * 递归查询所有子菜单
	 * @param request
	 * @param fatherId
	 * @return
	 */
	@RequestMapping(value = "/findSysRightByFatherId")
	@ResponseBody
	public List<EasyUIJsonTree> findSysRightByFatherId(HttpServletRequest request, String fatherId) {
		log.info("findSysRightByFatherId-load");
		Map<String, Object> paraMap = new HashMap<String, Object>();
		paraMap.put("fatherId", fatherId);
		SysUser sysUser = (SysUser) SessionUtil.getAttr(request, CommonValue.SESSION_CURRENT_USER);
		List<EasyUIJsonTree> easyUIJsonTrees = getSysRightsByFatherId(fatherId, String.valueOf(sysUser.getId()));
		return easyUIJsonTrees;
	}
	
	/**
	 * 心一：递归查询所有子菜单
	 * @param fatherId： 父节点
	 * @param userId：  当前用户ID
	 * @return
	 */
	public List<EasyUIJsonTree> getSysRightsByFatherId(String fatherId,String userId){
		List<EasyUIJsonTree> easyUIJsonTrees = new ArrayList<EasyUIJsonTree>();
		EasyUIJsonTree easyUIJsonTree = null;
		Map<String, Object> paraMap = new HashMap<String, Object>();
		paraMap.put("fatherId", fatherId);
		paraMap.put("userId", userId);
		List<Map<String, Object>> sysRightMapList = sysRightService.findCurrentUserSysRightByFatherId(paraMap);
        if(sysRightMapList.size()>0){
        	for (Map<String, Object> sysRightMap : sysRightMapList) {
    			easyUIJsonTree = new EasyUIJsonTree();
    			easyUIJsonTree.setId(String.valueOf(sysRightMap.get("id")));
    			easyUIJsonTree.setText(String.valueOf(sysRightMap.get("name")));
    			Map<String, Object> childrenMap = new HashMap<String, Object>();
    			childrenMap.put("url", sysRightMap.get("url"));
    			childrenMap.put("father_id", sysRightMap.get("father_id"));
    			easyUIJsonTree.setAttributes(childrenMap);
    			easyUIJsonTree.setChildren(this.getSysRightsByFatherId(sysRightMap.get("id").toString(), userId));
    			easyUIJsonTrees.add(easyUIJsonTree);
    			
    		}
        }
		return easyUIJsonTrees;
	}

	/**
	 * 心一：获取当前用户的所有菜单
	 * 
	 * @return
	 */
	@RequestMapping(value = "/findSysRightListByCurrentUserId")
	@ResponseBody
	public List<EasyUIJsonTree> findSysRightListByCurrentUserId() {
		String userId = "1";
		List<EasyUIJsonTree> resultTree = sysRightService.findSysRightListByCurrentUserId(userId);
		return resultTree;
	}

	/**
	 * 心一：获取菜单Tree
	 * 
	 * @param id
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/list/findAllSysRight")
	@ResponseBody
	public List<EasyUIJsonTree> findAllSysRightByCurrentUserJson(String id, HttpServletRequest request) {
		log.info("findAllSysRight...");
		List<EasyUIJsonTree> resultTree = null;
		SysUser sysUser = (SysUser) SessionUtil.getAttr(request, CommonValue.SESSION_CURRENT_USER);
		if (sysUser != null && !"".equals(sysUser.getId())) {
			resultTree = sysRightService.findSysRightListByCurrentUserId(sysUser.getId().toString());
		}
		return resultTree;
	}

	/**
	 * 心一：展示菜单信息
	 * 
	 * @param nodeid
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/{id}/detailSysRight")
	public String findSysRightByNodeId(@PathVariable String id, Model model) {
		SysRight sysRight = sysRightService.findSysRightByPK(id);
		Map<String, Integer> maps = new HashMap<String, Integer>();
		model.addAttribute(sysRight);
		for (Entry<String, Integer> entry : CommonValue.ALLFUNS.entrySet()) {
			if (sysRight.getChildrights() != null) {
				maps.put(entry.getKey(), (entry.getValue() & sysRight.getChildrights().intValue()));
			} else {
				maps.put(entry.getKey(), (0));
			}
		}
		model.addAttribute("allfuns", maps);
		return "system/sysright/detail";
	}

	/**
	 * 心一：show菜单信息
	 * 
	 * @return
	 */
	@RequestMapping(value = "/addDialog")
	public String addDialog() {
		return "system/sysright/addDialog";
	}

	/**
	 * 心一：添加菜单load
	 * 
	 * @return
	 */
	@RequestMapping(value = "/{id}/addSysRight")
	public String addSysRight(@PathVariable String id, Model model) {
		SysRight sysRight = sysRightService.findSysRightByPK(id);
		model.addAttribute("FatherSysRight", sysRight);
		model.addAttribute("isNew", 0);
		model.addAttribute("allfuns", CommonValue.ALLFUNS); // 权限
		return "system/sysright/add";
	}
	
	/**
	 * 心一：删除菜单信息
	 * 1.如果此菜单没有子菜单则删除此菜单
	 * 2.如果此菜单有子菜单则递归删除此菜单以下的所有菜单
	 * @param nodeid
	 * @param mname
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/sysright/deleteSysRight/{nodeid}"  )
	@ResponseBody
	public String deleteSysRight(@PathVariable String nodeid, String mname,HttpServletRequest request){
		try {
			if(UtilValidate.isNotEmpty(nodeid)){
				sysRightService.deleteSysRight(Integer.parseInt(nodeid));;
			}
//			this.sysLogService.sysLogHandle(request, CommonValue.STDELETE, CommonValue.OOT.功能注册, mname);
			return "0";
		} catch (Exception e) {
			return "1";
		}
		
	}

	/**
	 * 心一：修改保存菜单信息
	 * 
	 * @param response
	 * @param sysRight
	 */
	@RequestMapping(value = "/sysRight/save")
	public String saveSysRight(HttpServletResponse response, SysRight sysRight, String fun) {
		try {
			// 处理权限
			int count = 0;
			if (fun != null && !("").equals(fun.trim())) {
				String[] funs = fun.split(",");
				for (String f : funs) {
					int inf = Integer.valueOf(f);
					count = count | inf; // 位运算
				}
			}
			sysRight.setChildrights(count); // 权限

			if (sysRight.getId() == null || "".equals(sysRight.getId())) {
				if(sysRight.getFatherId() == null || "".equals(sysRight.getFatherId())){
					sysRight.setFatherId(0);  //根节点
					sysRight.setLevel(0);  //一级菜单
				}
				sysRight.setLevel(sysRight.getLevel() + 1);
				sysRightService.addSysRight(sysRight);
			} else {
				sysRight.setFatherId(null); // 修改时父节点置空
				sysRightService.updateSysRight(sysRight);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return "system/sysright/list";
	}

	/**
	 * 心一：编辑菜单
	 * 
	 * @param nodeid
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/{id}/editSysRight")
	public String editSysRight(@PathVariable String id, Model model) {
		SysRight sysRight = sysRightService.findSysRightByPK(id);
		model.addAttribute(sysRight);
		model.addAttribute("isNew", 0);
		model.addAttribute("sysRight", sysRight);
		model.addAttribute("FatherSysRight", sysRight);
		model.addAttribute("allfuns", CommonValue.ALLFUNS);
		return "system/sysright/add";
	}

	/**
	 * 心一：查询当前用户所有功能模块的权限
	 * 
	 * @param userId:用户id
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/list/{userId}/findAllSysRightChildRight")
	@ResponseBody
	public List<EasyUIJsonTree> findAllSysRightChildRightJson(@PathVariable String userId, String id) {
		log.info("findAllSysRightChildRight...");
		List<EasyUIJsonTree> resultJson = sysRightService.findSysRightsByUserId(userId);
		return resultJson;
	}

	/**
	 * 心一：获取当前角色所有菜单的权限信息
	 * 
	 * @param sysRoleId：角色Id
	 * @return
	 */
	@RequestMapping(value = "/{sysRoleId}/findAllSysRightChildRightByRole")
	@ResponseBody
	public List<EasyUIJsonTree> findAllSysRightChildRightJsonByRole(@PathVariable String sysRoleId) {
		log.info("findAllSysRightChildRightByRole...");
		List<EasyUIJsonTree> resultJson = sysRightService.findSysRightsByRoleId(sysRoleId);
		return resultJson;
	}
	/**
	 * 心一：上移菜单节点
	 * 排序原理：移动互换位置
	 * @param nodeId
	 * @param preNodeId
	 */
	@RequestMapping(value="/sysright/moveUpSysright")
	public void moveUpSysright(String nodeId, String preNodeId){
		sysRightService.moveUpSysright(nodeId, preNodeId);
	}
	/**
	 * 心一：下移菜单节点
	 * 排序原理：移动互换位置
	 * @param nodeId
	 * @param preNodeId
	 */
	@RequestMapping(value="/sysright/moveDownSysright")
	public void moveDownSysright(String nodeId, String preNodeId){
		sysRightService.moveDownSysright(nodeId, preNodeId);
	}

}
