<%-- 
    Document   : test
    Created on : Feb 1, 2025, 3:09:09 PM
    Author     : huyng
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Home Page</title>
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


        </style>
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
                        <li class="nav-item align-items-center">
                            <a class="nav-link fs-5" href="#">Thông báo</a>
                        </li>
                        <li class="nav-item dropdown align-items-center">
                            <a class="nav-link dropdown-toggle fs-5" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                Đơn gửi
                            </a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="">Xem đơn đã gửi</a></li>
                                <li><a class="dropdown-item" href="nav?action=submitRequest">Gửi đơn mới</a></li>
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

        <div class="hero">
            <div>
                <h1 id="typing-text"></h1>
            </div>
        </div>

        <footer class="bg-dark text-white text-center p-3">
            <p>&copy; 2025 PRJ301. All Rights Reserved.</p>
        </footer>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
    <script>
        const text = "CHÀO MỪNG TỚI CỔNG THÔNG TIN ĐIỆN TỬ QUẢN LÝ DÂN CƯ";
        let index = 0;

        function typeEffect() {
            if (index < text.length) {
                document.getElementById("typing-text").innerHTML += text.charAt(index);
                index++;
                setTimeout(typeEffect, 100); // Adjust speed here
            }
        }

        window.onload = typeEffect;
    </script>
</html>
