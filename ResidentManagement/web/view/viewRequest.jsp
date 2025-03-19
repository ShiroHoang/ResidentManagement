<%-- 
    Document   : viewRequest
    Created on : Feb 28, 2025, 5:03:04 PM
    Author     : huyng
--%>
<%@page import="dal.RegistrationDAO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>View Request</title>
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
                    height: 80vh;
                    padding: 50px 20px;
                }
                
                .container {
                    min-width: 100vw;
                }
                
                .col-2 {
                    width: auto;
                }
            }

            .btn:hover {
                background-color: #0056b3;
            }

            .formSubmit{
                font-size: 1rem;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }

            th, td {
                padding: 12px;
                border: 1px solid #ddd;
                text-align: left;
                vertical-align: middle;
            }

            th {
                background-color: #007bff;
                color: white;
                font-size: 16px;
            }

            tr {
                background-color: #f9f9f9;
            }

            tr:hover {
                background-color: #e3f2fd;
            }

            input {
                width: 100%;
                border: none;
                background: transparent;
                text-align: center;
            }

            /* Optional: Make table responsive */
            @media (max-width: 768px) {
                table {
                    font-size: 14px;
                }
                th, td {
                    padding: 8px;
                }
                
                .hidden-phone {
                    display: none;
                }
                
            }

            .pagination a {
                margin-right: 10px; /* Adds space between page numbers */
                padding: 5px 10px;   /* Adds padding inside the links */
                text-decoration: none; /* Removes underline */
                border: 1px solid #ccc; /* Optional: Adds border */
                border-radius: 5px; /* Optional: Rounded corners */
                display: inline-block; /* Ensures spacing works */
                background-color: white;
                color: black;
            }
            .pagination a:hover {
                background-color: #ddd; /* Optional: Hover effect */
            }

            .pagination button:disabled {
                background-color: #cccccc;
                cursor: not-allowed;
            }

            #pageNumber{
                background-color: white;
                width: 30px;
            }
            .data-row{
                text-align: left;
            }
            .table-header{
                background: white;
            }

            .card-header{
                color: white;
            }
            
            td {
                white-space: normal;
                word-wrap: break-word; 
            }

        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <c:set var="registrations" value="${requestScope.registrations}"/>
        <div class="hero">
            <div class="container">
                <form class="formSubmit" action="registration" method="post">
                    <c:set var="account" value="${sessionScope.account}"/>
                    <input type="hidden" name="action" id="action" value="">
                    <div class="card-header text-center fw-bold fs-3">
                        Thông tin xử lý đơn từ 
                    </div>
                    <table class="" id="dataTable">
                        <thead>
                            <tr>
                                <th class="fs-6">Loại đơn</th>
                                <th class="fs-6 hidden-phone">Loại hộ khẩu</th>
                                <th class="fs-6 ">Ngày tạo</th>
                                <th class="fs-6 hidden-phone">Chủ hộ khẩu</th>
                                <th class="fs-6 hidden-phone">Mối quan hệ với chủ hộ khẩu</th>
                                <th class="fs-6 hidden-phone">Ghi chú</th>
                                <th class="fs-6">Trạng thái</th>
                                <th class="fs-6 hidden-phone">Ngày trả lời</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:set var="rdb" value="${requestScope.rdb}" />
                            <c:forEach var="registration" items="${registrations}">
                                <tr class="name">
                                    <td class="data-row col-2">
                                        <c:if test="${rdb.getRequestTypeByRegistrationId(registration.registrationId) == 'registerAddress'}">
                                            <input class="data-row" type="text" name="requestType" readonly value="Đăng ký hộ khẩu">
                                        </c:if>
                                        <c:if test="${rdb.getRequestTypeByRegistrationId(registration.registrationId) == 'moveAddress'}">
                                            <input class="data-row" type="text" name="requestType" readonly value="Chuyển hộ khẩu">
                                        </c:if>
                                        <c:if test="${rdb.getRequestTypeByRegistrationId(registration.registrationId) == 'separateAddress'}">
                                            <input class="data-row" type="text" name="requestType" readonly value="Tách hộ khẩu">
                                        </c:if>
                                    </td>
                                    <td class="hidden-phone">
                                        <c:if test="${registration.registrationType == 'permanent'}">
                                            <input class="data-row" type="text" name="registrationType" readonly value="Thường trú">
                                        </c:if>
                                        <c:if test="${registration.registrationType == 'temporary'}">
                                            <input class="data-row" type="text" name="registrationType" readonly value="Tạm trú">
                                        </c:if>
                                        <c:if test="${registration.registrationType == 'temporaryStay'}">
                                            <input class="data-row" type="text" name="registrationType" readonly value="Lưu trú">
                                        </c:if>
                                    </td>
                                    <td>
                                        <input class="data-row" type="text" name="startDate" readonly value="${registration.startDate}">
                                    </td>
                                    <td class="hidden-phone">
                                        <c:if test="${!registration.headOfHouseholdName.isEmpty()}">
                                            <input class="data-row" type="text" name="headOfHousehold" readonly value="${registration.headOfHouseholdName}">
                                        </c:if>
                                        <c:if test="${registration.headOfHouseholdName.isEmpty()}">
                                            <input class="data-row" type="text" name="headOfHousehold" readonly value="Không có">
                                        </c:if>
                                    </td>
                                    <td class="hidden-phone">
                                        <c:if test="${registration.relationship != null}">
                                            <input class="data-row" type="text" name="relationship" readonly value="${registration.relationship}">
                                        </c:if>
                                        <c:if test="${registration.relationship == null}">
                                            <input class="data-row" type="text" name="relationship" readonly value="Không có">
                                        </c:if>
                                    </td>
                                    <td class="hidden-phone">
                                        <input class="data-row" type="text" name="comment" readonly value="${registration.comments}">
                                    </td>
                                    <td>
                                        <input class="data-row" type="text" name="status" readonly value="${registration.status}">
                                    </td>
                                    <td class="hidden-phone">
                                        <input class="data-row" type="text" name="endDate" readonly value="${registration.endDate}">
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </form>
                            <br/>
                <c:set var="page" value="${requestScope.page}"/>
                <div class="pagination">
                    <c:forEach begin="${1}" end="${requestScope.pagenum}" var="i">
                        <a href="registration?page=${i}">${i}</a>
                    </c:forEach>
                </div>
            </div>
        </div>

        <jsp:include page="footer.jsp"/>

        <script>
            const rowsPerPage = 5;
            let currentPage = 1;
            const table = document.getElementById("dataTable");
            const tbody = table.getElementsByTagName("tbody")[0];
            const rows = Array.from(tbody.getElementsByTagName("tr"));
            const totalPages = Math.ceil(rows.length / rowsPerPage);
            const pageNumberSpan = document.getElementById("pageNumber");

            function showPage(page) {
                // Hide all rows
                rows.forEach(row => (row.style.display = "none"));

                // Calculate start and end index
                const start = (page - 1) * rowsPerPage;
                const end = start + rowsPerPage;

                // Show only the rows for the current page
                rows.slice(start, end).forEach(row => (row.style.display = "table-row"));

                // Update buttons
                document.getElementById("prevPage").disabled = page === 1;
                document.getElementById("nextPage").disabled = page === totalPages;

                // Update page number
                pageNumberSpan.textContent = page;
            }

            // Event listeners for pagination buttons
            document.getElementById("prevPage").addEventListener("click", function () {
                if (currentPage > 1) {
                    currentPage--;
                    showPage(currentPage);
                }
            });

            document.getElementById("nextPage").addEventListener("click", function () {
                if (currentPage < totalPages) {
                    currentPage++;
                    showPage(currentPage);
                }
            });

            // Initialize table
            showPage(currentPage);
        </script>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                // Fetch initial data when page loads
                fetchAddresses();

                // Add event listeners for each dropdown
                document.getElementById('province').addEventListener('change', filterCities);
                document.getElementById('city').addEventListener('change', filterDistricts);
                document.getElementById('district').addEventListener('change', filterWards);
                document.getElementById('ward').addEventListener('change', filterStreets);
                document.getElementById('street').addEventListener('change', filterHouses);
            });

            let allAddresses = []; // Store all address data globally

            function fetchAddresses() {
                fetch('address') // Replace with your actual servlet path
                        .then(response => response.json())
                        .then(data => {
                            allAddresses = data;
                            populateProvinces();
                        })
                        .catch(error => console.error('Error fetching addresses:', error));
            }

            function populateProvinces() {
                const provinceSelect = document.getElementById('province');
                // Get unique provinces
                const provinces = [...new Set(allAddresses.map(item => item.province))];

                provinces.forEach(province => {
                    const option = document.createElement('option');
                    option.value = province;
                    option.textContent = province;
                    provinceSelect.appendChild(option);
                });
            }

            function filterCities() {
                const provinceSelect = document.getElementById('province');
                const citySelect = document.getElementById('city');
                const selectedProvince = provinceSelect.value;

                // Clear previous options
                citySelect.innerHTML = '<option value="">Thành phố</option>';
                document.getElementById('district').innerHTML = '<option value="">Quận</option>';
                document.getElementById('ward').innerHTML = '<option value="">Phường</option>';
                document.getElementById('street').innerHTML = '<option value="">Đường</option>';

                if (selectedProvince) {
                    const cities = [...new Set(allAddresses
                                .filter(addr => addr.province === selectedProvince)
                                .map(addr => addr.city))];

                    cities.forEach(city => {
                        const option = document.createElement('option');
                        option.value = city;
                        option.textContent = city;
                        citySelect.appendChild(option);
                    });
                }
            }

            function filterDistricts() {
                const provinceSelect = document.getElementById('province');
                const citySelect = document.getElementById('city');
                const districtSelect = document.getElementById('district');
                const selectedProvince = provinceSelect.value;
                const selectedCity = citySelect.value;

                // Clear previous options
                districtSelect.innerHTML = '<option value="">Quận</option>';
                document.getElementById('ward').innerHTML = '<option value="">Phường</option>';
                document.getElementById('street').innerHTML = '<option value="">Đường</option>';

                if (selectedCity) {
                    const districts = [...new Set(allAddresses
                                .filter(addr => addr.province === selectedProvince && addr.city === selectedCity)
                                .map(addr => addr.district))];

                    districts.forEach(district => {
                        const option = document.createElement('option');
                        option.value = district;
                        option.textContent = district;
                        districtSelect.appendChild(option);
                    });
                }
            }

            function filterWards() {
                const provinceSelect = document.getElementById('province');
                const citySelect = document.getElementById('city');
                const districtSelect = document.getElementById('district');
                const wardSelect = document.getElementById('ward');
                const selectedProvince = provinceSelect.value;
                const selectedCity = citySelect.value;
                const selectedDistrict = districtSelect.value;

                // Clear previous options
                wardSelect.innerHTML = '<option value="">Phường</option>';
                document.getElementById('street').innerHTML = '<option value="">Đường</option>';

                if (selectedDistrict) {
                    const wards = [...new Set(allAddresses
                                .filter(addr => addr.province === selectedProvince &&
                                            addr.city === selectedCity &&
                                            addr.district === selectedDistrict)
                                .map(addr => addr.ward))];

                    wards.forEach(ward => {
                        const option = document.createElement('option');
                        option.value = ward;
                        option.textContent = ward;
                        wardSelect.appendChild(option);
                    });
                }
            }

            function filterStreets() {
                const provinceSelect = document.getElementById('province');
                const citySelect = document.getElementById('city');
                const districtSelect = document.getElementById('district');
                const wardSelect = document.getElementById('ward');
                const streetSelect = document.getElementById('street');
                const selectedProvince = provinceSelect.value;
                const selectedCity = citySelect.value;
                const selectedDistrict = districtSelect.value;
                const selectedWard = wardSelect.value;

                // Clear previous options
                streetSelect.innerHTML = '<option value="">Đường</option>';

                if (selectedWard) {
                    const streets = [...new Set(allAddresses
                                .filter(addr => addr.province === selectedProvince &&
                                            addr.city === selectedCity &&
                                            addr.district === selectedDistrict &&
                                            addr.ward === selectedWard)
                                .map(addr => addr.street))];

                    streets.forEach(street => {
                        const option = document.createElement('option');
                        option.value = street;
                        option.textContent = street;
                        streetSelect.appendChild(option);
                    });
                }
            }

            function filterHouses() {
                const provinceSelect = document.getElementById('province');
                const citySelect = document.getElementById('city');
                const districtSelect = document.getElementById('district');
                const wardSelect = document.getElementById('ward');
                const streetSelect = document.getElementById('street');
                const houseSelect = document.getElementById('house');
                const selectedProvince = provinceSelect.value;
                const selectedCity = citySelect.value;
                const selectedDistrict = districtSelect.value;
                const selectedWard = wardSelect.value;
                const selectedStreet = streetSelect.value;

                // Clear previous options
                houseSelect.innerHTML = '<option value="">Nhà</option>';

                if (selectedStreet) {
                    const houses = [...new Set(allAddresses
                                .filter(addr => addr.province === selectedProvince &&
                                            addr.city === selectedCity &&
                                            addr.district === selectedDistrict &&
                                            addr.ward === selectedWard && addr.street === selectedStreet)
                                .map(addr => addr.house))];

                    houses.forEach(house => {
                        const option = document.createElement('option');
                        option.value = house;
                        option.textContent = house;
                        houseSelect.appendChild(option);
                    });
                }
            }

        </script>
    </body>
</html>

