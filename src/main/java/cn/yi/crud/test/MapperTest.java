package cn.yi.crud.test;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import cn.yi.crud.bean.Department;
import cn.yi.crud.bean.Employee;
import cn.yi.crud.dao.DepartmentMapper;
import cn.yi.crud.dao.EmployeeMapper;

/**
 * 
 * @Title MapperTest.java
 * @Package cn.yi.crud.test
 * @Description TODO(测试dao层的工作)
 * @author anil
 * @Date 2017 下午4:12:11
 * @version V1.0
 * 推荐Spring的项目使用Spring  的单元测试，可以自动注入我们需要的组件
 * 
 * 1: 导入SpringTest 模块
 * 2: @ContextConfiguration指定Spring配置文件的位置
 * 3:  直接使用@Autowired要使用的组件即可
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {
	
	/**
	 * 测试DepartmentMapper
	 */
	
	@Autowired
	DepartmentMapper departmentMapper;
	/**
	 * 测试EmployeeMapper
	 */
	@Autowired
	EmployeeMapper employeeMapper;
	
	//批量SqlSession
	@Autowired
	SqlSession sqlSession;
	
	@Test
	public void testCRUD() {
		/*//1: 创建SpringIOC容器
		ApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");
		//2: 从容器中获取mapper
		DepartmentMapper bean= ioc.getBean(DepartmentMapper.class);*/
		
		System.out.println(departmentMapper);
		
		//1: 插入几个部门
		//departmentMapper.insertSelective(new Department(null,"设计部"));	
		//departmentMapper.insertSelective(new Department(null,"技术部"));
		 
		 //2：插入员工数据
		//employeeMapper.insertSelective(new Employee(null,"jack","m","jack@yi.cn",2));
		//employeeMapper.insertSelective(new Employee(null,"彭宣","m","admin@yi.cn",2));
		 
		 // 3: 批量插入多个员工；批量：可以 执行批量操作sqlSession
		 
		/*for (int i = 0; i < array.length; i++) {
			employeeMapper.insertSelective(new Employee(null, "tom", "m", "admin@yi.cn", 2));
		}*/
		 
		  EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
		  for (int i = 0; i < 1000; i++) {
			  String uid = UUID.randomUUID().toString().substring(0, 5)+i;
			  mapper.insertSelective(new Employee(null, uid, "m", uid+"@yi.cn", 1));
		}
		  System.out.println("批量ok");
	}
}
