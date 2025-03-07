<%-- 
    Document   : accountList
    Created on : Mar 5, 2025, 9:28:11 PM
    Author     : AN515-57
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "java.util.ArrayList" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
            table {
                margin: auto;
            }
            td {
                padding: 10px;
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <form action="PoliceUpdateAccount" method="POST">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="userId" value="${user.userId}">

            <table>
                <tr>
                    <td>Họ và tên: </td>
                    <td><input type="text" name="fullName"
                               value="<c:out value="${user.fullName}"></c:out>"></td>
                    </tr>

                    <tr>
                        <td>Địa chỉ: </td>
                        <td><input type="text" name="address"
                                   value="<c:out value="${user.address}"></c:out>"></td>
                    </tr>
                    <tr>
                        <td>Phone: </td>
                        <td><input type="text" name="phoneNum"
                                   value="<c:out value="${user.phoneNumber}"></c:out>" ></td>
                    </tr>
                    <tr>
                        <td>Role: </td>
                        <td>
                            <select name="roleId">
                                <option value="Citizen">Dân thường</option>
                                <option value="Police">Công An</option>
                                <option value="AreaLeader">Tổ trưởng khu phố</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td><input type="submit" value="Thay đổi"></td>
                    </tr>
                </table>
            </form> 
            <h3>${message}</h3>
        <jsp:include page="footer.jsp"/>
    </body>
</html>