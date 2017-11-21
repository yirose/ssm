package cn.yi.crud.bean;

import javax.validation.constraints.Pattern;

public class Employee {
    private Integer id;

    @Pattern(regexp="(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5}$)"
    		,message="员工名必须是是2-5位中文或6-16位英文和数字的组合！")
    private String name;

    private String gender;

    //@Email
    @Pattern(regexp="^[a-z\\d]+(\\.[a-z\\d]+)*@([\\da-z](-[\\da-z])?)+(\\.{1,2}[a-z]+)+$"
    		,message="邮箱错误，请输入正确邮箱！")
    private String email;

    private Integer dId;
    
    //查询员工时候，同时查询部门信息    
    private   Department  department;  
  
	public Employee() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Employee(Integer id, String name, String gender, String email, Integer dId) {
		super();
		this.id = id;
		this.name = name;
		this.gender = gender;
		this.email = email;
		this.dId = dId;
	}

	public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender == null ? null : gender.trim();
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }

    public Integer getdId() {
        return dId;
    }

    public void setdId(Integer dId) {
        this.dId = dId;
    }
    
    public Department getDepartment() {
		return department;
	}

	public void setDepartment(Department department) {
		this.department = department;
	}
}