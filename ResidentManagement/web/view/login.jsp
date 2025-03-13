<%-- 
    Document   : login.jsp
    Created on : Jan 26, 2025, 10:15:05 PM
    Author     : huyng
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>QLDC</title>
        <link rel="icon" href="images/star.png" type="image/x-icon"/>
        <link rel="stylesheet" type="text/css" href="css/login.css">
        <script src="js/themes.js"></script>
        <style>
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
        </style>
    </head>
    <body>
        <section class="container hero">
            <div class="login-container">
                <div class="circle circle-one"></div>
                <div class="form-container">
                    <h1 class="opacity">LOGIN</h1>
                    <form id="form" action="login" method="post">
                        <input type="hidden" name="action" value="login">
                        <input type="text" id="email" name="email" placeholder="EMAIL" />
                        <input type="password" id="password" name="password" placeholder="MẬT KHẨU" />
                        <button class="opacity" onclick="submitForm()" id="loginButton" >ĐĂNG NHẬP</button>
                    </form>
                    <h3 style="color:red">${requestScope.error}</h3>
                    <div class="opacity ">
                        <a href="nav?action=passwordReset">QUÊN MẬT KHẨU</a>
                    </div>
                </div>
                <div class="circle circle-two"></div>
            </div>
            <div class="theme-btn-container"></div>
        </section>
    </body>
</html>
