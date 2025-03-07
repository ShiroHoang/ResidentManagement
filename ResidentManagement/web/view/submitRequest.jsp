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
        <jsp:include page="header.jsp"/>

        <div class="hero">
            <div class="form-container">
                <form class="formSubmit" action="registration" method="post">
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
                        <tr class="permanentSeparateAddress hidden">
                            <td>Loại đăng ký hộ khẩu</td>
                            <td><input type="text" name="name" readonly value="Thường trú"><i style="color:red">*Theo quy định nhà nước, tách hộ khẩu chỉ tách hộ trong cùng một địa chỉ</i></td>
                        </tr>
                        <tr class="permanentAddress hidden">
                            <td>Loại đăng ký hộ khẩu</td>
                            <td><input type="text" name="name" readonly value="Thường trú"><i style="color:red">*Theo quy định nhà nước, chuyển hộ khẩu chỉ áp dụng cho thường trú</i></td>
                        </tr>
                        <tr class="typeStay hidden">
                            <td>Loại đăng ký hộ khẩu</td>
                            <td>
                                <!--                                retrieve this-->
                                <select name="stay" id="">
                                    <option value="permanent">Thường trú</option>
                                    <option value="temporary">Tạm trú</option>
                                    <option value="temporaryStay">Lưu trú</option>
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
                        <tr class="headOfHousehold">
                            <td>Chủ hộ khẩu (nếu có)</td>
                            <td><input name="headOfHousehold" type="text" ></td>
                        </tr>
                        <tr class="relationship">
                            <td>Mối quan hệ với chủ hộ khẩu</td>
                            <td><input name="relationship" type="text" ></td>
                        </tr>

                        <tr class="hidden newAddress">
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
                                        <select id="house" name="house" class="form-select">
                                            <option value="">Số nhà</option>
                                        </select>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr class="hidden oldAddress">
                            <td>Hộ khẩu cũ</td>
                            <td>
                                <div class="row">
                                    <div class="col-md-4 mb-2">
                                        <select id="provinceOld" name="provinceOld" class="form-select">
                                            <option value="">Tỉnh</option>
                                        </select>
                                    </div>
                                    <div class="col-md-4 mb-2">
                                        <select id="cityOld" name="cityOld" class="form-select">
                                            <option value="">Thành phố</option>
                                        </select>
                                    </div>
                                    <div class="col-md-4 mb-2">
                                        <select id="districtOld" name="districtOld" class="form-select">
                                            <option value="">Quận</option>
                                        </select>
                                    </div>
                                    <div class="col-md-4 mb-2">
                                        <select id="wardOld" name="wardOld" class="form-select">
                                            <option value="">Phường</option>
                                        </select>
                                    </div>
                                    <div class="col-md-4 mb-2">
                                        <select id="streetOld" name="streetOld" class="form-select">
                                            <option value="">Đường</option>
                                        </select>
                                    </div>
                                    <div class="col-md-4 mb-2">
                                        <select id="houseOld" name="houseOld" class="form-select">
                                            <option value="">Số nhà</option>
                                        </select>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr class="hidden movedAddress">
                            <td>Hộ khẩu đăng ký di chuyển</td>
                            <td>
                                <div class="row">
                                    <div class="col-md-4 mb-2">
                                        <select id="provinceMoved" name="provinceMoved" class="form-select">
                                            <option value="">Tỉnh</option>
                                        </select>
                                    </div>
                                    <div class="col-md-4 mb-2">
                                        <select id="cityMoved" name="cityMoved" class="form-select">
                                            <option value="">Thành phố</option>
                                        </select>
                                    </div>
                                    <div class="col-md-4 mb-2">
                                        <select id="districtMoved" name="districtMoved" class="form-select">
                                            <option value="">Quận</option>
                                        </select>
                                    </div>
                                    <div class="col-md-4 mb-2">
                                        <select id="wardMoved" name="wardMoved" class="form-select">
                                            <option value="">Phường</option>
                                        </select>
                                    </div>
                                    <div class="col-md-4 mb-2">
                                        <select id="streetMoved" name="streetMoved" class="form-select">
                                            <option value="">Đường</option>
                                        </select>
                                    </div>
                                    <div class="col-md-4 mb-2">
                                        <select id="houseMoved" name="houseMoved" class="form-select">
                                            <option value="">Số nhà</option>
                                        </select>
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </table>
                    <div class="text-center fs-4" width="100px">
                        <input class="btn fs-4" type="submit" value="Gửi đơn">
                    </div>  
                    <div class="text-center fs-4" width="100px">
                        ${requestScope.message}
                    </div>  
                </form>
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
                document.getElementById('provinceOld').addEventListener('change', filterCitiesOld);
                document.getElementById('cityOld').addEventListener('change', filterDistrictsOld);
                document.getElementById('districtOld').addEventListener('change', filterWardsOld);
                document.getElementById('wardOld').addEventListener('change', filterStreetsOld);
                document.getElementById('streetOld').addEventListener('change', filterHousesOld);
                document.getElementById('provinceMoved').addEventListener('change', filterCitiesMoved);
                document.getElementById('cityMoved').addEventListener('change', filterDistrictsMoved);
                document.getElementById('districtMoved').addEventListener('change', filterWardsMoved);
                document.getElementById('wardMoved').addEventListener('change', filterStreetsMoved);
                document.getElementById('streetMoved').addEventListener('change', filterHousesMoved);
            });

            let allAddresses = []; // Store all address data globally

            function fetchAddresses() {
                fetch('address') // Replace with your actual servlet path
                        .then(response => response.json())
                        .then(data => {
                            allAddresses = data;
                            populateProvinces();
                            populateProvincesOld();
                            populateProvincesMoved();
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
            function populateProvincesOld() {
                const provinceSelect = document.getElementById('provinceOld');
                // Get unique provinces
                const provinces = [...new Set(allAddresses.map(item => item.province))];

                provinces.forEach(province => {
                    const option = document.createElement('option');
                    option.value = province;
                    option.textContent = province;
                    provinceSelect.appendChild(option);
                });
            }
            
            function populateProvincesMoved() {
                const provinceSelect = document.getElementById('provinceMoved');
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
            function filterCitiesOld() {
                const provinceSelect = document.getElementById('provinceOld');
                const citySelect = document.getElementById('cityOld');
                const selectedProvince = provinceSelect.value;

                // Clear previous options
                citySelect.innerHTML = '<option value="">Thành phố</option>';
                document.getElementById('districtOld').innerHTML = '<option value="">Quận</option>';
                document.getElementById('wardOld').innerHTML = '<option value="">Phường</option>';
                document.getElementById('streetOld').innerHTML = '<option value="">Đường</option>';

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
            function filterCitiesMoved() {
                const provinceSelect = document.getElementById('provinceMoved');
                const citySelect = document.getElementById('cityMoved');
                const selectedProvince = provinceSelect.value;
                console.log(selectedProvince);
                // Clear previous options
                citySelect.innerHTML = '<option value="">Thành phố</option>';
                document.getElementById('districtMoved').innerHTML = '<option value="">Quận</option>';
                document.getElementById('wardMoved').innerHTML = '<option value="">Phường</option>';
                document.getElementById('streetMoved').innerHTML = '<option value="">Đường</option>';

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
            function filterDistrictsOld() {
                const provinceSelect = document.getElementById('provinceOld');
                const citySelect = document.getElementById('cityOld');
                const districtSelect = document.getElementById('districtOld');
                const selectedProvince = provinceSelect.value;
                const selectedCity = citySelect.value;

                // Clear previous options
                districtSelect.innerHTML = '<option value="">Quận</option>';
                document.getElementById('wardOld').innerHTML = '<option value="">Phường</option>';
                document.getElementById('streetOld').innerHTML = '<option value="">Đường</option>';

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
            function filterDistrictsMoved() {
                const provinceSelect = document.getElementById('provinceMoved');
                const citySelect = document.getElementById('cityMoved');
                const districtSelect = document.getElementById('districtMoved');
                const selectedProvince = provinceSelect.value;
                const selectedCity = citySelect.value;

                // Clear previous options
                districtSelect.innerHTML = '<option value="">Quận</option>';
                document.getElementById('wardMoved').innerHTML = '<option value="">Phường</option>';
                document.getElementById('streetMoved').innerHTML = '<option value="">Đường</option>';

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
            function filterWardsOld() {
                const provinceSelect = document.getElementById('provinceOld');
                const citySelect = document.getElementById('cityOld');
                const districtSelect = document.getElementById('districtOld');
                const wardSelect = document.getElementById('wardOld');
                const selectedProvince = provinceSelect.value;
                const selectedCity = citySelect.value;
                const selectedDistrict = districtSelect.value;

                // Clear previous options
                wardSelect.innerHTML = '<option value="">Phường</option>';
                document.getElementById('streetOld').innerHTML = '<option value="">Đường</option>';

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
            function filterWardsMoved() {
                const provinceSelect = document.getElementById('provinceMoved');
                const citySelect = document.getElementById('cityMoved');
                const districtSelect = document.getElementById('districtMoved');
                const wardSelect = document.getElementById('wardMoved');
                const selectedProvince = provinceSelect.value;
                const selectedCity = citySelect.value;
                const selectedDistrict = districtSelect.value;

                // Clear previous options
                wardSelect.innerHTML = '<option value="">Phường</option>';
                document.getElementById('streetMoved').innerHTML = '<option value="">Đường</option>';

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
            function filterStreetsOld() {
                const provinceSelect = document.getElementById('provinceOld');
                const citySelect = document.getElementById('cityOld');
                const districtSelect = document.getElementById('districtOld');
                const wardSelect = document.getElementById('wardOld');
                const streetSelect = document.getElementById('streetOld');
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
            function filterStreetsMoved() {
                const provinceSelect = document.getElementById('provinceMoved');
                const citySelect = document.getElementById('cityMoved');
                const districtSelect = document.getElementById('districtMoved');
                const wardSelect = document.getElementById('wardMoved');
                const streetSelect = document.getElementById('streetMoved');
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
            function filterHousesOld() {
                const provinceSelect = document.getElementById('provinceOld');
                const citySelect = document.getElementById('cityOld');
                const districtSelect = document.getElementById('districtOld');
                const wardSelect = document.getElementById('wardOld');
                const streetSelect = document.getElementById('streetOld');
                const houseSelect = document.getElementById('houseOld');
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
            function filterHousesMoved() {
                const provinceSelect = document.getElementById('provinceMoved');
                const citySelect = document.getElementById('cityMoved');
                const districtSelect = document.getElementById('districtMoved');
                const wardSelect = document.getElementById('wardMoved');
                const streetSelect = document.getElementById('streetMoved');
                const houseSelect = document.getElementById('houseMoved');
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
