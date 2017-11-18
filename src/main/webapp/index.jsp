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

	<!-- 员工添加模态框 -->
	<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">员工信息添加</h4>
	      </div>
	      <div class="modal-body">
	        ...
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-sm btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-sm btn-primary">保存</button>
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
			<div class="col-md-2 col-md-offset-10 class="text-center"">				
				<button type="button" class="btn btn-sm btn-primary" id="empAddModalBnt">
					<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>新增</button>
				<button type="button" class="btn btn-sm btn-danger">
					<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除</button>
			</div>
		</div>
		<!-- 显示表格数据-->
		<div class="row">
		<div class="col-md-12">
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
	
		//1、页面加载完成以后，直接去发送一个ajax请求，要到分页数据
		$(function() {			
			//去首页
			to_page(1,10);			
		});
		
		function to_page(pn ,nn){		
			$.ajax({
				url : "${APP_PATH}/emps",
				data :"pn="+pn+"&nn=" + nn ,
				type : "GET",
				success : function(result) {
					//console.log(result);					
					//1、解析并显示员工数据
					build_emps_table(result);					
					//2、解析并显示员工数据
					build_page_info(result);
					//3、解析并显示分页信息
					build_page_nav(result,nn);					
				}
			});
		}
		
		//解析员工信息
		function build_emps_table(result) {	
			$("#emps_table tbody").empty();
			var emps = result.extend.pageInfo.list;			
			$.each(emps, function(index, item) {
				/*
				<button type="button" class="btn btn-sm btn-primary">
				<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>修改</button>
				*/
				//构建按钮
				var eidtBnt = $("<button></button>").addClass("btn btn-xs btn-info")
				.append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append(" 编辑");
				var delBnt = $("<button></button>").addClass("btn btn-xs btn-danger")
				.append($("<span></span>").addClass("glyphicon glyphicon-trash")).append(" 删除");				
				
				//构建表格到#emps_table tbody表格中				
				var empId = $("<td></td>").append(item.id);
				var empName = $("<td></td>").append(item.name);
				var empGender = $("<td></td>").append(item.gender=="m"?"男":"女");
				var empEmail = $("<td></td>").append(item.email);
				var empDepartment = $("<td></td>").append(item.department.deptName);
				var empBnt = $("<td></td>").addClass("operationwidth").append(eidtBnt).append(" ").append(delBnt);				
								
				$("<tr></tr>").append(empId)
				.append(empName)
				.append(empGender)
				.append(empEmail)
				.append(empDepartment)
				.append(empBnt)
				.appendTo("#emps_table tbody");				
			})
		}
		
		//解析显示分页信息
		function build_page_info(result){
			$("#page_info_area").empty();
			var pageInfo = result.extend.pageInfo;
			$("#page_info_area").append("当前 "+pageInfo.pageNum+" 页, 每页 "+pageInfo.pageSize+" 条数据, 总 "+pageInfo.pages+" 页, 总 "+pageInfo.total+" 条记录");			
		}
		
		//解析分页条信息
		function build_page_nav(result,nn) {

			$("#page_nav_area").empty();			
			var pageInfo = result.extend.pageInfo;
			var navNums = pageInfo.navigatepageNums;
			var pageNum = pageInfo.pageNum;
			var pages = pageInfo.pages;
			
			//<li><a href="${APP_PATH}/emps?pn=1">首页</a>
			var ul = $("<ul></ul>").addClass("pagination page_nav_lh");
			var firstPageLi = $("<li></li>").append($("<a></a>").append("首页"));	
			var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));			
			
			//判断是否第一页	
			if(pageInfo.hasPreviousPage == false){
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			}else{
				firstPageLi.click(function(){
					to_page(1,nn);					
				});
				prePageLi.click(function(){
					to_page(pageNum - 1,nn);					
				});				
			}
			//在ul中添加首页和上一页提示
			ul.append(firstPageLi).append(prePageLi);
			
			// 分页遍历
			$.each(navNums, function(index, item){
				var numLi = $("<li></li>").append($("<a></a>").append(item));
				if(pageNum == item){
					numLi.addClass("active");					
				}else{
					numLi.click(function(){
						to_page(item,nn);					
					});
				}								
				//在ul中添加页码提示
				ul.append(numLi);
			});
			
			var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));			
			var lastPageLi = $("<li></li>").append($("<a></a>").append("末页"));
			
			//判断是否最后一页
			if(pageInfo.hasNextPage == false){
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
			}else{
				nextPageLi.click(function(){
					to_page(pageNum + 1,nn);					
				});
				lastPageLi.click(function(){
					to_page(pages,nn);					
				});
			}
			
			//在ul中添加下一页和末页提示
			ul.append(nextPageLi).append(lastPageLi);
			
			//下拉菜单
			var btnG01 =$("<button></button>").addClass("btn btn-default").append(nn);
			var btnG02 =$("<button></button>").addClass("btn btn-default btn-dropdown").append($("<span></span>").addClass("caret").append($("<span></span>")));
			
			var nLi1 = $("<li></li>").append($("<a></a>").append(10));
			var nLi2 = $("<li></li>").append($("<a></a>").append(20));
			var nLi3 = $("<li></li>").append($("<a></a>").append(40));
			var nLi4 = $("<li></li>").append($("<a></a>").append(80));
			var nLi5 = $("<li></li>").append($("<a></a>").append(160));			
			var groupUl = $("<ul></ul>").addClass("dropdown-menu").append(nLi1).append(nLi2).append(nLi3).append(nLi4).append(nLi5);
			var btn_group = $("<div></div>").addClass("btn-group").append(btnG01).append(btnG02).append(groupUl);
	
			nLi1.click(function(){
				to_page(pageNum ,10);					
				});
			nLi2.click(function(){
				to_page(pageNum ,20);					
			});
			nLi3.click(function(){
				to_page(pageNum ,40);					
			});
			nLi4.click(function(){
				to_page(pageNum ,80);					
			});
			nLi5.click(function(){
				to_page(pageNum ,160);					
			});
						
			btnG02.click(function(){
				$(groupUl).toggle(true);
				});			
			var nav = $("<nav></nav>").append(ul);			
			$("#page_nav_area").append(btn_group).append(nav);
		}
		
		//打开模态框
		$("#empAddModalBnt").click(function(){
			$('#empAddModal').modal({
				backdrop:"static"
			});
		});
	</script>
</body>
</html>