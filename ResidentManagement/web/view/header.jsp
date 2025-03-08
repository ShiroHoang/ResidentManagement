<%-- 
    Document   : header
    Created on : Feb 28, 2025, 9:28:58 AM
    Author     : huyng
--%>


<%@page import="model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg custom-navbar"> 
            <div class="container">
                <a class="navbar-brand col-lg-5" href="#">
                    <img src="images/logo/logo.png" width="100%"  alt="logo"/>
                </a>
                <button class="navbar-toggler ms-auto" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse px-5 col-lg-7" id="navbarNav">
                    <ul class="navbar-nav w-100 justify-content-around">
                        <li class="nav-item align-items-center">
                            <a class="nav-link fs-5" href="nav?action=citizenMain">Trang chủ</a>
                        </li>
                        <c:if test = "${account.role eq 'Police'}">
                            <li class="nav-item align-items-center">
                                <a class="nav-link fs-5" href="nav?action=accountList">Quản lí dân cư</a>
                            </li>
                        </c:if>
                        <li class="nav-item align-items-center">
                            <a class="nav-link fs-5" href="#">Thông báo</a>
                        </li>
                        <li class="nav-item dropdown align-items-center">
                            <a class="nav-link dropdown-toggle fs-5" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                Đơn gửi
                            </a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="registration">Xem đơn đã gửi</a></li>
                                <li><a class="dropdown-item" href="nav?action=submitRequest">Gửi đơn mới</a></li>
                                    <%
                                        session = request.getSession();
                                        User user = (User) session.getAttribute("account");
                                        if (user.getRole().equalsIgnoreCase("police")) {
                                    %>
                                <li><a class="dropdown-item" href="nav?action=approveRequest">Duyệt đơn</a></li>
                                    <% }%>
                            </ul>
                        </li>
                        <li class="nav-item dropdown align-items-center">
                            <a class="nav-link dropdown-toggle align-items-center" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="fa-solid fa-user-circle fa-1x me-2"></i> 
                                <span id="account">${sessionScope.account.fullName}</span>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end">
                                <li><a class="dropdown-item" href="nav?action=citizenAccount">Hồ sơ</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item text-danger" href="logout">Đăng xuất</a></li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
    </body>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</html>
