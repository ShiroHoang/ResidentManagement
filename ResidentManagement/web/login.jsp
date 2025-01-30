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
        <link rel="icon" href="images/icon.png" type="image/x-icon"/>
        <link rel="stylesheet" type="text/css" href="css/style.css">
        <script src="js/themes.js"></script>
    </head>
    <body>
        <section class="container">
            <div class="login-container">
                <div class="circle circle-one"></div>
                <div class="form-container">
                    <img src="https://raw.githubusercontent.com/hicodersofficial/glassmorphism-login-form/master/assets/illustration.png" alt="illustration" class="illustration" />
                    <h1 class="opacity">LOGIN</h1>
                    <form id="form" action="login" method="post">
                        <input type="text" placeholder="EMAIL" />
                        <input type="password" placeholder="PASSWORD" />
                        <button class="opacity" onclick="submitForm()" >SUBMIT</button>
                    </form>
                    <div class="register-forget opacity">
                        <a href="">REGISTER</a>
                        <a href="">FORGOT PASSWORD</a>
                    </div>
                </div>
                <div class="circle circle-two"></div>
            </div>
            <div class="theme-btn-container"></div>
        </section>
    </body>
</html>
