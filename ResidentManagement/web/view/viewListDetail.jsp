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
                margin-left: 250px;
                float:right;
            }
            .approve:hover{
                color: greenyellow;
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
                    User user = (User) session.getAttribute("account");

                    int newAddressId = rdb.getNewAddressIdByRegistrationId(registration.getRegistrationId());
                    int oldAddressId = rdb.getOldAddressIdByRegistrationId(registration.getRegistrationId());
                    int headOfHouseholdId = rdb.getHeadOfHouseholdIdByRegistrationId(registration.getRegistrationId());

                %>
                <table border="1px">
                    <tr>
                        <td>Mã đơn: <%= registration.getRegistrationId()%></td>
                    </tr>
                    <tr>
                        <td>Người gửi đơn: <%= udb.getFullNameByUserId(registration.getUserId())%></td>
                    </tr>
                    <% if (registration.getRegistrationType().equals("permanent")) {%>
                    <tr>
                        <td>Loại hộ khẩu: Thường trú</td>
                    </tr>
                    <% } else if (registration.getRegistrationType().equals("temporary")) {%>
                    <tr>
                        <td>Loại hộ khẩu: Tạm trú</td>
                    </tr>
                    <% } else { %>
                    <tr>
                        <td>Loại hộ khẩu: Tạm lánh</td>
                    </tr>
                    <% } %>
                    <tr>
                        <td>Trạng thái: Đang chờ</td>
                    </tr>
                    <% if (rdb.getRequestTypeByRegistrationId(registration.getRegistrationId()).equals("registerAddress")) {%>
                    <tr>
                        <td>Loại đơn gửi: Chuyển hộ khẩu</td>
                    </tr>
                    <tr>
                        <td>Địa chỉ đăng ký: <%= adb.getAddressById(newAddressId)%></td>
                    </tr>
                    <% } else if (rdb.getRequestTypeByRegistrationId(registration.getRegistrationId()).equals("separateAddress")) {%>
                    <tr>
                        <td>Loại đơn gửi: Tách hộ khẩu</td>
                    </tr>
                    <tr>
                        <td>Địa chỉ tách hộ khẩu: <%= adb.getAddressById(newAddressId)%></td>
                    </tr>
                    <% } else {%>
                    <tr>
                        <td>Loại đơn gửi: Chuyển hộ khẩu</td>
                    </tr>
                    <tr>
                        <td>Địa chỉ cũ: <%= adb.getAddressById(oldAddressId)%></td>
                    </tr>
                    <tr>
                        <td>Địa chỉ mới: <%= adb.getAddressById(newAddressId)%></td>
                    </tr>
                    <% } %>

                    <% if (rdb.getHeadOfHouseholdIdByRegistrationId(registration.getRegistrationId()) != -1
                                && rdb.getRelationshipByRegistrationId(registration.getRegistrationId()) != null) {%>
                    <tr>
                        <td>Chủ hộ khẩu: <%= udb.getNameByOnlyUserId(headOfHouseholdId)%></td>
                    </tr>
                    <tr>
                        <td>Quan hệ với chủ hộ: <%= rdb.getRelationshipByRegistrationId(registration.getRegistrationId())%></td>
                    </tr>
                    <% }%>
                    <tr>
                        <td>Ngày gửi đơn: <%= registration.getStartDate()%></td>
                    </tr>
                </table>

                <% session.setAttribute("approveBy", user.getUserId()); %>
                <table>
                    <tr>
                        <td><a class="backTo" href="RequestList?backTo=listApprove&requestType=<%= rdb.getRequestTypeByRegistrationId(registration.getRegistrationId())%>">Quay lại</a></td>
                        <td><a class="approve" href="RequestProcess?action=approve&registrationId=<%= registration.getRegistrationId()%>&requestType=<%= rdb.getRequestTypeByRegistrationId(registration.getRegistrationId())%>">Đồng ý  </a></td>
                        <td><a class="reject" href="RequestProcess?action=deny&registrationId=<%= registration.getRegistrationId()%>&requestType=<%= rdb.getRequestTypeByRegistrationId(registration.getRegistrationId())%>">  Từ chối</a></td>

                    </tr>
                </table>
            </form>

            <div class="text-center fs-4" width="100px">
                ${requestScope.message}
            </div>
        </div>

    </div>

    <jsp:include page="footer.jsp"/>


    <script>

        function toggleFields() {
            let requestType = document.getElementById("requestType").value;
            let typeStay = document.querySelector(".typeStay");
            let new_address = document.querySelector(".newAddress");
            let old_address = document.querySelector(".oldAddress");
            let moved_address = document.querySelector(".movedAddress");
            let permanentAddress = document.querySelector(".permanentAddress");
            let permanentSeparateAddress = document.querySelector(".permanentSeparateAddress");

            // Hide all initiall
            typeStay.classList.add("hidden");
            new_address.classList.add("hidden");
            old_address.classList.add("hidden");
            moved_address.classList.add("hidden");
            permanentAddress.classList.add("hidden");
            permanentSeparateAddress.classList.add("hidden");
            if (requestType === "registerAddress") {
                typeStay.classList.remove("hidden");
                new_address.classList.remove("hidden");
            } else if (requestType === "moveAddress") {
                typeStay.classList.add("hidden");
                new_address.classList.add("hidden");
                old_address.classList.remove("hidden");
                moved_address.classList.remove("hidden");
                permanentAddress.classList.remove("hidden");
            } else {
                typeStay.classList.add("hidden");
                new_address.classList.add("hidden");
                old_address.classList.add("hidden");
                moved_address.classList.add("hidden");
                permanentAddress.classList.add("hidden");
                permanentSeparateAddress.classList.remove("hidden");
            }
        }

        document.addEventListener("DOMContentLoaded", function () {
            toggleFields(); // Ensure the function runs when the page loads
            document.getElementById("requestType").addEventListener("change", toggleFields);
        });

        function syncSelectToHidden(selectId, hiddenId) {
            const selectElement = document.getElementById(selectId);
            const hiddenInput = document.getElementById(hiddenId); // Corrected variable name

            function updateHidden() {
                hiddenInput.value = selectElement.value; // Properly updates hidden input
            }

            // Set initial value when the page loads
            updateHidden();

            // Add event listener to update on change
            selectElement.addEventListener('change', updateHidden);
        }

        // Call function correctly after the DOM is loaded
        document.addEventListener("DOMContentLoaded", function () {
            syncSelectToHidden('requestType', 'action'); // This should now work
        })

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

