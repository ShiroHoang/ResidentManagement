<%-- 
    Document   : news
    Created on : Mar 18, 2025, 4:11:31 PM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
            .dan {
                max-width: 800px;
                margin: auto;
                font-family: Arial, sans-serif;
                line-height: 1.6;
                color: #333;
            }

            .news-title {
                font-size: 24px;
                font-weight: bold;
                color: #164b7d;
                margin-bottom: 5px;
            }

            .news-date {
                font-size: 14px;
                color: gray;
                margin-bottom: 15px;
            }
            .news-highlight {
                background-color: #d4f8c4;
                padding: 10px;
                border-left: 4px solid #4CAF50;
                font-weight: bold;
            }

        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <div class="dan">
            <h2 class="news-title">Hướng dẫn khắc phục lỗi khi đăng ký tài khoản trên Cổng Dịch vụ công quốc gia</h2>
            <p class="news-date">29/07/2022</p>
            <p>
                Công dân, doanh nghiệp có thể đăng ký bằng sim ký số hoặc USB ký số; công dân có thể đăng ký bằng số thuê bao di động hoặc mã bảo hiểm xã hội (BHXH).
            </p>
            <p>
                Trong quá trình đăng ký tài khoản Cổng Dịch vụ công quốc gia, người dùng thường gặp vấn đề khi đăng ký không thành công là do thông tin (số CMND, họ tên) đăng ký tài khoản trên Cổng dịch vụ công không khớp với thông tin của thuê bao số điện thoại.
            </p>
            <p>
                Trong trường hợp này, người dùng cần thực hiện các bước sau:
            </p>
            <p>
                Kiểm tra thông tin của thuê bao điện thoại:
            </p>
            <p>
                + Đối với mạng Viettel, Vinaphone, MobiFone, Vietnamobile: Sử dụng chức năng tin nhắn của điện thoại, nhập “TTTB” gửi đến số “1414”.
            </p>
            <p>
                + Đối với mạng viễn thông Gmobile (Beeline): gửi tin nhắn “TT” đến số 1414.
            </p>
            <p>
                Trường hợp do lỗi hệ thống nên tin nhắn của bạn không được phản hồi, bạn cần liên hệ đến số điện thoại của các nhà mạng viễn thông hoặc đến trực tiếp các chi nhánh của nhà mạng để nhờ nhân viên hỗ trợ tra cứu thông tin.
            </p>
            <p>
                Sau khi có kết quả kiểm tra thông tin thuê bao điện thoại, bạn so sánh với thông tin bạn sử dụng để đăng ký tài khoản Cổng dịch vụ công đã trùng khớp chưa.
            </p>
            <p>
                Nếu thông tin thuê bao điện thoại không chính xác, bạn cần ra cửa hàng của nhà mạng di động để nhân viên hỗ trợ chỉnh sửa thông tin người sử dụng số điện thoại cho chính xác.
            </p>
            <p>
                Sau khi hoàn thành các bước trên, bạn đã có thể thực hiện đăng ký tài khoản Cổng Dịch vụ công như bình thường
            </p>
            
        </div>

        <jsp:include page="footer.jsp"/>
    </body>
</html>
