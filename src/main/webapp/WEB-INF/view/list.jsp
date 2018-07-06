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
    <link rel="stylesheet" href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css">

    <!-- 可选的Bootstrap主题文件（一般不用引入） -->
    <%--<link rel="stylesheet" href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap-theme.min.css">--%>

    <!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
    <script src="//cdn.bootcss.com/jquery/1.11.3/jquery.min.js"></script>

    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="//cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>

</head>
<body>
    <%--使用bootstrap搭建显示页面--%>
    <div class="container">
     <%--标题--%>
        <div class="row">
            <div class="col-md-12">
                <h1>SSM-CRUD</h1>
        </div>
     <%--按钮--%>
        <div class="row">
            <div class="col-md-4 col-md-offset-8">
                <button type="button" class="btn btn-primary">新增</button>
                <button type="button" class="btn btn-danger">删除</button>
        </div>
     <%--显示表格数据--%>
        <div class="row">
            <div class="col-md-12">
     <%--显示分页信息--%>
        <div class="row">
            <div class="col-md-12">
                <table class="table table-hover">
                    <tr>
                        <th>#</th>
                        <th>empName</th>
                        <th>gender</th>
                        <th>email</th>
                        <th>deptName</th>
                        <th>操作</th>
                    </tr>
                    <c:forEach items="${pageInfo.list}" var="emp">
                        <tr>
                            <th>${emp.empId}</th>
                            <th>${emp.empName}</th>
                            <th>${emp.gender=="M"?"男":"女"}</th>
                            <th>${emp.email}</th>
                            <th>${emp.department.deptName}</th>
                            <th>
                                <button class="btn btn-primary btn-sm">
                                    <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                    编辑
                                </button>
                                <button class="btn btn-dangerbtn-sm ">
                                    <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                                    删除
                                </button>
                            </th>
                        </tr>
                    </c:forEach>

                </table>
        </div>
<%--显示分页信息--%>
             <div class="row">
                 <%--分页文字信息--%>
                 <div class="col-md-6">
                     当前第 ${pageInfo.pageNum} 页，共 ${pageInfo.pages} 页，共 ${pageInfo.total} 条记录
                 </div>
                 <%--分页条信息--%>
                     <div class="col-md-6">
                         <nav aria-label="Page navigation">
                             <ul class="pagination">

                                 <li>
                                     <a href="${APP_PATH}/emps?pn=1">首页</a>
                                 </li>

                                 <c:if test="${pageInfo.hasPreviousPage}">
                                     <li>
                                         <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum-1}" aria-label="Previous">
                                             <span aria-hidden="true">&laquo;</span>
                                         </a>
                                     </li>
                                 </c:if>

                                 <c:forEach items="${pageInfo.navigatepageNums}" var="pageNums">
                                     <c:if test="${pageNums==pageInfo.pageNum}">
                                        <li class="active"><a href="#">${pageNums}</a></li>
                                     </c:if>
                                     <c:if test="${pageNums!=pageInfo.pageNum}">
                                         <li><a href="${APP_PATH}/emps?pn=${pageNums}">${pageNums}</a></li>
                                     </c:if>
                                 </c:forEach>

                                 <c:if test="${pageInfo.hasNextPage}">
                                     <li>
                                         <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum+1}" aria-label="Next">
                                             <span aria-hidden="true">&raquo;</span>
                                         </a>
                                     </li>
                                 </c:if>

                                 <li>
                                     <a href="${APP_PATH}/emps?pn=${pageInfo.pages}">尾页</a>
                                 </li>
                             </ul>
                         </nav>
                     </div>

</body>
</html>
