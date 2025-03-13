<%-- 
    Document   : passwordReset
    Created on : Feb 25, 2025, 9:17:56 PM
    Author     : huyng
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quên Mật Khẩu</title>
        <link rel="icon" href="images/star.png" type="image/x-icon"/>
        <link rel="stylesheet" type="text/css" href="css/login.css">
        <script src="js/themes.js"></script>
        <style>
            .hero {
                height: 100vh;
                background: linear-gradient(rgba(144, 7, 13), rgba(0, 0, 0, 0.5)),
                    url('https://free.vector6.com/wp-content/uploads/2021/03/E269-vector-trong-dong.jpg');
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
                    <h1 class="opacity">QUÊN MẬT KHẨU</h1>
                    <form action="ResetPass" method="post">
                        <input type="text" name="name" placeholder="Nhập họ tên đã đăng ký" required />
                        <input type="text" name="email" placeholder="Nhập email đã đăng ký" required />
                        <input type="text" name="phone" placeholder="Nhập số điện thoại đã đăng ký" required />
                        <input type="password" name="newPass" placeholder="Nhập mật khẩu mới" required />
                        <input type="password" name="confirmPass" placeholder="Nhập lại mật khẩu mới" required />
                        <button class="opacity" type="submit">Thay đổi thông tin</button>
                    </form>
                    <h3 style="color:red">${requestScope.error}</h3>
                    <h3 style="color:green">${requestScope.success}</h3>
                    <div class="register-forget opacity">
                        <a href="login">Quay lại</a>
                    </div>
                </div>
                <div class="circle circle-two"></div>
            </div>
            <div class="theme-btn-container"></div>
        </section>
    </body>
</html>

