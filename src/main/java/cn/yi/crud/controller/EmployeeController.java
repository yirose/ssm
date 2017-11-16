package cn.yi.crud.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import cn.yi.crud.bean.Employee;
import cn.yi.crud.bean.Msg;
import cn.yi.crud.service.EmployeeService;

/**
 * 
 * @Title EmployeeController.java
 * @Type EmployeeController
 * @Package cn.yi.crud.controller
 * @Description TODO(处理员工CRUD)
 * @author YI
 *
 */

@Controller
public class EmployeeController {

	@Autowired
	EmployeeService employeeService;

	/**
	 * JSON方式查询员工数据(分页查询)
	 * 导入jackson包@RequestBody才能工作
	 * @param pn
	 * @param model
	 * @return
	 */

	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmpsWithJson(
			@RequestParam(value = "pn", defaultValue = "1") Integer pn,@RequestParam(value = "nn", defaultValue = "10") Integer nn ) {

		// 这不是分页查询
		// 引入pageHelper分页插件
		// 在查询之前只需要调用,传入页码以及每页条数

		PageHelper.startPage(pn, nn);
		// startPage后面紧跟的这个查询就是一个分页查询
		List<Employee> emps = employeeService.getAll();
		// 使用PageInfo包装查询结果。只需要将PageInfo交给页面就行了
		// 封装了详细分页信息。包括有查询出来的数据,传入连续显示页数
		PageInfo page = new PageInfo(emps, 10);
		return Msg.success().add("pageInfo",page);
	}

	/**
	 * 传统方式查询员工数据(分页查询)
	 * 
	 * @param pn
	 * @param model
	 * @return
	 */

	// 注释掉传统方式
	//@RequestMapping("/emps")
	public String getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {

		// 这不是分页查询
		// 引入pageHelper分页插件
		// 在查询之前只需要调用,传入页码以及每页条数

		PageHelper.startPage(pn, 10);
		// startPage后面紧跟的这个查询就是一个分页查询
		List<Employee> emps = employeeService.getAll(); //
		// 使用PageInfo包装查询结果。只需要将PageInfo交给页面就行了
		// 封装了详细分页信息。包括有查询出来的数据,传入连续显示页数
		PageInfo page = new PageInfo(emps, 10);
		model.addAttribute("pageInfo", page);

		return "list";
	}

}
