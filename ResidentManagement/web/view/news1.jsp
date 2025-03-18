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
            <h2 class="news-title">Tạm dừng các hệ thống thuế điện tử đến 8 giờ sáng ngày 17/3</h2>
            <p class="news-date">13/03/2025</p>
            <p>
                Cục Thuế, Bộ Tài chính, vừa ban hành Thông báo số 41/TB-CT ngày 12/3/2024 về việc tạm dừng các hệ thống thuế điện 
                tử phục vụ việc nâng cấp đáp ứng tái cơ cấu, sắp xếp các cơ quan thuế.
            </p>
            <p>
                Theo đó, thực hiện kế hoạch, chủ trương của Quốc hội, Chính phủ về việc tái cơ cấu, sắp xếp bộ máy nhà nước, 
                ngày 26/02/2025, Bộ Tài chính đã ban hành Quyết định số 381/QĐ-BTC quy định chức năng, nhiệm vụ, quyền hạn và cơ cấu tổ chức của Cục Thuế, trong đó tổ chức sắp xếp và triển khai mô hình 20 Chi cục Thuế khu vực và 350 Đội Thuế cấp huyện thay cho 63 Cục Thuế và các Chi cục Thuế trực thuộc trước đây.
            </p>
            <p>
                Để triển khai mô hình mới, Cục Thuế thông báo việc tạm dừng một số các hệ thống thuế điện tử (Chi tiết tại 
                Thông báo số 41/TB-CT đính kèm) phục vụ nâng cấp và chuyển đổi các danh mục từ 17h00’ ngày 12/3/2025 đến 8h00’ 
                ngày 17/3/2025. Ngoài thời gian này, các hệ thống thuế hoạt động bình thường.
            </p>
            <p>
                Người nộp thuế tiếp tục thực hiện các thủ tục hành chính thuế (trừ nộp thuế điện tử) trên các kênh thuế điện tử, 
                tiếp nhận trực tiếp, bưu chính trong suốt quá trình nâng cấp và chuyển đổi. Tuy nhiên, việc giải quyết trả kết quả có thể chậm trễ nên cơ quan thuế rất xin lỗi và mong nhận được sự thông cảm của người nộp thuế.
            </p>
            <p class="news-highlight">
                * Trong quá trình thực hiện, nếu có vướng mắc người nộp thuế vui lòng liên hệ với các kênh hỗ trợ của Cục Thuế tại số điện thoại 
                <strong>024.37689679 (số máy lẻ 2180)</strong> hoặc địa chỉ thư điện tử 
                <strong>nhomhttdt@gdt.gov.vn</strong> hoặc các kênh hỗ trợ khác tại các cơ quan thuế.
            </p>
        </div>

        <jsp:include page="footer.jsp"/>
    </body>
</html>
