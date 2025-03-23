<%-- 
    Document   : accountList
    Created on : Mar 5, 2025, 9:28:11 PM
    Author     : AN515-57
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "java.util.ArrayList" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>News page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
        <link rel="stylesheet" href="css/main.css"/>
        <link rel="icon" href="images/star.png" type="image/x-icon"/>
        <style>
            body {
                font-family: 'Nunito', Arial;
                font-size: 18px;
                line-height: 1.3333;
                color: #1E2F41;
                height: 100%;
            }
            .hero {
                height: 100vh;
                background: linear-gradient(rgba(144, 7, 13), rgba(0, 0, 0, 0.5)), url('images/trong-dong.jpg');
                background-size: cover;
                color: white;
                display: flex;
                align-items: center;
                justify-content: center;
                text-align: center;
            }
            .hero{
                height: 100vh;
                background: linear-gradient(rgba(144, 7, 13), rgba(0, 0, 0, 0.5)), url('https://free.vector6.com/wp-content/uploads/2021/03/E269-vector-trong-dong.jpg');
                background-size: cover;
                color: yellow;
                display: flex;
                align-items: center;
                justify-content: center;
                text-align: center;
            }
            .buttons{
                width: 40%;
            }
            .btn:hover {
                background-color: #CE7A58;
                color: #fff;
            }
            .btn{
                margin: 0px 3px;
                border-color: #CE7A58;
                color: #1E2F41;
                border-radius: 3px;
                width: 130px;
                min-width: 0px;
                font-size: 18px;
                height: auto;
                font-weight: 500;
            }
            .btn-fourth:hover {
                background: #ffb01e;
            }
            .btn-fourth {
                background: #FFC251;
                color: #000;
                font-weight: 500;
                width: 100%;
                min-height: 100px;
            }
            
            .actions{
                margin:-200px;
                max-width: 800px;
            }
            .navbar-nav .nav-link:hover {
                color: #ffcc00 !important;
                transform: scale(1.1);
            }
            @media (max-width: 768px) {
                .hero h1 {
                    font-size: 2rem;
                    height: 300px;
                }
                .navbar-brand{
                    width: 100%;
                }
                .navbar-brand img {
                    width: 150px; /* Reduce logo size on mobile */
                }
                .navbar-nav {
                    text-align: center; /* Center navigation items */
                }
                .navbar-nav .nav-item {
                    margin-bottom: 10px; /* Space out items */
                }
                .hero {
                    height: auto; /* Adjust height */
                    padding: 50px 20px;
                }
            }
            table {
                margin: auto;
                background-color: white;
                border-radius: 10px;
                color: black;
            }
            td {
                padding: 10px;
            }
            body {
                font-family: Arial, sans-serif;
                background-color: #f8f9fa;
            }

            body {
                font-family: Arial, sans-serif;
                background-color: #f8f9fa;
            }

            .section-title {
                font-size: 24px;
                font-weight: bold;
                margin-bottom: 20px;
            }

            /* News Card */
            .news-card {
                background: white;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            .news-card a {
                text-decoration: none;
                color: black;
                display: block;
            }

            /* Hover Effect */
            .news-card a:hover {
                color: #007bff; /* Change color to Bootstrap blue */
            }

            .news-card a h3 {
                font-size: 18px;
                font-weight: bold;
                margin-bottom: 10px;
            }

            .news-card a:hover h3 {
                text-decoration: underline; /* Underline on hover */
                color: #d9534f; /* Change to red */
            }

            .news-card p {
                font-size: 14px;
                color: gray;
            }

            /* News Image */
            .news-image img {
                width: 100%;
                height: 250px;
                object-fit: cover;
                border-radius: 10px;
            }

            /* Responsive Design */
            @media (max-width: 768px) {
                .news-card {
                    text-align: center;
                }
                .news-card h3 {
                    font-size: 16px;
                }
            }

        </style>
    </head>

    <body>
        <c:if test="${sessionScope.account ne null}">
            <jsp:include page="header.jsp"/>
        </c:if>
        <c:if test="${sessionScope.account eq null}">
            <nav class="navbar navbar-expand-lg custom-navbar"> 
                <!--            used for responsive when using smaller screen-->
                <div class="container">
                    <a class="navbar-brand col-lg-5" href="home.html">
                        <img src="images/logo/logo.png" width="100%"  alt="logo"/>
                    </a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse px-5" id="navbarNav">
                        <ul class="navbar-nav ms-auto">
                            <li class="nav-item"><a href="login" class="btn btn-login">Đăng nhập</a></li>
                            <li class="nav-item"><a href="RegisterAccount" class="btn btn-login">Đăng ký</a></li>
                        </ul>
                    </div>
                </div>
            </nav>
            
        </c:if>
        <div class="hero">
            <div class="container  mt-4">
                <h2 class="section-title">Tin Mới</h2>

                <!-- First Row: 3 Smaller News Items -->
                <div class="row">
                    <div class="col-md-4">
                        <div class="news-card">
                            <a href="news?action=news1">
                                <h3>Tạm dừng các hệ thống thuế điện tử đến 8 giờ sáng ngày 17/3</h3>
                            </a>
                        </div>
                    </div>

                    <div class="col-md-4">
                        <div class="news-card">
                            <a href="news?action=news2">
                                <h3>Hướng dẫn khắc phục lỗi khi đăng ký tài khoản trên Cổng Dịch vụ công quốc gia</h3>
                            </a>
                        </div>
                    </div>

                    <div class="col-md-4">
                        <div class="news-card">
                            <a href="news?action=news3">
                                <h3>Cung cấp dịch vụ công "Giải quyết hưởng trợ cấp thất nghiệp" trên Cổng Dịch vụ công quốc gia</h3>
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Second Row: Large Image + Big News Item -->
                <div class="row mt-4">
                    <div class="col-md-6">
                        <div class="news-image">
                            <a href="news?action=news4">
                                <img src="images/news/danny.jpeg" alt="tin moi">
                            </a>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="news-card">
                            <a href="news?action=news4">
                                <h3>Thủ tục, cách thức đổi, cấp giấy phép lái xe từ ngày 1/3</h3>
                                <p>Đại diện Cục Cảnh sát giao thông (Bộ Công an) cho biết, từ ngày 1/3, người dân khi có nhu cầu đổi, cấp lại giấy phép lái xe sẽ được thực hiện theo 2 cách gồm trực tiếp và trực tuyến.</p>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        
        <jsp:include page="footer.jsp"/>
    </body>
</html>