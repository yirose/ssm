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

	/**
	 * 按照员工id查询出来员工信息
	 * @param id
	 * @return
	 */
	public Employee getEmp(Integer id) {
		Employee employee = employeeMapper.selectByPrimaryKey(id);
		return employee;
	}

	/**
	 * 员工更新数据
	 * @param employee
	 */
	public void updataEmp(Employee employee) {
		employeeMapper.updateByPrimaryKeySelective(employee);		
	}

	/**
	 * 员工删除
	 * @param id
	 */
	public void deleteEmp(Integer id) {
		employeeMapper.deleteByPrimaryKey(id);		
	}
	/**
	 * 多员工删除
	 * @param ids
	 */
	public void deleteBatch(List<Integer> ids) {
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();		
		//模拟 delete from XXX where id in (1,2,3)
		criteria.andIdIn(ids);
		employeeMapper.deleteByExample(example);		
	}

	

}