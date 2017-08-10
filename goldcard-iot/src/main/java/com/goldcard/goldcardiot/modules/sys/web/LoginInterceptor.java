package com.goldcard.goldcardiot.modules.sys.web;

import java.io.PrintWriter;
import java.util.Date;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.goldcard.goldcardiot.common.online.OnlineManager;
import com.goldcard.goldcardiot.common.utils.CheckMobile;
import com.goldcard.goldcardiot.common.utils.CommonUtil;
import com.goldcard.goldcardiot.common.utils.CommonValue;
import com.goldcard.goldcardiot.common.utils.DateUtil;
import com.goldcard.goldcardiot.common.utils.SessionUtil;
import com.goldcard.goldcardiot.models.SysUser;
import com.goldcard.goldcardiot.models.SysUserOnline;
import com.goldcard.goldcardiot.modules.sys.service.ISysRightService;
import com.goldcard.goldcardiot.modules.sys.service.ISysUserService;

/**
 * 心一：SpringMVC拦截器 
 * 1.登陆拦截处理 
 * 2.权限拦截处理
 * 3.sessin管理
 * 
 * @author 心一
 *
 */
public class LoginInterceptor implements HandlerInterceptor {

	private Log log = LogFactory.getLog(StudentController.class); // 处理日志的对象
	
	@Resource(name = "sysRightService")
	private ISysRightService sysRightService; // 用户信息的服务类

	@Resource(name = "sysUserService")
	private ISysUserService sysUserService; // 用户服务类

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// TODO Auto-generated method stub
		log.info("preHandle...");
		// 请求路径处理
		String httpUrl = request.getRequestURI();
		if (httpUrl.contains("/api/")) {
			httpUrl = httpUrl.replace("/api/", ""); // 截取请求路径API=配置API
		}

		// 1.登陆处理
		SysUser sysUser = (SysUser) SessionUtil.getAttr(request, CommonValue.SESSION_CURRENT_USER);
		if (sysUser != null) {
			String sessionMapKey = request.getSession().getId() + "|" + sysUser.getId(); // sessionId+"|"+userId;
			Map<String, SysUserOnline> userOnlineMap = OnlineManager.getInstance().getOnlineMap();
			// 判断缓存Map中是否有此账号,没有则添加<sessionId|userId,SysUserOnline>
			boolean flag = userOnlineMap.containsKey(sessionMapKey);
			if (!flag) {
				SysUserOnline sysUserOnline = new SysUserOnline();
				sysUserOnline.setSessionId(request.getSession().getId());
				sysUserOnline.setUserId(sysUser.getId());
				sysUserOnline.setStime(DateUtil.formatDate(new Date(), DateUtil.YEAR_TO_SECOND));
				// 判断登录设备：手机端、PC端
				String userAgent = request.getHeader("USER-AGENT").toLowerCase();
				boolean isFromMobile = CheckMobile.check(userAgent);
				if (isFromMobile) {
					sysUserOnline.setFm("移动端");
				} else {
					sysUserOnline.setFm("PC端");
					// ip地址
					sysUserOnline.setIp(CommonUtil.getIpAddr(request));
				}
				// 缓存到map块中
				userOnlineMap.put(sessionMapKey, sysUserOnline);
				// 插入数据库
				sysUserService.saveSysUserOnline(sysUserOnline);
			}

			// 2.权限处理：需要判断为配置菜单（因为只有配置的菜单才考虑权限问题）
			if (sysUser != null) {
				// 登陆成功之后把配置菜单URL存到缓存块，此处从缓存块中直接获取
				Map<String, Integer> currentUserRightUrlMap = CommonValue.CURRENTUSERRIGHTURLMAP;
				// 判断是否是配置菜单请求，如果是则赋予权限

				if (currentUserRightUrlMap.containsKey(httpUrl)) {
					Integer rightId = currentUserRightUrlMap.get(httpUrl); // 菜单id
					Integer userId = sysUser.getId();
					// <rightId,rightVal>
					Map<String, Integer> resultMap = sysUserService.findSysRightsByUserIdAndRightId(userId, rightId);
					if (resultMap != null) {
						int rightVal = resultMap.get(String.valueOf(rightId)); // 当前用户当前菜单的权限值
						for (Entry<String, Integer> entry : CommonValue.ALLFUNS.entrySet()) {
							// 3：如果当前访问路径是页面的话就把权限放置在session
							int count = entry.getValue() & rightVal;
							SessionUtil.setAttr(request, CommonValue.CURRENTUSERRIGHTMAP.get(entry.getKey()), count);
						}

					}

				}

			}

		} else {
			Map<String, Integer> currentUserRightUrlMap = CommonValue.CURRENTUSERRIGHTURLMAP;
			// 判断是否是配置菜单请求
			if (currentUserRightUrlMap.containsKey(httpUrl)) {
				PrintWriter out = response.getWriter();
				out.println("<html>");
				out.println("<script>");
				out.println("alert('Session失效，请重新登陆...');window.parent.location.href='/api/sysUserController/loginOut'");
				out.println("</script>");
				out.println("</html>");
				out.close();
				return false;			
			}

		}

		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub

	}

}
