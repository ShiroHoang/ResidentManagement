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
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"> 
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
        <style>
            .hero {
                height: 135vh;
                background: linear-gradient(rgba(144, 7, 13), rgba(0, 0, 0, 0.5)),
                    url('https://free.vector6.com/wp-content/uploads/2021/03/E269-vector-trong-dong.jpg');
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
        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg custom-navbar"> 
            <!--            used for responsive when using smaller screen-->
            <div class="container">
                <a class="navbar-brand col-lg-5" href="home.html">
                    <img src="images/logo/logo.png" width="100%" alt="logo"/>
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

        <section class="container-log hero">
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

        <footer class="bg-dark text-white text-center p-3">
            <p>&copy; 2025 PRJ301. All Rights Reserved.</p>
        </footer>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>