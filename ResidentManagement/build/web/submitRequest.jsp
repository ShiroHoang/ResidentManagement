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
                <form class="formSubmit" action="address" method="post">
                    <c:set var="account" value="${sessionScope.account}"/>
                    <input type="hidden" name="action" id="action" value="">
                    <table>
                        <tr>
                            <td>Loại đơn</td>
                            <td>
                                <select class="registerAddressType" name="requestType" id="requestType" onchange="toggleFields()">
                                    <option value="registerAddress">Đơn đề nghị đăng ký hộ khẩu</option>
                                    <option value="separateAddress">Đơn đề nghị tách hộ khẩu</option>
                                    <option value="moveAddress">Đơn đề nghị chuyển hộ khẩu</option>
                                </select>
                            </td>
                        </tr>
                        <tr class="typeStay hidden">
                            <td>Loại đăng ký hộ khẩu</td>
                            <td>
                                <select name="stay" id="">
                                    <option value="permanent">Thường trú</option>
                                    <option value="temporary">Tạm trú</option>
                                    <option value="temporary-stay">Lưu trú</option>
                                </select>
                            </td>                                
                        </tr>
                        <tr class="name">
                            <td>Họ và tên</td>
                            <td><input type="text" name="name" readonly value="${account.fullName}"></td>
                        </tr>
                        <tr class="email">
                            <td>Email</td>
                            <td><input name="email" readonly value="${account.email}"></td>
                        </tr>
                        <tr class="phone">
                            <td>Số điện thoại</td>
                            <td><input name="phone" readonly value="${account.phoneNumber}" ></td>
                        </tr>
                        <tr class="hidden new_address">
                            <td>Hộ khẩu đăng ký mới</td>
                            <td>
                                <div class="row">
                                    <div class="col-md-4 mb-2">
                                        <select id="province" name="province" class="form-select">
                                            <option value="">Tỉnh</option>
                                        </select>
                                    </div>
                                    <div class="col-md-4 mb-2">
                                        <select id="city" name="city" class="form-select">
                                            <option value="">Thành phố</option>
                                        </select>
                                    </div>
                                    <div class="col-md-4 mb-2">
                                        <select id="district" name="district" class="form-select">
                                            <option value="">Quận</option>
                                        </select>
                                    </div>
                                    <div class="col-md-4 mb-2">
                                        <select id="ward" name="ward" class="form-select">
                                            <option value="">Phường</option>
                                        </select>
                                    </div>
                                    <div class="col-md-4 mb-2">
                                        <select id="street" name="street" class="form-select">
                                            <option value="">Đường</option>
                                        </select>
                                    </div>
                                    <div class="col-md-4 mb-2">
                                        <input type="text" name="house" placeholder="Nhà">
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </table>
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
                                        let typeStay = document.querySelector(".typeStay");
                                        let new_address = document.querySelector(".new_address");

                                        // Hide all initiall
                                        typeStay.classList.add("hidden");
                                        new_address.classList.add("hidden");
                                        if (requestType === "registerAddress") {
                                            typeStay.classList.remove("hidden");
                                            new_address.classList.remove("hidden");
                                        } else if (requestType === "moveAddress") {
                                            typeStay.classList.add("hidden");
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

        </script>
    </body>
</html>
