<%-- 
    Document   : resgisterAccount
    Created on : Feb 26, 2025, 3:55:16 PM
    Author     : AN515-57
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
                    <h1 class="opacity">ĐĂNG KÍ TÀI KHOẢN</h1>
                    <form action="RegisterAccount" method="post">
                        <input type="text" name="name" placeholder="Nhập họ và tên" required />
                        <input type="text" name="email" placeholder="Nhập email" required />
                        <input type="text" name="phone" placeholder="Nhập số điện thoại" required />                        
                        <input type="text" name="address" placeholder="Nhập địa chỉ hiện tại" required />

                        <table>
                            <tr>
                                <td>Chức vụ: </td>
                                <td>
                                    <select name = "role">
                                        <option value="Citizen">Công dân thường</option>
                                        <option value="AreaLeader">Tổ trưởng khu phố</option>
                                        <option value="Police">Công an</option>                            
                                    </select>
                                </td>
                            </tr>
                        </table>


                        <input type="password" name="newPass" placeholder="Nhập mật khẩu" required />
                        <input type="password" name="confirmPass" placeholder="Nhập lại mật khẩu" required />
                        <button class="opacity" type="submit">Đăng kí</button>
                    </form>
                    <h3 style="color:red">${requestScope.error}</h3>
                    <h3 style="color:green">${requestScope.success}</h3>
                    <div class="register-forget opacity">
                        <a href="home.html?">Quay lại</a>
                    </div>
                </div>
                <div class="circle circle-two"></div>
            </div>
            <div class="theme-btn-container"></div>
        </section>
    </body>
</html>