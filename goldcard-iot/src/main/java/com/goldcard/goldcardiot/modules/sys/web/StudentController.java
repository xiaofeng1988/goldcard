package com.goldcard.goldcardiot.modules.sys.web;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.time.DateUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.goldcard.goldcardiot.common.utils.DateUtil;
import com.goldcard.goldcardiot.common.utils.MethodUtil;
import com.goldcard.goldcardiot.common.utils.Paging;
import com.goldcard.goldcardiot.models.Student;
import com.goldcard.goldcardiot.modules.sys.service.IStudentService;

/**
 * <br>
 * <b>功能：</b>类功能描述<br>
 * <b>作者：</b>goldcard<br>
 * <b>日期：</b> 2015-09-18 <br>
 * <b>版权所有：心一<br>
 * <b>更新者：肖锋</b><br>
 * <b>日期：</b> <br>
 * <b>更新内容：</b><br>
 */
@Controller
@RequestMapping("/admin/student")
public class StudentController {
	private Log log = LogFactory.getLog(StudentController.class); // 处理日志的对象
	private static MethodUtil util = new MethodUtil(); // 信息传递公用类
	
	@Resource(name="studentService")
	private IStudentService studentService;  //学生信息服务类
	
	@RequestMapping(value="/list/load")
	public String studetnList(){
		return "student/list";
	}
	/**
	 * 添加
	 * @return
	 */
	@RequestMapping(value="/add/load")
	public String addStudentLoad(){
		return "student/add";
	}
	/**
	 * 修改
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/edit/load")
	public String editStudentLoad(String id,Model model){
		Student stu=studentService.findStudentByPK(id);
		model.addAttribute("student", stu);
		return "student/edit";
	}
	
	/**
	 * 分页查询信息
	 * @param paging
	 * @param stu
	 * @return
	 */
	@RequestMapping(value="/findStudentPageByConditions")
	@ResponseBody
	public Map<String,Object> findStudentPageByConditions(Paging paging,Student stu){
		paging.setPageSize(paging.getRows());
		paging.setCurrentPage(paging.getPage());
		
		Map<String,Object> paramMap=new HashMap<String, Object>();
		paramMap.put("paging", paging);
		paramMap.put("student", stu);
		return studentService.findStudentPageByConditions(paramMap);
	}
	/**
	 * 保存信息
	 * @param response
	 * @param stu
	 */
	@RequestMapping(value="/saveStudent")
	public void saveStudent(HttpServletResponse response,Student stu){
		try{
			if(stu!=null && stu.getSid()!=null){
				//1.修改
				studentService.updateStudent(stu);
			}else{
				//2.添加
				studentService.addStudent(stu);
			}
			util.toJsonMsg(response, 0, null);
		}catch(Exception ex){
			log.error(this, ex); // 打印异常内容
			util.toJsonMsg(response, 1, null);
		}
	}
	
	/**
	 * 保存信息
	 * @param response
	 * @param stu
	 */
	@RequestMapping(value="/deleteStudent")
	public void deleteStudent(HttpServletResponse response,String ids){
		try{
			if(ids!=null &&!"".equals(ids)){
				studentService.deleteStudent(ids);
			}
			util.toJsonMsg(response, 0, null);
		}catch(Exception ex){
			log.error(this, ex); // 打印异常内容
			util.toJsonMsg(response, 1, null);
		}
	}

}
