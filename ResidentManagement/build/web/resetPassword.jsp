<%-- 
    Document   : submitRequest
    Created on : Feb 16, 2025, 10:25:40 PM
    Author     : huyng
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Submit Request</title>
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
                display: flex;
                align-items: center;
                justify-content: center;
                text-align: center;
            }
            .navbar-nav .nav-link:hover {
                color: #ffcc00 !important;
                transform: scale(1.1);
            }
            .form-container {
                background: white;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                width: 700px;
                text-align: left;
                font-size: 1.5rem;
            }
            table {
                width: 100%;
            }
            td {
                padding: 8px 0;
            }
            select, input {
                width: 100%;
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 4px;
            }
            .hidden {
                display: none;
            }
            .btn {
                width: 20%;
                padding: 10px;
                border: none;
                background-color: #007bff;
                color: white;
                border-radius: 5px;
                cursor: pointer;
                margin-top: 10px;
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

            .btn:hover {
                background-color: #0056b3;
            }

            .formSubmit{
                font-size: 1rem;
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
                            <a class="nav-link fs-5" href="citizenMain.jsp">Trang chủ</a>
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
                                <li><a class="dropdown-item" href="submitRequest.jsp">Gửi đơn mới</a></li>
                            </ul>
                        </li>
                        <li class="nav-item dropdown align-items-center">
                            <a class="nav-link dropdown-toggle align-items-center" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="fa-solid fa-user-circle fa-1x me-2"></i> 
                                <span id="account">${sessionScope.account.fullName}</span>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end">
                                <li><a class="dropdown-item" href="citizenAccount.jsp">Hồ sơ</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item text-danger" href="logout">Đăng xuất</a></li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="hero">
            <div class="form-container">
                <form class="formSubmit" action="ResetPass" method="post">
                    <c:set var="account" value=""${sessionScope.account}/> </c:set
                    <table>
                        <h1 class="opacity">Đổi mật khẩu</h1>
                        <tr class="name">
                            <td>Họ và tên</td>
                            <td><input type="text" name="name" placeholder="Nguyen Van A"></td>
                        </tr>
                        <tr class="email">
                            <td>Email</td>
                            <td><input type="text" name="email"  placeholder="a@gmail.com"></td>
                        </tr>
                        <tr class="phone">
                            <td>Số điện thoại</td>
                            <td><input name="phone" placeholder="09123455678"></td>
                        </tr>
                        <tr class="hidden old_address">
                            <td>Mật khẩu mới:</td>
                            <td><input type="text" name="newPass"></td>
                        </tr>
                        <tr class="hidden new_address">
                            <td>Xác nhận lại mật khẩu: </td>
                            <td><input type="text" name="confirmPass"></td>
                        </tr>                        
                    </table>
                    <h3 style="color:red">${requestScope.error}</h3>
                    <h3 style="color:green">${requestScope.success}</h3>
                    <div class="text-center fs-4" width="100px">
                        <input class="btn fs-4" type="submit" value="Gửi đơn">
                    </div>  
                </form>
            </div>

        </div>

        <footer class="bg-dark text-white text-center p-3">
            <p>&copy; 2025 PRJ301. All Rights Reserved.</p>
        </footer>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            function toggleFields() {
                let requestType = document.getElementById("requestType").value;
                let old_address = document.querySelector(".old_address");
                let new_address = document.querySelector(".new_address");
                let typeStay = document.querySelector(".typeStay");

                // Hide all initially
                old_address.classList.add("hidden");
                new_address.classList.add("hidden");
                typeStay.classList.add("hidden");

                if (requestType === "registerAddress") {
                    typeStay.classList.remove("hidden");
                } else if (requestType === "moveAddress") {
                    old_address.classList.remove("hidden");
                    new_address.classList.remove("hidden");
                }

                console.log("Request Type:", requestType);
                console.log("Old Address:", old_address);
                console.log("New Address:", new_address);
                console.log("Type Stay:", typeStay);
            }

            document.addEventListener("DOMContentLoaded", function () {
                toggleFields(); // Ensure the function runs when the page loads
                document.getElementById("requestType").addEventListener("change", toggleFields);
            });
        </script>
    </body>
</html>
