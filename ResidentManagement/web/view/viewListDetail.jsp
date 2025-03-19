<%-- 
    Document   : viewRequest
    Created on : Feb 28, 2025, 5:03:04 PM
    Author     : huyng
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Registration"%>
<%@page import="model.User"%>
<%@page import="dal.AddressRegistryDAO"%>
<%@page import="dal.UserDAO"%>
<%@page import="dal.RegistrationDAO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

            

            .btn:hover {
                background-color: #0056b3;
            }

            .formSubmit{
                font-size: 1rem;
            }

            .backTo {
                font-size: 24px;
                font-weight: bold;
                text-decoration: none; /* Removes underline */
                color: gray; /* Change to preferred color */
            }
            .backTo:hover{
                color: darkgray; /* Hover effect */
            }
            .approve{
                font-size: 24px;
                font-weight: bold;
                text-decoration: none; /* Removes underline */
                color: green;
                border: 2px solid green; /* Add a visible border */
                padding: 8px 16px; /* Add spacing inside the border */
                border-radius: 5px;
                margin-top: 5px;
                float:right;
            }
            .approve:hover{
                color: greenyellow;
            }
            .comment:hover{
                color: greenyellow;
            }

            .comment{
                font-size: 24px;
                font-weight: bold;
                text-decoration: none; /* Removes underline */
                color: green;
                border: 2px solid green; /* Add a visible border */
                padding: 8px 16px; /* Add spacing inside the border */
                border-radius: 5px;
                margin-top: 5px;
                margin-left: 250px;
                float:right;
                width:50%;
            }
            .reject{
                font-size: 24px;
                font-weight: bold;
                text-decoration: none; /* Removes underline */
                color: tomato;
                border: 2px solid tomato; /* Add a visible border */
                padding: 8px 16px; /* Add spacing inside the border */
                border-radius: 5px;
                margin-top: 5px;
                float:right;
            }
            .reject:hover{
                color: #dd4b39;
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
                    height: 95vh;
                    padding: 50px 20px;
                }
                
                .approve, .backTo, .reject {
                    font-size: 18px;
                }
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <c:set var="request" value="${requestScope.registrations}"/>
        <div class="hero">
            <div class="form-container">
                <form action="RequestList" method="get">
                    <%
                        UserDAO udb = new UserDAO();
                        RegistrationDAO rdb = new RegistrationDAO();
                        AddressRegistryDAO adb = new AddressRegistryDAO();
                        Registration registration = (Registration) (request.getAttribute("registration"));
                        pageContext.setAttribute("registration", registration);
                        User user = (User) session.getAttribute("account");

                        int newAddressId = rdb.getNewAddressIdByRegistrationId(registration.getRegistrationId());
                        int oldAddressId = rdb.getOldAddressIdByRegistrationId(registration.getRegistrationId());
                        int headOfHouseholdId = rdb.getHeadOfHouseholdIdByRegistrationId(registration.getRegistrationId());
                    %>
                    <table border="1px">
                        <tr>
                            <td class="fs-5">Mã đơn: <%= registration.getRegistrationId()%></td>
                        </tr>
                        <tr>
                            <td class="fs-5">Người gửi đơn: <%= udb.getFullNameByUserId(registration.getUserId())%></td>
                        </tr>
                        <% if (registration.getRegistrationType().equals("permanent")) {%>
                        <tr>
                            <td class="fs-5">Loại hộ khẩu: Thường trú</td>
                        </tr>
                        <% } else if (registration.getRegistrationType().equals("temporary")) {%>
                        <tr>
                            <td class="fs-5">Loại hộ khẩu: Tạm trú</td>
                        </tr>
                        <% } else { %>
                        <tr>
                            <td class="fs-5">Loại hộ khẩu: Tạm lánh</td>
                        </tr>
                        <% } %>
                        <tr>
                            <td class="fs-5">Trạng thái: Đang chờ</td>
                        </tr>
                        <% if (rdb.getRequestTypeByRegistrationId(registration.getRegistrationId()).equals("registerAddress")) {%>
                        <tr>
                            <td class="fs-5">Loại đơn gửi: Đăng ký hộ khẩu</td>
                        </tr>
                        <tr>
                            <td class="fs-5">Địa chỉ đăng ký: <%= adb.getAddressById(newAddressId)%></td>
                        </tr>
                        <% } else if (rdb.getRequestTypeByRegistrationId(registration.getRegistrationId()).equals("separateAddress")) {%>
                        <tr>
                            <td class="fs-5">Loại đơn gửi: Tách hộ khẩu</td>
                        </tr>
                        <tr>
                            <td class="fs-5">Địa chỉ tách hộ khẩu: <%= adb.getAddressById(newAddressId)%></td>
                        </tr>
                        <% } else {%>
                        <tr>
                            <td class="fs-5">Loại đơn gửi: Chuyển hộ khẩu</td>
                        </tr>
                        <tr>
                            <td class="fs-5">Địa chỉ cũ: <%= adb.getAddressById(oldAddressId)%></td>
                        </tr>
                        <tr>
                            <td class="fs-5">Địa chỉ mới: <%= adb.getAddressById(newAddressId)%></td>
                        </tr>
                        <% } %>

                        <% if (rdb.getHeadOfHouseholdIdByRegistrationId(registration.getRegistrationId()) != -1
                                    && rdb.getRelationshipByRegistrationId(registration.getRegistrationId()) != null) {%>
                        <tr>
                            <td class="fs-5">Chủ hộ khẩu: <%= udb.getNameByOnlyUserId(headOfHouseholdId)%></td>
                        </tr>
                        <tr>
                            <td class="fs-5">Quan hệ với chủ hộ: <%= rdb.getRelationshipByRegistrationId(registration.getRegistrationId())%></td>
                        </tr>
                        <% }%>
                        <tr>
                            <td class="fs-5">Ngày gửi đơn: <%= registration.getStartDate()%></td>
                        </tr>
                    </table>
                    <span class="fs-5">Nhận xét: <%= registration.getComments()%></span>
                    <% session.setAttribute("approveBy", user.getUserId());%>
                    <c:if test="${sessionScope.account.role == 'Police'}">
                        <table>
                            <tr>
                                <td class="fs-5"><a class="backTo" href="RequestList?backTo=listApprove&requestType=<%= rdb.getRequestTypeByRegistrationId(registration.getRegistrationId())%>">Quay lại</a></td>
                                <td class="fs-5"><a class="approve" href="RequestProcess?action=approve&registrationId=<%= registration.getRegistrationId()%>&requestType=<%= rdb.getRequestTypeByRegistrationId(registration.getRegistrationId())%>">Đồng ý  </a></td>
                                <td class="fs-5"><a class="reject" href="RequestProcess?action=deny&registrationId=<%= registration.getRegistrationId()%>&requestType=<%= rdb.getRequestTypeByRegistrationId(registration.getRegistrationId())%>">  Từ chối</a></td>
                            </tr>
                        </table>
                    </c:if>
                </form>

                <c:if  test="${sessionScope.account.role == 'AreaLeader'}">
                    <form action="RequestComment" method="get">
                        <table>
                            <input type="hidden" name="registrationId" value=<%= registration.getRegistrationId()%>>                                         
                            <tr>
                                <td class="fs-5" style="min-width:200px">Nhận xét mới: </td>
                                <td class="fs-5"><input type="text" name="comment" size="50"
                                                        <c:if test="${sessionScope.account.role != 'AreaLeader'}">
                                                            readonly="true"
                                                        </c:if>
                                                        <c:if test="${sessionScope.account.role != 'AreaLeader'}">
                                                            readonly="false"
                                                        </c:if> ></td>
                            </tr>    
                            </tr>
                            <tr>
                                <td class="fs-5"><a class="backTo" href="RequestList?backTo=listApprove&requestType=<%= rdb.getRequestTypeByRegistrationId(registration.getRegistrationId())%>">Quay lại</a></td>
                                <td class="fs-5">
                                    <input class="comment fs-5" type="submit" value="Nhận xét">
                                </td>
                            </tr>
                        </table>
                    </form>
                </c:if>
            </div>
        </div>
        <div class="text-center fs-4" width="100px">
            ${requestScope.message}
        </div>
        <jsp:include page="footer.jsp"/>
    </body>
</html>

