<%--
  Created by IntelliJ IDEA.
  User: Joker
  Date: 2018/6/21
  Time: 20:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
    <title>员工列表</title>
    <%
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>
    <%--web路径
   不以/开始的相对路径，找资源，以当前资源的路径为基准，容易出问题
   以/开始的相对路径，找资源，以服务器的路径为标准（http://localhost:3306）需要加上项目地址
   http://localhost:3306/ssmcrud--%>
    <!-- 新 Bootstrap 核心 CSS 文件 -->
    <link rel="stylesheet" href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css">
    <!-- 可选的Bootstrap主题文件（一般不用引入） -->
    <%--<link rel="stylesheet" href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap-theme.min.css">--%>
    <!-- jQuery文件。务必在bootstrap.min.js 之前引入(可能下错了，引入网址才正常) -->
    <script src="//cdn.bootcss.com/jquery/1.11.3/jquery.min.js"></script>
    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>

<body>
<%--弹出的添加员工模态框--%>
<!-- Modal -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">添加员工</h4>
            </div>
            <div class="modal-body">
                <%--导入表单--%>
                <form>
                    <div class="form-group">
                        <label>员工姓名</label>
                        <input type="text" class="form-control" id="empName_add_input" name="empName" placeholder="Name">
                        <span class="help-block"></span>
                    </div>
                    <div class="form-group">
                    <label>邮箱</label>
                    <input type="text" class="form-control" id="email_add_input" name="email" placeholder="Example@xxx.com">
                        <span class="help-block"></span>
                </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <div class="radio">
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender1" value="M" checked="checked"> 男
                                </label>
                                <label class="radio-inline">
                                        <input type="radio" name="gender" id="gender2" value="F"> 女
                                </label>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">所属部门</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="dept_add_select"></select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<%--修改、更新员工模态框--%>
<!-- Modal -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <div class="modal-body">
                <%--导入表单--%>
                <form>
                    <div class="form-group">
                        <label>员工姓名</label>
                        <p class="form-control-static" id="empName_update_static"></p>
                        <span class="help-block"></span>
                    </div>
                    <div class="form-group">
                        <label>邮箱</label>
                        <input type="text" class="form-control" id="email_update_input" name="email" placeholder="Example@xxx.com">
                        <span class="help-block"></span>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <div class="radio">
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender1_update" value="M" checked="checked"> 男
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender2_update" value="F"> 女
                                </label>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">所属部门</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="dept_update_select"></select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<%--使用bootstrap搭建显示页面--%>


