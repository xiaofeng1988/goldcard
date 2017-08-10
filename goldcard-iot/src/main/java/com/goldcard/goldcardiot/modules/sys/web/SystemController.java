package com.goldcard.goldcardiot.modules.sys.web;

import java.io.PrintWriter;
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
import org.springframework.web.multipart.MultipartFile;

import com.goldcard.goldcardiot.common.utils.CommonValue;
import com.goldcard.goldcardiot.common.utils.EasyUIJsonTree;
import com.goldcard.goldcardiot.common.utils.EasyUiComBox;
import com.goldcard.goldcardiot.common.utils.MD5Utils;
import com.goldcard.goldcardiot.common.utils.MethodUtil;
import com.goldcard.goldcardiot.common.utils.Paging;
import com.goldcard.goldcardiot.common.utils.SessionUtil;
import com.goldcard.goldcardiot.common.utils.UtilValidate;
import com.goldcard.goldcardiot.models.SysDept;
import com.goldcard.goldcardiot.models.SysDeptType;
import com.goldcard.goldcardiot.models.SysRole;
import com.goldcard.goldcardiot.models.SysUser;
import com.goldcard.goldcardiot.models.SysUserType;
import com.goldcard.goldcardiot.modules.sys.service.ISystemService;

/***
 * 心一：项目系统管理模块的控制器<br>
 * 主要包括一下模块：<br>
 * 1：部门管理<br>
 * 2：用户管理<br>
 * 3：角色管理<br>
 * 4：注册功能<br>
 * 
 * @author xinyi
 *
 */

@Controller
@RequestMapping("/systemController")
public class SystemController {

	private Log log = LogFactory.getLog(SystemController.class); // 处理日志的对象
	private static MethodUtil utilApi = new MethodUtil(); // 信息传递公用类

	@Resource(name = "systemService")
	private ISystemService systemService; // 处理系统管理的基础服务类

	// 部门管理load
	@RequestMapping("/sysDept/load")
	public String sysDeptLoad() {
		log.info("sysdept/list");
		return "system/sysdept/list";
	}

	// 功能注册load
	@RequestMapping(value = "/sysRight/load")
	public String findSysRightListLoad() {
		return "system/sysright/list";
	}

	// 部门类型load
	@RequestMapping(value = "/sysDeptType/load")
	public String sysDeptTypeLoad() {
		return "system/sysdepttype/list";
	}

	// show菜单信息
	@RequestMapping(value = "/sysRight/addDialog")
	public String addDialog() {
		return "system/sysright/addDialog";
	}

	/**
	 * 心一：记录操作日志（用户操作轨迹）
	 * 
	 * @param id
	 * @param name
	 * @return
	 */
	@RequestMapping("/addSysLog")
	@ResponseBody
	public Map<String, Object> addSysLog(String id, String name) {
		log.info("system/addSysLog");
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("status", true);
		resultMap.put("data", "");
		return resultMap;
	}

	/** ====================部门管理====================== */

	/**
	 * 心一：部门树
	 * 
	 * @return
	 */
	@RequestMapping(value = "/dept/tree")
	@ResponseBody
	public List<EasyUIJsonTree> findSysDeptTrees(String fatherId) {
		log.info("findSysDeptTrees...");
		SysDept sysDept = new SysDept();
		return systemService.findSysDeptTree(sysDept);
	}

