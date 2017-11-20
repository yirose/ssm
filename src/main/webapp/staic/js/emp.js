/**
 * 员工js 处理文件
 */
// 获取APP_PATH路径
var localObj = window.location;
var contextPath = localObj.pathname.split("/")[1];
var basePath = localObj.protocol+"//"+localObj.host+"/"+contextPath;

var totalRecord;
// 1、页面加载完成以后，直接去发送一个ajax请求，要到分页数据
$(function () {
	// 去首页
	to_page(1, 10);
});

function to_page(pn, nn) {
	$.ajax({
		url: basePath+"/emps",
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
		var eidtBnt = $("<button></button>").addClass("btn btn-xs btn-info")
			.append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append(" 编辑");
		var delBnt = $("<button></button>").addClass("btn btn-xs btn-danger")
			.append($("<span></span>").addClass("glyphicon glyphicon-trash")).append(" 删除");

		// 构建表格到#emps_table tbody表格中
		var empId = $("<td></td>").append(item.id);
		var empName = $("<td></td>").append(item.name);
		var empGender = $("<td></td>").append(item.gender == "m" ? "男" : "女");
		var empEmail = $("<td></td>").append(item.email);
		var empDepartment = $("<td></td>").append(item.department.deptName);
		var empBnt = $("<td></td>").addClass("operationwidth").append(eidtBnt)
			.append(" ").append(delBnt);

		$("<tr></tr>").append(empId).append(empName).append(empGender).append(
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
	totalRecord = pages;
	// <li><a href="basePath/emps?pn=1">首页</a>
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

// 打开模态框
$("#empAddModalBnt").click(function () {
	// 1: 发送ajax请求，查出部门信息，显示在下拉列表中
	getDepts();

	// 2：弹出模态框
	$('#empAddModal').modal({
		backdrop: "static"
	});
});

// 发送ajax请求，查出部门信息，显示在下拉列表中
function getDepts() {
	$.ajax({
		url: basePath+"/depts",
		type: "GET",
		success: function (result) {
			// 显示部门信息在下拉列表中
			// 两种写法 一种传参 一种部传参
			/*
			 * $.each( result.extend.depts, function(index, item) { $("<option></option>").val(item.deptId).append(item.deptName).appendTo("#empAddModal
			 * select"); });
			 */

			$.each(result.extend.depts, function () {
				$("<option></option>").val(this.deptId).append(this.deptName)
					.appendTo("#empAddModal select");
			});
		}
	});
	// 校验name email表单数据
	function validateAddForm() {
		// 1: 拿到要校验的数据，使用正则表达式

	}

	// 保存员工的方法
	$("#empSaveBnt").click(function () {
		// 1、将模态框中填写的表单数据提交给服务器进行保存
		// 2、发送ajax请求保存员工
		$.ajax({
			url: basePath+"/emp",
			type: "POST",
			// jquery serialize() 序列表表格内容为字符串。
			data: $("#empAddModal form").serialize(),
			success: function (result) {
				// alert(result.msg);
				// 关闭模态框
				$('#empAddModal').modal('hide');
				// 来到最后一页，显示刚才保存数据。
				to_page(totalRecord, 10);
			}
		});
	});
}