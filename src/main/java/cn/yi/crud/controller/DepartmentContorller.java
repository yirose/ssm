package cn.yi.crud.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.yi.crud.bean.Department;
import cn.yi.crud.bean.Msg;
import cn.yi.crud.service.DepartmentService;

/**
 * 
 * @Title DepartmentContorller.java
 * @Type DepartmentContorller
 * @Package cn.yi.crud.controller
 * @Description TODO(处理部门有关请求)
 * @author YI
 */

@Controller
public class DepartmentContorller {

	@Autowired
	private DepartmentService departmentService;

	/**
	 * 返回所有部门信息
	 * 
	 * @return
	 */
	
	@RequestMapping("/depts")
	@ResponseBody
	public Msg getDepts() {
		//查处的部门所有信息
		List<Department> list = departmentService.getDepts();
		return Msg.success().add("depts", list);
	}
}