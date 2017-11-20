package cn.yi.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.yi.crud.bean.Employee;
import cn.yi.crud.bean.EmployeeExample;
import cn.yi.crud.bean.EmployeeExample.Criteria;
import cn.yi.crud.dao.EmployeeMapper;

@Service
public class EmployeeService {
	
	@Autowired
	EmployeeMapper employeeMapper;

	/**
	 * 查询所有员工
	 * @return
	 */
	public List<Employee> getAll() {
		// TODO Auto-generated method stub
		return employeeMapper.selectByExampleWithDept(null);
	}

	/**
	 * 员工保存
	 * @param employee
	 */
	public void saveEmp(Employee employee) {
		employeeMapper.insertSelective(employee);		
	}

	
	/**
	 * 检验员工姓名是否登记
	 * @param name
	 * @return   count==0 就是 true 否则就是false
	 */
	public boolean checkEmpName(String name) {
		EmployeeExample example = new EmployeeExample();
		Criteria criteria= example.createCriteria();
		criteria.andNameEqualTo(name);
		long count = employeeMapper.countByExample(example);
		return count == 0 ;
	}
}