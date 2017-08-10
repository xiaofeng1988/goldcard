package com.goldcard.goldcardiot.modules.sys.service;

import java.util.List;
import java.util.Map;

import com.goldcard.goldcardiot.models.Student;

/**
 * 学生接口类
 * @author 龙软科技
 *
 */
public interface IStudentService {
	/**
	 * 主键查询学生信息
	 * @param id
	 */
	Student findStudentByPK(String id);

	/**
	 * 增加学生信息
	 * @param stu
	 * @return
	 */
  int addStudent(Student stu);
  /**
	 * 删除学生信息
	 * @param stu
	 * @return
	 */
  void deleteStudent(String ids);
  
  
	/**
	 * 修改学生信息
	 * @param stu
	 * @return
	 */
  int updateStudent(Student stu);
  /**
   * 分页查询学生信息
   * @param paramMap
   * @return
   */
  Map<String,Object> findStudentPageByConditions(Map<String,Object> paramMap);

}
