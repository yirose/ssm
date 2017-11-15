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
<!-- Bootstrap -->
<link href="${APP_PATH}/staic/css/bootstrap.min.css" rel="stylesheet">
<script src="${APP_PATH}/staic/js/bootstrap.min.js"></script>
<script src="${APP_PATH}/staic/js/jquery.min.js"></script>
</head>
<body>
	<div class="container">
		<!-- 标题栏 -->
		<div class="row">
			<dir class="col-md-12">
				<H1>SSM-CRUD</H1>
			</dir>
		</div>
		<!-- 按钮 -->
		<div class="row">
			<div class="col-md-2 col-md-offset-10 class="text-center"">
				<button type="button" class="btn btn-sm btn-primary">
					<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
					修改
				</button>
				<button type="button" class="btn btn-sm btn-danger">
					<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
					删除
				</button>
			</div>
		</div>
		<!-- 显示表格数据-->
		<div class="row">
			<table class="table table-hover table-bordered" id="emps_table">
				<thead>
					<tr>
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
		<!-- 分页信息-->
		<div class="row">
			<!-- 分页文字信息 -->
			<div class="col-md-5">当前 页, 每页 条数据, 总 页, 总 条记录</div>
			<!-- 分页条信息 -->
			<div class="col-md-7 text-center">
				<nav aria-label="Page navigation">
				<ul class="pagination">
					<li><a href="#">首页</a></li>
					<li><a href="#" aria-label="Previous"> <span
							aria-hidden="true">&laquo;</span></a></li>
					<li class="active"><a href="#">1</a></li>
					<li><a href="#" aria-label="Next"> <span
							aria-hidden="true">&raquo;</span></a></li>
					<li><a href="#">末页</a></li>
				</ul>
				</nav>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		//1、页面加载完成以后，直接去发送一个ajax请求，要到分页数据
		$(function() {
			$.ajax({
				url : "${APP_PATH}/emps",
				data : "pn=1",
				type : "GET",
				success : function(result) {
					//console.log(result);
					//1、解析并显示员工数据
					build_emps_table(result);

					//2、解析并显示分页信息
				}
			});
		});
		function build_emps_table(result) {
			var emps = result.extend.pageInfo.list;
			
			$.each(emps, function(index, item) {
				/*
				<button type="button" class="btn btn-sm btn-primary">
				<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>修改</button>
				*/
				//构建按钮
				var eidtBnt = $("<button></button>").addClass("btn btn-sm btn-primary")
				.append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append(" 编辑");
				var delBnt = $("<button></button>").addClass("btn btn-sm btn-danger")
				.append($("<span></span>").addClass("glyphicon glyphicon-trash")).append(" 删除");				
				
				//构建表格到#emps_table tbody表格中				
				var empId = $("<td></td>").append(item.id);
				var empName = $("<td></td>").append(item.name);
				var empGender = $("<td></td>").append(item.gender);
				var empEmail = $("<td></td>").append(item.email);
				var empDepartment = $("<td></td>").append(item.department.deptName);
				var empBnt = $("<td></td>").append(eidtBnt).append(" ").append(delBnt);				
				
				
				$("<tr></tr>").append(empId)
				.append(empName)
				.append(empGender)
				.append(empEmail)
				.append(empDepartment)
				.append(empBnt)
				.appendTo("#emps_table tbody");				
			})
		}

		function build_page_nav(result) {

		}
	</script>
</body>
</html>