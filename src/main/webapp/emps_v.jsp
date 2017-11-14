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
<script src="${APP_PATH}/staic/js/vue.js"></script>
<script src="${APP_PATH}/staic/js/vue-resource.min.js"></script>
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
			<table class="table table-hover table-bordered">
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
				<tbody id="emps">

					<tr v-for="todo in todos">
						<td>{{ todo.text }}</td>
						<td>{{ todo.text }}</td>
						<td>{{ todo.text }}</td>
						<td>{{ todo.text }}</td>
						<td>{{ todo.text }}</td>
						<td class="text-center" width="230"><button type="button"
								class="btn btn-sm btn-primary">
								<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
								修改
							</button>
							<button type="button" class="btn btn-sm btn-danger">
								<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
								删除
							</button></td>
					</tr>

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
		$(document).ready(function() {
			$.getJSON("${APP_PATH}/emps", function(result, status) {
				var v = new Vue({
					el : '#emps',
					type:'pn=1',
					data : {
						pageInfo : result
					}				
				})
			});
		});
	</script>

</body>