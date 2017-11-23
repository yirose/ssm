package cn.yi.crud.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.validation.Valid;

import org.eclipse.jdt.internal.compiler.parser.ParserBasicInformation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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
	 * 单个员工删除方法
	 * @param id
	 * @return
	 */
/*	@RequestMapping(value="/emp/{id}",method=RequestMethod.DELETE)
	@ResponseBody
	public Msg deleteEmpById(@PathVariable("id") Integer id){
		employeeService.deleteEmp(id);
		System.out.println(id);
		return Msg.success();		
	}*/
	
	/**
	 * 单个&多个员工删除方法
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/emp/{ids}",method=RequestMethod.DELETE)
	@ResponseBody
	public Msg deleteEmp(@PathVariable("ids") String ids){
		if(ids.contains("-")){
			List<Integer> del_ids = new ArrayList<>();
			String[] str_ids = ids.split("-");			
			//组装的集合
			for (String string : str_ids) {
				del_ids.add(Integer.parseInt(string)) ;
			}			
			employeeService.deleteBatch(del_ids);
		}else{
			Integer id = Integer.parseInt(ids);
			employeeService.deleteEmp(id);
		}
		return Msg.success();		
	}
	
	/**
	 * 如果直接发送ajax=PUT 形式请求
	 * Employee封装不上数据。提示出错
	 * 
	 *  原因：Tomcat 不支持问题
	 * 
	 * 解决办法
	 * 在web.xml  配置过滤器 HttpPutFormContentFilter
	 * 
	 * 员工修改保存
	 * @param employee
	 * @return
	 */
	@RequestMapping(value="/emp/{id}",method=RequestMethod.PUT)
	@ResponseBody
	public Msg saveEmp(Employee employee){
		employeeService.updataEmp(employee);
		return Msg.success();		
	}
	
	/**
	 * 查询员工数据
	 * @return
	 */	
	@RequestMapping(value="/emp/{id}" , method=RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable("id") Integer id){
		 Employee employee= employeeService.getEmp(id);
		return Msg.success().add("emp", employee);
	}
	
	/**
	 * 员工检验
	 * @param name
	 * @return
	 */
	@RequestMapping("/checkname")
	@ResponseBody
	public Msg checkEmpName(@RequestParam("name") String name){
		// 判断用户名是否合法表达式
		String rgex = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5}$)";
		if(!name.matches(rgex)){
			return Msg.fail().add("va_msg", "员工名必须是是2-5位中文或6-16位英文和数字的组合！");
		}	
		// 数据库用户名重复校验
		boolean  b = employeeService.checkEmpName(name);
		if(b){
			return Msg.success();
		}else{
			return Msg.fail().add("va_msg", "员工名称重复，请及时更换！");
		}
	}	
	
	/**
	 * 员工保存
	 * 1： 支持JSR303校验
	 * 2：导入Hibernate Validato
	 * @return
	 */
	@RequestMapping(value="/emp",method=RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employee employee ,BindingResult result ){
		if(result.hasErrors()){
			//校验失败，应该返回在模态框中显示校验失败信息
			HashMap<Object,Object> map = new HashMap<>();
			 List<FieldError> errors =  result.getFieldErrors();
			 for (FieldError fieldError : errors) {
				System.out.println("错误的字段名："+fieldError.getField());
				System.out.println("错误信息"+fieldError.getDefaultMessage());
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorFields", map);
		}else{
			employeeService.saveEmp(employee);
			return Msg.success();	
		}		
	}
	
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
		PageInfo page = new PageInfo(emps, 7);
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