	/**
	 * 心一：部门详情
	 * 
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/sysDept/{id}/detailSysDept")
	public String detailSysDept(@PathVariable String id, Model model) {
		Map<String, Object> sysDeptMap = new HashMap<String, Object>();
		SysDept sysDept = systemService.detailSysDept(id);
		sysDeptMap.put("id", sysDept.getId());
		sysDeptMap.put("name", sysDept.getName());
		sysDeptMap.put("shortname", sysDept.getShortname());
		StringBuffer sb = new StringBuffer();
		if (sysDept.getId() != null) {
			List<Map<String, Object>> sysDeptTypeMapList = systemService
					.findSysDeptTypeListByDeptId(sysDept.getId().toString());
			int leng = sysDeptTypeMapList.size();
			for (int i = 0; i < leng; i++) {
				Map<String, Object> map = sysDeptTypeMapList.get(i);
				if (leng == 1 || leng == i + 1) {
					sb.append(map.get("name")); // 部门类型名称
				} else {
					sb.append(map.get("name"));
					sb.append("，");
				}
			}
		}
		sysDeptMap.put("typeName", sb);
		model.addAttribute("sysDept", sysDeptMap);
		return "system/sysdept/detail";
	}

	/**
	 * 心一：初始化添加部门信息
	 * 
	 * @param deptId
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/sysDept/addSysDeptLoad")
	@ResponseBody
	public Map<String, Object> addSysDeptload(String deptId, Model model) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		SysDept sysDept = systemService.detailSysDept(deptId);
		resultMap.put("sysDept", sysDept);
		return resultMap;
	}

	/**
	 * 心一：部门类型列表封装ComBox
	 * 
	 * @return
	 */
	@RequestMapping(value = "/getSysDeptType")
	@ResponseBody
	public List<EasyUiComBox> getSysDeptType() {
		List<SysDeptType> sysdepttype = systemService.findAllSysDeptType();// 获取所有的部门类型
		List<EasyUiComBox> easyUiComBoxs = new ArrayList<EasyUiComBox>();
		for (SysDeptType type : sysdepttype) {
			EasyUiComBox comBox = new EasyUiComBox(type.getId() + "", type.getName(), false);
			easyUiComBoxs.add(comBox);
		}
		return easyUiComBoxs;
	}

	/**
	 * 心一：保存部门信息
	 * 
	 * @param sysDept
	 * @param deptTypeIds
	 * @param oSysDeptName
	 * @param request
	 * @param cimg
	 * @return
	 */
	@RequestMapping(value = "/sysDept/saveSysDept")
	public String saveSysDept(SysDept sysDept, String deptTypeIds, String oSysDeptName, HttpServletRequest request,
			MultipartFile cimg) {
		try {
			if (sysDept.getId() != null && !"".equals(sysDept.getId())) { // 修改
				systemService.updateSysDept(sysDept, deptTypeIds);
			} else { // 新增
				systemService.saveSysDept(sysDept, deptTypeIds);
			}

		} catch (Exception ex) {
			log.info(ex.getMessage());
			ex.printStackTrace();
		}
		return "system/sysdept/list";
	}

	/**
	 * 心一：删除部门信息
	 * 
	 * @param deptId
	 * @return
	 */
	@RequestMapping(value = "/sysDept/deleteSysDept")
	public String deleteSysDept(String deptId) {
		try {
			log.info("deleteSysDept");
			systemService.deleteSysDept(deptId);
		} catch (Exception ex) {
			log.info(ex.getMessage());
			ex.printStackTrace();
		}
		// 重定向部门主页信息
		return "system/sysdept/list";
	}