<div class="container">
    <%--标题--%>
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-员工管理系统</h1>
        </div>
        <%--按钮--%>
        <div class="row">
            <div class="col-md-4 col-md-offset-8">
                <button type="button" class="btn btn-primary" id="emp_add_modal_btn">新增</button>
                <button type="button" class="btn btn-danger" id="emp_delete_all_btn">删除所选</button>
            </div>
            <%--显示表格数据--%>
            <div class="row">
                <div class="col-md-12">
                    <%--显示分页信息--%>
                    <div class="row">
                        <div class="col-md-12">
                            <table class="table table-hover" id="emps_table">
                                <thead>
                                <tr>
                                    <th>
                                        <input type="checkbox" id="checkAll"/>
                                    </th>
                                    <th>员工编号</th>
                                    <th>员工姓名</th>
                                    <th>性别</th>
                                    <th>邮箱</th>
                                    <th>所属部门</th>
                                    <th>操作</th>
                                </tr>
                                </thead>

                                <tbody>
                                </tbody>

                            </table>
                        </div>
                        <%--显示分页信息--%>
                        <div class="row">
                            <%--分页文字信息--%>
                            <div class="col-md-6" id="page_info_area">
                            </div>
                            <%--分页条信息--%>
                            <div class="col-md-6" id="page_nav_area">
                            </div>
                                <%----------------用js来完成显示逻辑-----------------%>

                                <script type="text/javascript">
                                    //标志总记录数
                                    var totalRecord,currentPage;
                                    //页面加载完成以后，发送一个ajax请求，得到分页数据
                                    $(function() {
                                        //去首页
                                        to_page(1);
                                    });

                                    function to_page(pn) {
                                        $.ajax({
                                            url : "${APP_PATH}/emps",
                                            data : "pn=" + pn,
                                            type : "GET",
                                            success : function(result) {
                                                //console.log(result);
                                                //1.解析并显示员工数据
                                                build_emps_table(result);
                                                //2.解析并显示分页信息
                                                build_page_info(result);
                                                //3.显示分页条信息
                                                build_page_nav(result);
                                            }
                                        });
                                    }

                                    /*=============解析员工数据，并添加到列表下面，形成完整列表模式框架==========*/
                                    function build_emps_table(result) {
                                        //清空表格数据
                                        $("#emps_table tbody").empty();
                                        var emp = result.extend.pageInfo.list;
                                        //jquery遍历方法each，emp第一个遍历的元素,item当前对象
                                        //此处要对照JSON数据，获取到员工的list
                                        //item.*读取bean中数据
                                        $.each(emp, function(index, item) {
                                            var checkBoxTD=$("<td><input type='checkbox' class='check_item'/></td>");
                                            var empIdTd = $("<td></td>").append(item.empId);
                                            var empNameTd = $("<td></td>").append(item.empName);
                                            var GenderTd = $("<td></td>").append(item.gender == 'M' ? "男" : "女");
                                            var EmailTd = $("<td></td>").append(item.email);
                                            var deptNameTd = $("<td></td>").append(item.department.deptName);
                                            var editBtn = $("<button></button>").
                                            addClass("btn btn-primary  btn-sm edit-btn").
                                            append($("<span></span>").
                                            addClass("glyphicon glyphicon-pencil")).
                                            append("编辑");
                                            //为编辑按钮添加一个自定义的属性，来表示当前员工。赋值给edit-id
                                            editBtn.attr("edit-id",item.empId);

                                            var delBth = $("<button></button>").addClass(
                                                "btn btn-danger  btn-sm delete-btn").
                                            append($("<span></span>").
                                            addClass("glyphicon glyphicon-trash")).
                                            append("删除");
                                            //为删除按钮添加一个自定义的属性，来表示当前员工。赋值给edit-id
                                            delBth.attr("del-id",item.empId);

                                            var btnTd = $("<td></td>").
                                            append(editBtn).
                                            append(" ").
                                            append(delBth);
                                            //append方法执行完以后还是返回原来的元素，所以可以不停使用append方法添加内容
                                            $("<tr></tr>").
                                            append(checkBoxTD).
                                            append(empIdTd).
                                            append(empNameTd).
                                            append(GenderTd).
                                            append(EmailTd).
                                            append(deptNameTd).
                                            append(btnTd).
                                                appendTo("#emps_table tbody");
                                            /* <button class="btn btn-primary  btn-sm">
                                            <span class="glyphicon glyphicon-pencil " aria-hidden="true"></span>
                                            编辑
                                            </button> */
                                        });
                                    }
                                    /*=============解析并显示分页信息==========*/
                                    function build_page_info(result) {
                                        $("#page_info_area").empty();
                                        $("#page_info_area").append("当前第" + result.extend.pageInfo.pageNum + "页，" +
                                            "总共" + result.extend.pageInfo.pages + "页，" +
                                            "总共" + result.extend.pageInfo.total + "条记录")
                                        totalRecord = result.extend.pageInfo.total;
                                        currentPage= result.extend.pageInfo.pageNum;
                                    }
                                    /*=============解析并显示分页条信息==========*/
                                    function build_page_nav(result) {
                                        $("#page_nav_area").empty();
                                        var ul = $("<ul></ul>").addClass("pagination");
                                        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
                                        var prevPageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
                                        if(result.extend.pageInfo.isFirstPage == true){
                                            firstPageLi.addClass("disabled");
                                            prevPageLi.addClass("disabled");
                                        }else{
                                            //为元素添加点击翻页的事件
                                            firstPageLi.click(function(){
                                                to_page(1);
                                            })
                                            prevPageLi.click(function(){
                                                to_page(result.extend.pageInfo.pageNum-1);
                                            })
                                        }

                                        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
                                        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
                                        if(result.extend.pageInfo.isLastPage == true){
                                            lastPageLi.addClass("disabled");
                                            nextPageLi.addClass("disabled");
                                        }else{
                                            //为元素添加点击翻页的事件
                                            nextPageLi.click(function(){
                                                to_page(result.extend.pageInfo.pageNum+1);
                                            })
                                            lastPageLi.click(function(){
                                                to_page(result.extend.pageInfo.pages);
                                            })
                                        }

                                        //添加首页和前一页
                                        ul.append(firstPageLi).append(prevPageLi);
                                        $.each(result.extend.pageInfo.navigatepageNums,function(index,item){

                                            var numLi = $("<li></li>").append($("<a></a>").append(item));
                                            if(result.extend.pageInfo.pageNum == item){
                                                numLi.addClass("active");
                                            }
                                            numLi.click(function(){
                                                to_page(item);
                                            })
                                            ul.append(numLi);
                                        });
                                        //添加下一页和末页的提示
                                        ul.append(nextPageLi).append(lastPageLi);
                                        //把ul加入到nav里面
                                        var navEle = $("<nav></nav>").append(ul);
                                        navEle.appendTo("#page_nav_area");
                                    }

                                    //清除表单数据和样式的方法
                                    function reset_form(ele){
                                        $(ele)[0].reset();
                                        //清空样式
                                        //清除状态
                                        $(ele).find("*").removeClass("has-error has-sussess");
                                        //清空help-block
                                        $(ele).find(".help-block").test("");
                                    }

                                    //点击新增按钮弹出模态框
                                    $("#emp_add_modal_btn").click(function(){
                                        //清除数据，重置表单（表单数据和样式都要重置）
                                        $("#empAddModal form")[0].reset();
                                        //reset可把表单的元素重置，是dom的方法，不能直接调用
                                        //发送ajax请求，查出部门信息，并显示在下拉列表中
                                        getDepts("#empAddModal select");
                                        $("#empAddModal").modal({
                                            backdrop:"static"
                                        });
                                    });
                                    //查出所有部门的方法
                                    function getDepts(ele){
                                        //清空下拉列表
                                        $(ele).empty();
                                        $.ajax({
                                            url:"${APP_PATH}/depts",
                                            type:"GET",
                                            success:function(result){
                                                //console.log(result)
                                                //将部门信息显示在下拉列表中
                                                //$("#empAddModal select").append("")
                                                $.each(result.extend.depts,function(){
                                                    var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
                                                    optionEle.appendTo(ele);
                                                });
                                            }
                                        });
                                    }

                                    //校验表单数据方法
                                    function validate_add_form(){
                                        //1.拿到数据进行比较，先检验用户名
                                        var empName = $("#empName_add_input").val();
                                        var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
                                        if(!regName.test(empName)){
                                            //alert("用户名仅可为2-5位中文或6-16位英文和数字的组合");
                                            //应该清空元素之前的样式
                                            show_validate_msg("#empName_add_input","error","用户名仅可为2-5位中文或6-16位英文和数字的组合");
                                            return false;
                                        }else{
                                            show_validate_msg("#empName_add_input","success","");
                                        };
                                        //2.如果用户名正确，检验邮箱
                                        var email = $("#email_add_input").val();
                                        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
                                        if(!regEmail.test(email)){
                                            //alert("邮箱格式不正确");
                                            show_validate_msg("#email_add_input","error","邮箱格式不正确");
                                            return false;
                                        }else{
                                            show_validate_msg("#email_add_input","success","");
                                        }
                                        return true;
                                    }

                                    //显示校验结果的信息
                                    function show_validate_msg(ele,status,msg){
                                        //清除当前元素的校验状态
                                        $(ele).parent().removeClass("has-success has-error");
                                        $(ele).next("span").text("");
                                        if("success"== status){
                                            $(ele).parent().addClass("has-success");
                                            $(ele).next().text(msg);
                                        }else if("error" == status){
                                            $(ele).parent().addClass("has-error");
                                            $(ele).next().text(msg);
                                        }
                                    }

                                    $("#empName_add_input").change(function(){
                                        //发送ajax请求检验用户名是否可用
                                        var empName=this.value;
                                        $.ajax({
                                            url:"${APP_PATH}/checkuser",
                                            data:"empName="+empName,
                                            type:"POST",
                                            success:function(result){
                                                if(result.code==100)
                                                {//result为MSG
                                                    show_validate_msg("#empName_add_input","success","用户名可用");
                                                    $("#emp_save_btn").attr("ajax-va","success");
                                                }
                                                else{
                                                    show_validate_msg("#empName_add_input","error",result.extend.va_msg);
                                                   $("#emp_save_btn").attr("ajax-va","error");
                                                }
                                            }
                                        });

                                    });

                                    $("#emp_save_btn").click(function(){
                                       //1.将模态框里填入的数据提交给服务器进行保存
                                        //2.要对数据进行校验
                                        if(!validate_add_form()){
                                            return false;
                                        };
                                        //3.判断用户名校验是否通过
                                        if($(this).attr("ajax-va")=="error"){
                                            return false;
                                        }

                                        //4.判断邮箱校验是否通过（方便起见，邮箱允许相同）
                                       //5.发送ajax请求保存员工
                                       $.ajax({
                                           url:"${APP_PATH}/emp",
                                           type:"POST",
                                           data:$("#empAddModal form").serialize(),
                                           success:function(result) {
                                               //alert(result.msg);
                                               //判断数据是否校验成功
                                               if (result.code == 100) {
                                                   //1.关闭模态框
                                                   $("#empAddModal").modal('hide');
                                                   //2.跳转到末页
                                                   //发送ajax请求显示最后一页数据即可
                                                   //可以将总记录数作为页码进行跳转，可保证超过页码数，从而稳定跳转到末页
                                                   to_page(totalRecord);
                                               }else{
                                                   //显示失败信息
                                                   //有哪个错误就显示哪个
                                                   if(undefined !=result.extend.errorFields.email){
                                                       //显示邮箱错误信息
                                                       show_validate_msg("#email_add_input","error",result.extend.errorFields.email);
                                                   }
                                                   if(undefined !=result.extend.errorFields.empName){
                                                       //显示用户名错误信息
                                                       show_validate_msg("#empName_add_input","error",result.extend.errorFields.empName);
                                                   }
                                                   alert(result.extend.errorFields.email);
                                                   alert(result.extend.errorFields.empName);
                                               }
                                           }

                                       });
                                    });

                                    $(document).on("click",".delete-btn",function(){
                                        //1.弹出是否确认的对话框
                                        var empName = $(this).parents("tr").find("td:eq(2)").text();
                                        var empId = $(this).attr("del-id");
                                        //2.确认要删除的员工姓名

                                        if(confirm("确认删除["+empName+"]吗?")){
                                            $.ajax({
                                                url:"${APP_PATH}/emp/"+empId,
                                                type:"DELETE",
                                                success:function(result){
                                                    alert(result.msg);
                                                    to_page(currentPage);
                                                }
                                            });
                                        }
                                    });

                                    //1.按钮创建之后再绑定click
                                    //1）可以在创建按钮时绑定
                                    //2）绑定点击.live()
                                    //jquery新版没有live，替代的是on
                                    $(document).on("click",".edit-btn",function(){
                                        //查出部门信息
                                        getDepts("#empUpdateModal select");
                                        //查出员工信息
                                        getEmp($(this).attr("edit-id"));
                                        //弹出模态框
                                        //把员工的id传递给更新按钮
                                        $("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
                                        $("#empUpdateModal").modal({
                                            backdrop:"static"
                                        });

                                    });

                                    function getEmp(id){
                                        $.ajax({
                                            url:"${APP_PATH}/emp/"+id,
                                            type:"GET",
                                            success:function(result){
                                                //console.log(result);
                                                var empData = result.extend.emp;
                                                $("#empName_update_static").text(empData.empName);
                                                $("#email_update_input").val(empData.email);
                                                $("#empUpdateModal input[name=gender]").val([empData.gender]);
                                                $("#empUpdateModal select").val([empData.dId]);
                                            }
                                        });
                                    }

                                    $("#emp_update_btn").click(function(){
                                       //默认用户名不可改动
                                       //验证邮箱
                                        var email = $("#email_update_input").val();
                                        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
                                        if(!regEmail.test(email)){
                                            //alert("邮箱格式不正确");
                                            show_validate_msg("#email_update_input","error","邮箱格式不正确");
                                            return false;
                                        }else{
                                            show_validate_msg("#email_update_input","success","");
                                        }
                                        //性别和部门不需要验证
                                        //发送ajax请求保存更新
                                        $.ajax({
                                            //从controller中获取参数，从页面取得元素赋值，将更新按钮带的id传入
                                            url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
                                            type:"PUT",
                                            data:$("#empUpdateModal form").serialize(),
                                            success:function(result){
                                                // alert(result.msg);
                                                //1.关闭对话框
                                                $("#empUpdateModal").modal("hide");

                                                //2.回到本页面
                                                to_page(currentPage);
                                            }
                                        });
                                    });
                                    //完成全选、全不选功能
                                    $("#checkAll").click(function(){
                                        //attr获取checked是undefied；
                                        //dom原生的属性推荐使用prop，attr获取自定义属性的值
                                       //$(this).prop("checked");
                                       $(".check_item").prop("checked",$(this).prop("checked"));
                                    });
                                    //check_item全部选择时，checkAll也需要变成checked
                                    $(document).on("click",".check_item", function(){
                                        //判断check_item选中的个数
                                        var flag = $(".check_item:checked").length == $(".check_item").length;
                                        $("#checkAll").prop("checked",flag);
                                    });

                                    //点击全部删除，进行批量删除
                                    $("#emp_delete_all_btn").click(function(){
                                        var empNames="";
                                        var del_idstr="";
                                        $.each($(".check_item:checked"),function(){
                                            //组装员工名字字符串
                                            empNames+=$(this).parents("tr").find("td:eq(2)").text()+",";
                                            //组装员工ID
                                            del_idstr+=$(this).parents("tr").find("td:eq(1)").text()+"-";
                                        });
                                        //删除最后一个","
                                        empNames=empNames.substring(0,empNames.length-1);
                                        //删除最后一个"-"
                                        del_idstr=del_idstr.substring(0,del_idstr.length-1);
                                        if(confirm("确认删除["+empNames+"]吗？")){
                                            //发送ajax请求
                                            $.ajax({
                                                url:"${APP_PATH}/emp/"+del_idstr,
                                                type:"DELETE",
                                                success:function(result)
                                                {
                                                    //alert(result.msg);
                                                    to_page(currentPage);
                                                }
                                            });
                                        }
                                    });
                                </script>

</body>
</html>