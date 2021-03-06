<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工列表</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<style type="text/css">
	.operationwidth {width: 20%; text-align: center;}
	.page_info_lh{ margin: 23px 0 0 0;}
	.option1{ background:#337ab7; color: aliceblue;}
	#page_nav_area nav {float: right !important;}
	#page_nav_area nav .page_nav_lh{margin:15px 0;}
	#page_nav_area .btn-group { float: right;margin:15px 0 10px 10px;}
	#page_nav_area .btn-dropdown{padding: 14px 5px !important;}
	#page_nav_area .dropdown-menu {min-width:60px !important;}
	#page_nav_area .dropdown-menu li {min-width:60px;text-align:center;line-height:25px;}
	#page_nav_area .dropdown-menu .divider {margin:1px 0!important;}
	#page_nav_area .dropdown-menu li a{padding:3px 17px!important;}
</style>
<link href="${APP_PATH}/staic/css/bootstrap.min.css" rel="stylesheet">
<script src="${APP_PATH}/staic/js/libs/jquery-3.2.1.min.js"></script>
<!-- bootstrap.min.js使用要放在jquery后面 -->
<script src="${APP_PATH}/staic/js/libs/bootstrap.min.js"></script>
</head>
<body>

<!-- 员工修改模态框 -->
	<div class="modal fade" id="empUpdataModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">员工修改添加</h4>
	      </div>
	      <div class="modal-body">
	        <form class="form-horizontal">
			  <div class="form-group">
			    <label for="inputEmpName" class="col-sm-2 control-label">姓 名</label>
			    <div class="col-sm-10">
			    <p class="form-control-static" id="UpdataName" ></p>
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="inputEmpEmail" class="col-sm-2 control-label">邮 箱</label>
			    <div class="col-sm-10">
			      <input type="email" name="email" class="form-control" id="inputUpdataEmail" placeholder="email@yi.cn">
			      <span class="help-block"></span>
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="inputEmpGender" class="col-sm-2 control-label">性 别</label>
			    <div class="col-sm-10">
				    <label class="radio-inline">
						<input type="radio" name="gender" id="inlineUpdataGender1" value="m">男</label>
					<label class="radio-inline">
						<input type="radio" name="gender" id="inlineUpdataGender2" value="f">女</label>
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="inputEmpDeptName" class="col-sm-2 control-label">部 门</label>
			    <div class="col-sm-3">
			    <!-- 提交部门id查询 -->
					<select class="form-control" name="dId"></select>
			    </div>
			  </div> 
			  </form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-sm btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-sm btn-primary" id="empUpdataBnt">修改</button>
	      </div>	      
	    </div>
	  </div>
	</div>
	
	<!-- 员工添加模态框 -->
	<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">员工信息添加</h4>
	      </div>
	      <div class="modal-body">
	        <form class="form-horizontal">
			  <div class="form-group">
			    <label for="inputEmpName" class="col-sm-2 control-label">姓 名</label>
			    <div class="col-sm-10">
			      <input type="name" name="name" class="form-control" id="inputAddName" placeholder="name">
			      <span class="help-block"></span>
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="inputEmpEmail" class="col-sm-2 control-label">邮 箱</label>
			    <div class="col-sm-10">
			      <input type="email" name="email" class="form-control" id="inputAddEmail" placeholder="email@yi.cn">
			      <span class="help-block"></span>
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="inputEmpGender" class="col-sm-2 control-label">性 别</label>
			    <div class="col-sm-10">
				    <label class="radio-inline">
						<input type="radio" name="gender" id="inlineAddGender1" value="m"> 男
					</label>
					<label class="radio-inline">
						<input type="radio" name="gender" id="inlineAddGender2" value="f"> 女
					</label>
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="inputEmpDeptName" class="col-sm-2 control-label">部 门</label>
			    <div class="col-sm-3">
			    <!-- 提交部门id查询 -->
					<select class="form-control" name="dId"></select>
			    </div>
			  </div> 
			  </form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-sm btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-sm btn-primary" id="empSaveBnt">保存</button>
	      </div>	      
	    </div>
	  </div>
	</div>
	
	<div class="container">
		<!-- 标题栏 -->
		<div class="row">
			<dir class="col-md-12">
				<H1>SSM-CRUD</H1>
			</dir>
		</div>
		<!-- 按钮 -->
		<div class="row">
			<div class="col-md-3 col-md-offset-9 class="text-center"">		
			<button type="button" class="btn btn-sm btn-primary" id="loginModalBnt">
					<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>用户登录</button>		
				<button type="button" class="btn btn-sm btn-primary" id="empAddModalBnt">
					<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span> 新增</button>
				<button type="button" class="btn btn-sm btn-danger" id="empDeleteAllBnt">
					<span class="glyphicon glyphicon-trash" aria-hidden="true"></span> 删除</button>
			</div>
		</div>
		<!-- 显示表格数据-->
		<div class="row">
		<div class="col-md-12">
			<table class="table table-hover table-bordered" id="emps_table">
				<thead>
					<tr>
						<th><input type='checkbox'  id='cjeckAll' /></th>
						<th>ID</th>
						<th>姓名</th>
						<th>性别</th>
						<th>邮箱</th>
						<th>部门</th>
						<th class="text-center">操作</th>
					</tr>
				</thead>
				<tbody>
				</tbody>
			</table>
		</div>
		</div>
		<!-- 分页信息-->
		<div class="row">
			<!-- 分页文字信息 -->
			<div class="col-md-5 page_info_lh" id="page_info_area"></div>
			<!-- 分页条信息 -->
			<div class="col-md-7" id="page_nav_area"></div>
		</div>
	</div>	
<script type="text/javascript">
	var addName, addEmail, updataEmail, totalRecord ,curremtPage;
	
	// 1、页面加载完成以后，直接去发送一个ajax请求，要到分页数据
	$(function () {
		// 去首页
		to_page(1, 10);
	});

	function to_page(pn, nn) {
		$.ajax({
			url: "${APP_PATH}/emps",
			data: "pn=" + pn + "&nn=" + nn,
			type: "GET",
			success: function (result) {
				// console.log(result);
				// 1、解析并显示员工数据
				build_emps_table(result);
				// 2、解析并显示员工数据
				build_page_info(result);
				// 3、解析并显示分页信息
				build_page_nav(result, nn);
			}
		});
	}

	// 解析员工信息
	function build_emps_table(result) {
		$("#emps_table tbody").empty();
		var emps = result.extend.pageInfo.list;
		$.each(emps, function (index, item) {
			/*
			 * <button type="button" class="btn btn-sm btn-primary"> <span
			 * class="glyphicon glyphicon-pencil" aria-hidden="true"></span>修改</button>
			 */
			// 构建按钮
			var editBnt = $("<button></button>").addClass("btn btn-xs btn-info edit_bnt")
				.append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append(" 编辑");
			 editBnt.attr("edit_id",item.id);
			var delBnt = $("<button></button>").addClass("btn btn-xs btn-danger delete_btn")
				.append($("<span></span>").addClass("glyphicon glyphicon-trash")).append(" 删除");
			delBnt.attr("delete_id",item.id);
			// 构建表格到#emps_table tbody表格中
			var checkBox = $("<td></td>").append("<input type='checkbox' class='check_item'/>");
			var empId = $("<td></td>").append(item.id);
			var empName = $("<td></td>").append(item.name);
			var empGender = $("<td></td>").append(item.gender == "m" ? "男" : "女");
			var empEmail = $("<td></td>").append(item.email);
			var empDepartment = $("<td></td>").append(item.department.deptName);
			var empBnt = $("<td></td>").addClass("operationwidth").append(editBnt)
				.append(" ").append(delBnt);
			$("<tr></tr>").append(checkBox).append(empId).append(empName).append(empGender).append(
				empEmail).append(empDepartment).append(empBnt).appendTo(
				"#emps_table tbody");
		})
	}

	// 解析显示分页信息
	function build_page_info(result) {
		$("#page_info_area").empty();
		var pageInfo = result.extend.pageInfo;
		$("#page_info_area").append("当前 " + pageInfo.pageNum + " 页, 每页 " + pageInfo.pageSize + " 条数据, 总 " + pageInfo.pages + " 页, 总 " + pageInfo.total + " 条记录");
	}

	// 解析分页条信息
	function build_page_nav(result, nn) {

		$("#page_nav_area").empty();
		var pageInfo = result.extend.pageInfo;
		var navNums = pageInfo.navigatepageNums;
		var pageNum = pageInfo.pageNum;
		var pages = pageInfo.pages;
		
		totalRecord = pageInfo.total;
		curremtPage = pageNum;
		// <li><a href="${APP_PATH}/emps?pn=1">首页</a>
		var ul = $("<ul></ul>").addClass("pagination page_nav_lh");
		var firstPageLi = $("<li></li>").append($("<a></a>").append("首页"));
		var prePageLi = $("<li></li>").append($("<a></a>").append("«"));

		// 判断是否第一页
		if (pageInfo.hasPreviousPage == false) {
			firstPageLi.addClass("disabled");
			prePageLi.addClass("disabled");
		} else {
			firstPageLi.click(function () {
				to_page(1, nn);
			});
			prePageLi.click(function () {
				to_page(pageNum - 1, nn);
			});
		}
		// 在ul中添加首页和上一页提示
		ul.append(firstPageLi).append(prePageLi);

		// 分页遍历
		$.each(navNums, function (index, item) {
			var numLi = $("<li></li>").append($("<a></a>").append(item));
			if (pageNum == item) {
				numLi.addClass("active");
			} else {
				numLi.click(function () {
					to_page(item, nn);
				});
			}
			// 在ul中添加页码提示
			ul.append(numLi);
		});
		var nextPageLi = $("<li></li>").append($("<a></a>").append("»"));
		var lastPageLi = $("<li></li>").append($("<a></a>").append("末页"));

		// 判断是否最后一页
		if (pageInfo.hasNextPage == false) {
			nextPageLi.addClass("disabled");
			lastPageLi.addClass("disabled");
		} else {
			nextPageLi.click(function () {
				to_page(pageNum + 1, nn);
			});
			lastPageLi.click(function () {
				to_page(pages, nn);
			});
		}

		// 在ul中添加下一页和末页提示
		ul.append(nextPageLi).append(lastPageLi);

		// 下拉菜单
		var btnG01 = $("<button></button>").addClass("btn btn-default").append(nn);
		var btnG02 = $("<button></button>")
			.addClass("btn btn-default btn-dropdown").append(
				$("<span></span>").addClass("caret").append(
					$("<span></span>")));

		var nLi1 = $("<li></li>").append($("<a></a>").append(10));
		var nLi2 = $("<li></li>").append($("<a></a>").append(20));
		var nLi3 = $("<li></li>").append($("<a></a>").append(40));
		var nLi4 = $("<li></li>").append($("<a></a>").append(80));
		var nLi5 = $("<li></li>").append($("<a></a>").append(160));
		var groupUl = $("<ul></ul>").addClass("dropdown-menu").append(nLi1).append(
			nLi2).append(nLi3).append(nLi4).append(nLi5);
		var btn_group = $("<div></div>").addClass("btn-group").append(btnG01)
			.append(btnG02).append(groupUl);

		nLi1.click(function () {
			to_page(pageNum, 10);
		});
		nLi2.click(function () {
			to_page(pageNum, 20);
		});
		nLi3.click(function () {
			to_page(pageNum, 40);
		});
		nLi4.click(function () {
			to_page(pageNum, 80);
		});
		nLi5.click(function () {
			to_page(pageNum, 160);
		});

		btnG02.click(function () {
			$(groupUl).toggle(true);
		});
		var nav = $("<nav></nav>").append(ul);
		$("#page_nav_area").append(btn_group).append(nav);
	}

	// 打开添加模态框
	$("#empAddModalBnt").off().click(function () {
		// 1: 发送ajax请求，查出部门信息，显示在下拉列表中
		getDepts("#empAddModal select");

		// 2：弹出模态框
		$('#empAddModal').modal({
			backdrop: "static"
		});
	});
	
	// 打开修改模态框
	// 按钮是jquery创建之前就绑定click，所以绑不上
	//1: 可以在创建按钮的时候绑定
	// 2：绑定单击  .live(){} 新版本jquery，已使用  替代方法.on
	
	$(document).on("click",".edit_bnt",function () {
		// 1: 发送ajax请求，查出部门信息，显示在下拉列表中
		getDepts("#empUpdataModal select");	
		// 2: 发送ajax请求，查出员工信息，显示在模态框中		
		getEmp($(this).attr("edit_id"));
		//3：把员工id传递给模态框的更新按钮
		$("#empUpdataBnt").attr("edit_id",$(this).attr("edit_id"));
		// 4：弹出模态框
		$('#empUpdataModal').modal({
			backdrop: "static"
		});
	});
	
	// 发送ajax请求，查出员工信息
	function getEmp(id){
		$.ajax({
			url: "${APP_PATH}/emp/"+id,
			type: "GET",
			success: function (result) {				
				var empData = result.extend.emp;
				//console.log(empData);
				$("#UpdataName").text(empData.name);	
				$("#inputUpdataEmail").val(empData.email);
				$("#empUpdataModal input[name=gender]").val([empData.gender]);
				$("#empUpdataModal select").val([empData.dId]);				
			}				
		});
	}

	// 发送ajax请求，查出部门信息，显示在下拉列表中
	function getDepts(ele){	
		$(ele) .empty();
		$.ajax({
			url: "${APP_PATH}/depts",
			type: "GET",
			success: function (result) {
				// 显示部门信息在下拉列表中
				// 两种写法 一种传参 一种部传参
				$.each( result.extend.depts, function(index, item){ 
					$("<option></option>").val(item.deptId)
					.append(item.deptName).appendTo(ele); 
				}); 				 
				/* $.each(result.extend.depts, function () {
					$("<option></option>").val(this.deptId).append(this.deptName)
						.appendTo("#empAddModal select");
				}); */
			}
		});
}
		
		// 校验name email表单数据		
		//用户名添加验证		
	$("#inputAddName").focusout(function() {
	  	var name = $("#inputAddName").val();		  
		 // 1: 拿到要校验的数据，使用正则表达式			 
		var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5}$)/;
		if(regName.test(name)){
			$.ajax({
				url: "${APP_PATH}/checkname",
				data: "name=" + name,
				type: "POST",
				success: function (result) {
					if(result.code == 100){
						showValifataMsg("#inputAddName","success","用户名正确！");
						addName =true;
					}else{
						showValifataMsg("#inputAddName","error",result.extend.va_msg);
						addName =false;
					}
				}				
			});								
		}else{
			showValifataMsg("#inputAddName","error","用户名是2-5位中文或6-16位英文和数字的组合！");				
			addName =false;
		}			
	});
		
	//邮箱添加验证
	$("#inputAddEmail").focusout(function() {
		validateEmail("#inputAddEmail",addEmail)
	});
	
	//邮箱修改验证
	$("#inputUpdataEmail").focusout(function() {
		validateEmail("#inputUpdataEmail",updataEmail)
	});
	
	//邮箱验证抽取
	function validateEmail(ele,email){
		var name = $(ele).val();
		var regName = /^[a-z\d]+(\.[a-z\d]+)*@([\da-z](-[\da-z])?)+(\.{1,2}[a-z]+)+$/;
		if(regName.test(name)){
			showValifataMsg(ele,"success","邮箱正确！");			
			email =true;
		}else{
			showValifataMsg(ele,"error","邮箱错误，请输入正确邮箱！");
			email =false;
		}
	}

	function validateAddForm(){
		if(!addName){
			showValifataMsg("#inputAddName","error","用户名重复或错误，用户名是2-5位中文或6-16位英文和数字的组合！");	
			return false;
		}else if(!addEmail){
			showValifataMsg("#inputAddEmail","error","邮箱错误，请输入正确邮箱！");
			return false;
		}
		return true;
	}

	function validateUpdataForm(){
		if(!updataEmail){
			showValifataMsg("#inputAddEmail","error","邮箱错误，请输入正确邮箱！");		
			return false;
		}
		return false;
	} 
	

	//抽取showValifataMsg
	function showValifataMsg(ele,status,msg){			
		if("success"==status){
			$(ele).parent().removeClass("has-error")
			$(ele).parent().addClass("has-success");				
			$(ele).next("span").text("");
		}else if("error"==status){
			$(ele).parent().removeClass("has-success")
			$(ele).parent().addClass("has-error");				
			$(ele).next("span").text(msg);
		}			
	}	

	// 保存员工的方法  click事件重复执行的问题    删除 .unbind('click') 移除off()
	$("#empSaveBnt").off().click(function(){
		//将模态框中填写的表单数据检验
		if(!validateAddForm()){
			return false;				
		}
		// 1、将模态框中填写的表单数据提交给服务器进行保存
		// 2、发送ajax请求保存员工
		$.ajax({
			url: "${APP_PATH}/emp",
			type: "POST",
			// jquery serialize() 序列表表格内容为字符串。
			data: $("#empAddModal form").serialize(),
			success: function (result) {
				// alert(result.msg);
				if(result.code==100){
					// 关闭模态框
					$('#empAddModal').modal('hide');						
					//清理数据
					addName =false;
					addEmail =false;
					// 来到最后一页，显示刚才保存数据。
					to_page(totalRecord, 10);
				}else{
					if(undefined != result.extend.errorFields.name){
						//显示员工名字信息
						showValifataMsg("#inputAddName","error",result.extend.errorFields.name);	
					}else if(undefined != result.extend.errorFields.email){
						//显示员工邮箱信息
						showValifataMsg("#inputAddEmail","error",result.extend.errorFields.email);
					}
				}	
			}
		});		
	});
	
	//修改员工的方法
	$("#empUpdataBnt").off().click(function(){
		// 1、将模态框中填写的表单检验
		if(validateUpdataForm()){
			return false;
		}
		// 2、发送ajax请求修改员工
		$.ajax({
			url: "${APP_PATH}/emp/"+$(this).attr("edit_id"),		
			//PUT方法
			type: "PUT",
			data: $("#empUpdataModal form").serialize(), 
			/* POST  转换PUT方法
			type: "POST",
			data: $("#empUpdataModal form").serialize()+"&_method=PUT", */
			success: function(result){					
				//console.log(result);
				if(result.code==100){
					// 关闭模态框
					$('#empUpdataModal').modal('hide');						
					//清理数据
					updataEmail =false;
					// 来到最后一页，显示刚才保存数据。
					to_page(curremtPage, 10);
				}
			}			
		});		
	});	
	
	//全选或全部取消按钮
	$("#cjeckAll").click(function(){
		//alert($(this).prop("checked"));
		$(".check_item").prop("checked",$(this).prop("checked"));
	});
	
	//check_item
	$(document).on("click",".check_item",function(){	
		//alert($(".check_item").length);	
		var flag = $(".check_item:checked").length==$(".check_item").length;
		if(flag){
			$("#cjeckAll").prop("checked",$(this).prop("checked"));
		}else{
			$("#cjeckAll").prop("checked",flag);
		}
	});
	
	//员工删除
	$(document).on("click",".delete_btn",function(){
		var empName = $(this).parents("tr").find("td:eq(2)").text();
		if(confirm("确认删除【"+empName+"】吗？")){
			$.ajax({
				url: "${APP_PATH}/emp/"+$(this).attr("delete_id"),
				type: "DELETE",
				success: function(result){
					alert(result.msg);
					to_page(curremtPage, 10);
				}					
			});			
		}
		//alert(empName);		
	});
	
	//多选员工删除
	$("#empDeleteAllBnt").click(function(){
		var empNames = "";
		var empIds = "";		
		$.each($(".check_item:checked"),function(){
			empNames += $(this).parents("tr").find("td:eq(2)").text()+",";
			empIds += $(this).parents("tr").find("td:eq(1)").text()+"-";
		});
		empNames = empNames.substring(0,empNames.length-1);
		empIds = empIds.substring(0,empIds.length-1);		
		if(confirm("确认删除【"+empNames+"】吗？")){
			$.ajax({
				url: "${APP_PATH}/emp/"+empIds,
				type: "DELETE",
				success: function(result){
					alert(result.msg);
					to_page(curremtPage, 10);
				}					
			});				
		}
	});
	
</script>
</body>
</html>