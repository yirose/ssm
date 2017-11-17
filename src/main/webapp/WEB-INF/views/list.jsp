<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<script src="${APP_PATH}/staic/js/libs/bootstrap.min.js"></script>
<script src="${APP_PATH}/staic/js/libs/jquery.min.js"></script>
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
				<tbody>
					<c:forEach items="${pageInfo.list}" var="emp">
						<tr>
							<td>${emp.id}</td>
							<td>${emp.name}</td>
							<td>${emp.gender}</td>
							<td>${emp.email}</td>
							<td>${emp.department.deptName}</td>
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
					</c:forEach>
				</tbody>
			</table>
		</div>
		<!-- 分页信息-->
		<div class="row">
			<!-- 分页文字信息 -->
			<div class="col-md-5">当前 ${pageInfo.pageNum} 页, 每页  ${pageInfo.pageSize} 条数据, 总
				${pageInfo.pages} 页, 总 ${pageInfo.total} 条记录</div>
			<!-- 分页条信息 -->
			<div class="col-md-7 text-center">
				<nav aria-label="Page navigation">
				<ul class="pagination">
					<li><a href="${APP_PATH}/emps?pn=1">首页</a></li>
					<c:if test="${pageInfo.hasPreviousPage}">
						<li><a href="${APP_PATH}/emps?pn=${pageInfo.pageNum-1}"
							aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
						</a></li>
					</c:if>
					<c:forEach items="${pageInfo.navigatepageNums }" var="page_Num">
						<li
							<c:if test="${page_Num ==pageInfo.pageNum}">class="active"</c:if>><a
							href="${APP_PATH}/emps?pn=${page_Num}">${page_Num}</a></li>
					</c:forEach>
					<c:if test="${pageInfo.hasNextPage}">
					<li><a href="${APP_PATH}/emps?pn=${pageInfo.pageNum+1}"
						aria-label="Next"> <span aria-hidden="true">&raquo;</span>
					</a></li>
					</c:if>
					<li><a href="${APP_PATH}/emps?pn=${pageInfo.pages}">末页</a></li>
				</ul>
				</nav>
			</div>
		</div>
	</div>
</body>
</html>