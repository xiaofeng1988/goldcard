package com.goldcard.goldcardiot.modules.sys.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.goldcard.goldcardiot.common.online.OnlineManager;
import com.goldcard.goldcardiot.common.utils.CommonValue;
import com.goldcard.goldcardiot.common.utils.MD5Utils;
import com.goldcard.goldcardiot.common.utils.SessionUtil;
import com.goldcard.goldcardiot.common.utils.UtilValidate;
import com.goldcard.goldcardiot.models.SysUser;
import com.goldcard.goldcardiot.models.SysUserOnline;
import com.goldcard.goldcardiot.modules.sys.service.ISysUserService;

/**
 * 系统用户控制器
 * @author 心一
 *
 */
@Controller
@RequestMapping("/sysUserController")
public class SysUserController {

	@Resource(name="sysUserService")
	private ISysUserService sysUserService;
	
	private Log log = LogFactory.getLog(SysUserController.class); // 处理日志的对象
	
	/**
	 * 心一：去登录页面
	 * @return
	 */
	@RequestMapping(value = "/login*", method = RequestMethod.GET)
	public ModelAndView home() {
		return new ModelAndView("/login");
	}
	
	/**
	 * 心一：登录
	 * @param request
	 * @param response
	 * @param sysUser
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/loginSubmit")
	public String loginSubmit(HttpServletRequest request, SysUser sysUser, Model model) {
		try {
			if (UtilValidate.isEmpty(sysUser.getLoginname())) {
				model.addAttribute("msg", "请输入账号");
				return "login";
			}
			if (UtilValidate.isEmpty(sysUser.getPassword())) {
				model.addAttribute("msg", "请输入密码");
				return "login";
			}
			SysUser su = this.sysUserService.findUserByLoginfo(sysUser);
			if (su != null && UtilValidate.isNotEmpty(su.getPassword())) {
				if (MD5Utils.getMD5String(sysUser.getPassword()).equals(su.getPassword())) {
					SessionUtil.setAttr(request, CommonValue.SESSION_CURRENT_USER, su);
					String userId = String.valueOf(su.getId()); //当前用户id
//					session当前用户所有权限信息
//					SessionUtil.setAttr(request, userId, sysUserService.findSysRightsByUserId(Integer.parseInt(userId)));
					CommonValue.CURRENTUSERRIGHTURLMAP= sysUserService.findAllUrlByUserId(Integer.parseInt(userId));
					//展示前用户到index页面
					model.addAttribute(CommonValue.SESSION_CURRENT_USER, su);
					return "index";
				} else {
					log.info("密码错误！");
					model.addAttribute("msg", "密码错误！");
				}
			} else {
				log.info("用户名不存在！");
				model.addAttribute("msg", "用户名不存在！");
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return "login";
	}
	
	/**
	 * 心一：注销
	 * @return
	 */
	@RequestMapping("/loginOut")
	public String loginOut(HttpServletRequest request, ModelAndView model) {
		SysUser sysUser = (SysUser) SessionUtil.getAttr(request, CommonValue.SESSION_CURRENT_USER);
		if (sysUser != null) {
			request.getSession().invalidate(); // 销毁SESSION
		}
		model.addObject("msg", "");
		return "login";
	}
	
//	@RequestMapping(value = "/index")
//	public ModelAndView index() {
//		return new ModelAndView("/index");
//	}
	
	/**
	 * 初始化在线人员
	 * @return
	 */
	@RequestMapping(value="/online/load")
	public String online(){
		log.info("online...");
		return "system/online/online";
	}
	
	/**
	 * 心一：在线系统人员信息展示
	 * @return
	 */
	@RequestMapping(value="/online/findUserOnlines")
	@ResponseBody
	public Map<String, Object> findUserOnlines(){
		Map<String, Object> resultMap =new HashMap<String, Object>();
		List<SysUserOnline> userOnlineList = new ArrayList<SysUserOnline>();
		Map<String, SysUserOnline> onlineMap = OnlineManager.getInstance().getOnlineMap();
		for (Map.Entry<String, SysUserOnline> entry : onlineMap.entrySet()) {
			SysUserOnline sysUserOnline = entry.getValue();
			Map<String, Object> userMap = sysUserService.findSysUserOnlineRemarkByUserId(sysUserOnline.getUserId());
			sysUserOnline.setUserName(String.valueOf(userMap.get("username")));
			sysUserOnline.setDeptName(String.valueOf(userMap.get("deptname")));
			userOnlineList.add(sysUserOnline);
		}
		resultMap.put("rows", userOnlineList);
		return resultMap;
	}
	
	
}