	/**
	 * 心一：编辑部门信息
	 * 
	 * @param deptId
	 * @return
	 */
	@RequestMapping(value = "/sysDept/editSysDept")
	@ResponseBody
	public Map<String, Object> editSysDept(String deptId) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		SysDept sysDept = systemService.findSysDeptByPK(deptId);
		resultMap.put("sysDept", sysDept);
		List<Map<String, Object>> sysDeptTypes = this.systemService.findSysDeptTypeListByDeptId(deptId);
		resultMap.put("sysDeptTypes", sysDeptTypes);
		return resultMap;
	}

	/**
	 * 心一：部门类型列表
	 * 
	 * @return
	 */
	@RequestMapping(value = "/sysDeptType/findSysDeptTypeList")
	@ResponseBody
	public List<SysDeptType> findSysDeptTypeList() {
		return systemService.findAllSysDeptType();
	}

	/**
	 * 心一：修改部门类型信息
	 * 
	 * @param sysDeptTypeId
	 *            部门类型主键id
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/sysDeptType/{sysDeptTypeId}/editSysDeptTypeId")
	public String editSysDeptType(@PathVariable String sysDeptTypeId, Model model) {
		SysDeptType sysDeptType = systemService.findSysDeptTypeByPK(sysDeptTypeId);
		model.addAttribute("sysDeptType", sysDeptType);
		return "system/sysdepttype/add";
	}

	/**
	 * 心一：校验有无部门名称
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/sysDeptType/findCountTypeNameById")
	@ResponseBody
	public boolean findCountTypeNameById(HttpServletRequest request) {
		boolean flag = true;
		String id = request.getParameter("id");
		String name = request.getParameter("name").trim();
		if (UtilValidate.isNotEmpty(id)) {
			SysDeptType sysDeptType = systemService.findSysDeptTypeByPK(id);
			if (name.equals(sysDeptType.getName())) {
				flag = false;
			}
		}
		return flag;
	}

	/**
	 * 心一：添加部门类型
	 * 
	 * @param sysDeptType
	 * @return
	 */
	@RequestMapping(value = "/sysDeptType/addSysDeptType")
	public String addSysDeptType(SysDeptType sysDeptType, Model model) {
		int no = systemService.findNextSysDeptTypeNo();
		sysDeptType.setNo(no + "");
		model.addAttribute("sysDeptType", sysDeptType);
		return "system/sysdepttype/add";
	}

	/**
	 * 心一：保存部门类型信息
	 * 
	 * @param sysDeptType
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/sysDeptType/saveSysDeptType")
	public String saveSysDeptType(SysDeptType sysDeptType, HttpServletRequest request) throws Exception {
		if (sysDeptType != null && sysDeptType.getId() != null) { // 如果id不为null就是更新
			systemService.updateSysDeptType(sysDeptType);
			// 保存操作日志
			// this.sysLogService.sysLogHandle(request, CommonValue.STUPDATE,
			// CommonValue.OOT.部门类型, sysDeptType.getName());
		} else {
			systemService.saveSysDeptType(sysDeptType);
			// 保存操作日志
			// this.sysLogService.sysLogHandle(request, CommonValue.STADD,
			// CommonValue.OOT.部门类型, sysDeptType.getName());
		}
		return "system/sysdepttype/list";
	}

	@RequestMapping(value = "/sysDeptType/deleteSysDeptTypeByIds")
	public String deleteSysDeptByIds(String ids, String sysDeptNames, HttpServletRequest request) {
		systemService.deleteSysDeptByIds(ids);
		// 保存操作日志
		// this.sysLogService.sysLogHandle(request, CommonValue.STDELETE,
		// CommonValue.OOT.部门类型, sysDeptNames);
		return "system/sysdepttype/list";
	}

	/**
	 * 心一：组织机构类型详情
	 * 
	 * @return
	 */
	@RequestMapping(value = "/sysDeptType/{sysDeptTypeId}/showSysDeptTypeId")
	public String showSysDeptTypeId(@PathVariable String sysDeptTypeId, Model model) {
		if (UtilValidate.isNotEmpty(sysDeptTypeId)) {
			SysDeptType sysDeptType = systemService.findSysDeptTypeByPK(sysDeptTypeId);
			model.addAttribute("sysDeptType", sysDeptType);
		}
		return "system/sysdepttype/detail";
	}

	/** ====================用户管理====================== */

	/**
	 * 心一：初始化用户管理
	 * 
	 * @return
	 */
	@RequestMapping(value = "/sysUser/load")
	public String sysUserLoad() {
		log.info("sysUserLoad...");
		return "system/user/list";
	}

	/**
	 * 心一：部门下用户信息分页
	 * 
	 * @param request
	 * @param sysUser
	 *            用户对象
	 * @param paging
	 *            分页对象
	 * @return
	 */
	@RequestMapping(value = "/sysUser/findSysUserPageByDeptId")
	@ResponseBody
	public Map<String, Object> findSysUserPageByDeptId(HttpServletRequest request, SysUser sysUser, Paging paging) {
		log.info("findSysUserPageByDeptId...");
		paging.setPageSize(paging.getRows());
		paging.setCurrentPage(paging.getPage());
		if (sysUser.getDeptid() == null) {
			SysUser currentUser = (SysUser) SessionUtil.getAttr(request, CommonValue.SESSION_CURRENT_USER);
			if(currentUser != null){
				sysUser.setDeptid(currentUser.getDeptid());
			}
		}
		Map<String, Object> paraMap = new HashMap<String, Object>();
		paraMap.put("sysUser", sysUser);
		int count = systemService.findSysUserCountByCondition(paraMap);
		paging.setTotal(count);
		paraMap.put("paging", paging);
		List<Map<String, Object>> resultMapList = systemService.findSysUserPageByCondition(paraMap);
		Map<String, Object> maps = new HashMap<String, Object>();
		maps.put("rows", resultMapList);
		maps.put("total", count);
		maps.put("paging", paging);
		return maps;
	}

	/**
	 * 心一：保存用户信息
	 * 
	 * @param sysUser
	 * @return
	 */
	@RequestMapping(value = "/sysUser/saveSysUser")
	public void saveSysUser(HttpServletResponse response, SysUser sysUser, String roleids) {

		try {
			// 如果当前用户不为空并且主键id不为null就是更新数据
			if (sysUser != null && sysUser.getId() != null) {
				systemService.updateSysUser(sysUser, roleids);
				utilApi.toJsonMsg(response, 0, null);
			} else { // 添加数据
				sysUser.setPassword(MD5Utils.getMD5String(sysUser.getPassword())); // 密码md5加密
				systemService.saveSysUser(sysUser, roleids); // 保存用户信息
				utilApi.toJsonMsg(response, 0, null);
			}
		} catch (Exception ex) {
			log.error(this, ex); // 打印异常内容
			utilApi.toJsonMsg(response, 1, null);
		}

	}

	/**
	 * 心一：初始化添加用户
	 * 
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/sysUser/{deptId}/addSysUser")
	public String addSysUserByDeptId(@PathVariable String deptId, Model model) {
		// 获取当前部门的信息
		SysDept fatherSysDept = systemService.findSysDeptByPK(deptId);
		// 获取系统的角色
		List<SysRole> sysRoles = systemService.findAllSysRole();
		// 获取系统的人员类型
//		List<SysUserType> sysUserTypes = systemService.findSysUserTypesByDeptId(deptId);
//		//获取人员类型，设计有疑问：人员类型和部门有没有关系（此处暂时认为没有关系）
		List<SysUserType> sysUserTypes =systemService.findALlSysUserType();
		model.addAttribute("sysRoles", sysRoles);
		model.addAttribute("sysUserTypes", sysUserTypes);
		model.addAttribute("fatherSysDept", fatherSysDept);
		// model.addAttribute("nextSysDeptNo", nextSysDeptNo);

		return "system/user/add";
	}

	/**
	 * 心一：ComBox角色列表
	 * 
	 * @return
	 */
	@RequestMapping(value = "/sysRole/findSysRoleComboxJson")
	@ResponseBody
	public List<EasyUiComBox> findSysRoleComboxJson() {
		List<EasyUiComBox> easyUiComBoxs = new ArrayList<EasyUiComBox>();
		List<SysRole> sysRoles = systemService.findAllSysRole();
		for (SysRole sysRole : sysRoles) {
			EasyUiComBox easyUiComBox = new EasyUiComBox(sysRole.getId().intValue() + "", sysRole.getName());
			easyUiComBoxs.add(easyUiComBox);
		}
		return easyUiComBoxs;
	}

	/**
	 * 心一：当前用户所拥有的角色列表
	 * 
	 * @param userId
	 * @return
	 */
	@RequestMapping(value = "/sysRole/{userId}/findSysRoleComboxJson")
	@ResponseBody
	public List<EasyUiComBox> findSysRoleComboxJson2(@PathVariable String userId) {
		List<EasyUiComBox> easyUiComBoxs = new ArrayList<EasyUiComBox>();
		List<SysRole> sysRoles = systemService.findAllSysRole();
		List<SysRole> userRoles = null;
		if (null != userId && !"".equals(userId)) {
			userRoles = this.systemService.findRolesByUserId(userId);
		}
		Boolean flag = false;
		for (SysRole sysRole : sysRoles) {
			EasyUiComBox easyUiComBox = null;
			if (null != userRoles && userRoles.size() > 0) {
				for (SysRole userRole : userRoles) {
					if (sysRole.getId().equals(userRole.getId())) {
						flag = true;
						easyUiComBox = new EasyUiComBox(sysRole.getId().intValue() + "", sysRole.getName(), true);
						userRoles.remove(userRole);
						break;
					}
				}
			}
			if (!flag) {
				easyUiComBox = new EasyUiComBox(sysRole.getId().intValue() + "", sysRole.getName());
			}
			easyUiComBoxs.add(easyUiComBox);
			flag = false;
		}
		return easyUiComBoxs;
	}

	/**
	 * 心一：校验此登录名是否存在
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/sysUser/userNameIsUnique")
	@ResponseBody
	public boolean userNameIsUnique(HttpServletRequest request) throws Exception {
		String loginname = request.getParameter("loginname"); // 获取前台传递过来的登录名
		boolean flag = true;
		if (loginname != null || ("").equals(loginname)) {
			flag = systemService.findCountByLoginName(loginname) < 1;
		}
		return flag;
	}

	/**
	 * 心一：删除用户
	 * 
	 * @param ids
	 * @return
	 */
	@RequestMapping(value = "/sysUser/deleteSysUser")
	public void deleteSysUser(HttpServletResponse response, String ids) {
		try {
			if (UtilValidate.isNotEmpty(ids)) {
				int result = systemService.deleteSysUser(ids);
				if (result > 0) {
					utilApi.toJsonMsg(response, 0, null);
				} else {
					utilApi.toJsonMsg(response, 1, null);
				}
			} else {
				utilApi.toJsonMsg(response, 1, null);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			utilApi.toJsonMsg(response, 1, null);
		}
	}

	/**
	 * 心一：修改用户信息
	 * 
	 * @param response
	 * @param userId
	 * @return
	 */
	@RequestMapping(value = "/sysUser/{userId}/editSysUserByUserId")
	public String editSysUserByUserId(HttpServletResponse response, @PathVariable String userId, Model model) {
		// 根据用户id获取用户信息
		SysUser sysUser = systemService.findSysUserByPK(userId);
		// 获取系统的部门类型
		List<SysUserType> sysUserTypes = systemService.findSysUserTypesByDeptId(String.valueOf(sysUser.getDeptid()));
		// 获取部门信息
		SysDept fatherSysDept = systemService.findSysDeptByPK(String.valueOf(sysUser.getDeptid()));
		// 获取系统的角色
		List<SysRole> sysRoles = systemService.findAllSysRole();
		// 获取用户所拥有的角色
		List<SysRole> userRoles = systemService.findRolesByUserId(userId);

		model.addAttribute("userRoles", userRoles);
		model.addAttribute("sysRoles", sysRoles);
		model.addAttribute("fatherSysDept", fatherSysDept);
		model.addAttribute("sysUser", sysUser);
		model.addAttribute("sysUserTypes", sysUserTypes);
		return "system/user/edit";
	}

	/**
	 * 心一：为用户分配权限
	 * 
	 * @param userId
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/sysUser/{userId}/updatePermissionByUserId")
	public String updatePermissionByUserId(@PathVariable String userId, Model model) {
		SysUser sysUser = this.systemService.findSysUserByPK(userId);
		model.addAttribute("sysUser", sysUser);
		model.addAttribute("allfuns", CommonValue.ALLFUNS);
		return "system/user/permission";
	}

	/**
	 * 心一：封装权限EasyUiComBox列表
	 * 
	 * @return
	 */
	@RequestMapping(value = "/sysFunction/findSysFunctionComboxJson")
	@ResponseBody
	public List<EasyUiComBox> findSysFunctionComboxJson() {
		List<EasyUiComBox> easyUiComBoxs = new ArrayList<EasyUiComBox>();
		for (Entry<String, Integer> entry : CommonValue.ALLFUNS.entrySet()) {
			EasyUiComBox easyUiComBox = new EasyUiComBox(entry.getValue() + "", entry.getKey(), true);
			easyUiComBoxs.add(easyUiComBox);
		}
		return easyUiComBoxs;
	}

	/**
	 * 心一：保存用户权限信息
	 * 
	 * @param sysUser
	 * @param request
	 * @param response
	 * @param language
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/sysUser/saveSysUserPermission")
	public void saveSysUserPermission(SysUser sysUser, HttpServletRequest request, HttpServletResponse response,
			String language) {
		PrintWriter pw = null;
		try {
			pw = response.getWriter();
			// 1.保存用户菜单权限信息
			this.systemService.saveSysUserPermission(sysUser);
			// 2.保存用户角色信息(重新设置用户对应的角色信息)
			systemService.savaSysRoleAndUserByUserId(sysUser, language);
			response.setCharacterEncoding(CommonValue.CHARSET_UTF8);
			pw.print(CommonValue.GLOBAL_YES);
		} catch (Exception e) {
			pw.print(CommonValue.GLOBAL_NO);
		}
	}

	/** ====================角色管理====================== */

	/**
	 * 心一：初始化角色管理
	 * 
	 * @return
	 */
	@RequestMapping(value = "/sysRole/list")
	public String sysRoleLoad() {
		return "system/sysrole/sysRoleList";
	}

	/**
	 * 心一：初始化当前用户所拥有的角色信息
	 * 
	 * @return
	 */
	@RequestMapping(value = "/sysRole/findAllSysRoleJson")
	@ResponseBody
	public List<EasyUIJsonTree> findRolesByUserId(HttpServletRequest request, HttpServletResponse response,
			Model model) {
		List<EasyUIJsonTree> easyUIJsonTrees = new ArrayList<EasyUIJsonTree>();
		SysUser currentUser = (SysUser) SessionUtil.getAttr(request, CommonValue.SESSION_CURRENT_USER);
		if (currentUser == null || "".equalsIgnoreCase(String.valueOf(currentUser.getId()))) {
			return easyUIJsonTrees;
		}
		List<SysRole> sysRoleList = systemService.findRolesByUserId(currentUser.getId().toString());
		EasyUIJsonTree easyUIJsonTree = null;
		for (SysRole sysRole : sysRoleList) { // 拼装easyui 所需要的格式
			easyUIJsonTree = new EasyUIJsonTree();
			easyUIJsonTree.setId(String.valueOf(sysRole.getId())); // 设置tree的id，这里一定要记得使用的主键id，要不然之后转换会很麻烦
			easyUIJsonTree.setText(sysRole.getName()); // 拼装tree的名称
			easyUIJsonTrees.add(easyUIJsonTree);
		}
		return easyUIJsonTrees;
	}

	/**
	 * 心一：查看角色详细信息
	 * 
	 * @param sysRoleId
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/sysRole/{sysRoleId}/updatePermissionByRid")
	public String updatePermissionByRid(@PathVariable String sysRoleId, Model model) {
		SysRole sysRole = systemService.findSysRoleById(sysRoleId); // 根据主键id查询数据
		model.addAttribute(sysRole);// 角色信息
		model.addAttribute("allfuns", CommonValue.ALLFUNS); //
		return "system/sysrole/sysRoleDetail";
	}

	/**
	 * 心一：保存角色权限信息
	 * 
	 * @param sysRole
	 *            角色
	 * @return
	 */
	@RequestMapping(value = "/sysRole/updateRolePermission")
	public String updateSysRolePermission(SysRole sysRole) {
		log.info("updateSysRolePermission...");
		this.systemService.updateSysRolePermission(sysRole);
		return "system/sysrole/sysRoleList";
	}

	/**
	 * 心一：初始化添加角色
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/sysRole/addSysRole")
	public String addSysRole(Model model) {
		SysRole sysRole = new SysRole();
		// String sno = this.sysRoleService.findNextSysRoleNo(); //
		sysRole.setNo("");
		model.addAttribute(sysRole); //
		return "system/sysrole/sysRoleAdd";
	}

	/**
	 * 心一：初始化修改角色
	 * 
	 * @param sysRoleId
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/sysRole/{sysRoleId}/editSysRole")
	public String editSysRole(@PathVariable String sysRoleId, Model model) {
		SysRole sysRole = this.systemService.findSysRoleById(sysRoleId); // 主键获取对象信息
		model.addAttribute(sysRole);
		return "system/sysrole/sysRoleAdd";
	}

	/**
	 * 心一：对部门进行排序
	 * 
	 * @param currSysDeptId
	 * @param moveSysDeptId
	 * @return
	 */
	@RequestMapping(value = "sysDept/moveSysDept")
	@ResponseBody
	public String moveSysDeptOrder(String currSysDeptId, String moveSysDeptId) {
		try {
			this.systemService.moveSysDeptOrder(currSysDeptId, moveSysDeptId);
			return CommonValue.GLOBAL_ZERO_NUMBER + "";
		} catch (Exception e) {
			return CommonValue.GLOBAL_ONE_NUMBER + "";
		}
	}

	/**
	 * 心一：校验系统角色是否存在
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/sysRole/findCountRoleNameByRoleId")
	@ResponseBody
	public boolean findCountRoleNameByRoleId(HttpServletRequest request) {
		boolean flag = true;
		String id = request.getParameter("id");
		String name = request.getParameter("name").trim();
		flag = this.systemService.findCountRoleNameByRoleId(id, name) < 1;
		return flag;
	}

	/**
	 * 心一：保存角色信息
	 * 
	 * @param sysRole
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/sysRole/saveSysRole")
	public String saveSysRole(SysRole sysRole, HttpServletRequest request) {

		if (sysRole != null && sysRole.getId() != null) {
			this.systemService.updateSysRole(sysRole);
			// 保存操作日志
			// this.sysLogService.sysLogHandle(request, CommonValue.STUPDATE,
			// CommonValue.OOT.角色, sysRole.getName());
		} else {
			SysUser currentUser = (SysUser) SessionUtil.getAttr(request, CommonValue.SESSION_CURRENT_USER);
			sysRole.setCreator(currentUser.getId());// 用户ID
			this.systemService.addSysRole(sysRole);
			// 保存操作日志
			// this.sysLogService.sysLogHandle(request, CommonValue.STADD,
			// CommonValue.OOT.角色, sysRole.getName());
		}
		return "system/sysrole/sysRoleList";
	}

	/**
	 * 心一：删除角色信息
	 * 由于角色表为主表（sys_role），sys_role_and_right,sys_role_and_user为子表，所以删除分为三步： 1.删除
	 * 
	 * @param sysRoleid
	 * @param name
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "sysRole/deleteSysRole")
	public String deleteSysRole(String sysRoleid, String name, HttpServletRequest request) {

		this.systemService.deleteSysRoleByPK(sysRoleid); // 根据主键id删除数据
		// 保存操作日志
		// this.systemService.sysLogHandle(request, CommonValue.STDELETE,
		// CommonValue.OOT.角色, name);
		return "system/sysrole/sysRoleList";
	}

	/* =======================用户类型管理======================== */
	/**
	 * 心一：初始化用户类型管理
	 * 
	 * @return
	 */
	@RequestMapping(value = "/sysUserType/load")
	public String sysUserTypeLoad() {
		log.info("sysUserTypeLoad...");
		return "system/sysusertype/list";
	}

	/**
	 * 心一：用户类型分页
	 * 
	 * @param paging
	 * @param sysUserType
	 * @return 分页Page
	 */
	@RequestMapping(value = "/sysUserType/findSysUserTypePageByConditions")
	@ResponseBody
	public Map<String, Object> findSysUserTypePageByConditions(Paging paging, SysUserType sysUserType) {
		paging.setPageSize(paging.getRows());
		paging.setCurrentPage(paging.getPage());
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("paging", paging);
		paramMap.put("sysUserType", sysUserType);
		return systemService.findSysUserTypePageByConditions(paramMap);
	}
	
	/**
	 * 心一：初始化添加用户类型
	 * @param sysUserType
	 * @return
	 */
	@RequestMapping(value="/sysUserType/addSysUserType")
	public String addSysUserType(SysUserType sysUserType){
		log.info("addSysUserType...");
		return "system/sysusertype/add";
	}

	/**
	 * 心一：保存用户类型（添加+修改）
	 * @param sysUserType
	 * @return
	 */
	@RequestMapping(value="/sysUserType/saveSysUserType")
	public String saveSysUserType(SysUserType sysUserType){
		log.info("saveSysUserType...");
		if(sysUserType.getId() == null || "".equals(String.valueOf(sysUserType.getId()))){
			//添加
			systemService.addSysUserType(sysUserType);
		}else{
			//修改
			systemService.updateSysUserType(sysUserType);
		}
		return "system/sysusertype/list";
	}
	
   /**
    * 心一：校验用户类型名称是否存在
    * @param sysUserType
    * @return
    */
	@RequestMapping(value="/sysUserType/findCountTypeNameById")
	@ResponseBody
	public boolean findCountTypeNameById(SysUserType sysUserType){
		boolean flag = true;
		flag = this.systemService.findCountTypeNameById(sysUserType) < 1;
		return flag;
	}
	
	
	/**
	 * 心一：初始化修改：系统用户类型
	 * @param sysUserTypeId
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/sysUserType/{sysUserTypeId}/editSysUserTypeId")
	public String editSysUserTypeId(@PathVariable String sysUserTypeId, Model model){
		SysUserType sysUserType = systemService.findSysUserTypeByPK(Integer.parseInt(sysUserTypeId));
		model.addAttribute("sysUserType", sysUserType);
		return "system/sysusertype/add";
	}
	
	/**
	 * 心一：删除系统用户类型
	 * @param ids
	 * @param name
	 * @return
	 */
	@RequestMapping(value="/sysUserType/deleteSysUserTypeByIds")
	public String deleteSysUserTypeByIds(String ids, String sysUserNames){
		this.systemService.deleteSysUserTypeByIds(ids);
		return "system/sysusertype/list";
	}
}
