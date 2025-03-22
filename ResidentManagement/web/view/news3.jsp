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
            <h2 class="news-title">Cung cấp dịch vụ công "Giải quyết hưởng trợ cấp thất nghiệp" trên Cổng Dịch vụ công quốc gia</h2>
            <p class="news-date">22/04/2022</p>
            <p>
                Triển khai nội dung Nghị quyết số 107/NQ-CP ngày 11 tháng 9 năm 2021 của Chính phủ và Quyết định số 06/QĐ-TTg ngày 06 tháng 01 năm 2022 của Thủ tướng Chính phủ, Văn phòng Chính phủ đã phối hợp với Bộ Lao động - Thương binh và Xã hội, Bảo hiểm xã hội Việt Nam hoàn thiện quy trình nghiệp vụ, cung cấp trên Cổng Dịch vụ công quốc gia dịch vụ công Giải quyết hưởng trợ cấp thất nghiệp từ ngày 12 tháng 4 năm 2022 tại địa chỉ:
            </p>
            <p>
                https://dichvucong.gov.vn/p/home/dvc-chi-tiet-thu-tuc-nganh-doc.html?ma_thu_tuc=1.001978
            </p>
            <p>
                Theo quy định tại Nghị quyết 107/NQ-CP của Chính phủ, người lao động có thể nộp bản chụp một trong các giấy tờ theo quy định tại Khoản 6 Điều 1 Nghị định số 61/2015/NĐ-CP sửa đổi, bổ sung một số điều của Nghị định số 28/2015/NĐ-CP của Chính phủ.
            </p>
            <p>
                Mọi khó khăn, vướng mắc trong quá trình thực hiện dịch vụ công đề nghị liên hệ với Tổng đài hỗ trợ: 18001096
            </p>
        </div>

        <jsp:include page="footer.jsp"/>
    </body>
</html>
