<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html>

    <head>
        <title>Registration Page</title>
        <link href="${pageContext.request.contextPath}/resources/css/registration.css" rel="stylesheet">
        <style>
            body {
                font-family: Arial, Helvetica, sans-serif;
                display: flex;
                align-items: center;
                justify-content: center;
                /* Updated to center horizontally */
                height: 100vh;
                margin: 0;
            }

            #background {
                background-image: url('${pageContext.request.contextPath}/resources/images/maxresdefault.png');
                /* Replace with the actual path to your image */
                background-size: cover;
                background-position: center;
                background-repeat: no-repeat;
            }
        </style>
    </head>

    <body id="background">
        <div class="container">
            <div class="left-section">
                <h2><img src="${pageContext.request.contextPath}/resources/images/mbiplogo.png" alt="MBIP Logo"
                        width="380px"></h2>
                <h3>PERSONAL DETAILS</h3>
                <form id="registrationForm" action="${pageContext.request.contextPath}/register" method="post">
                    <div class="input-wrapper">
                        <input type="text" name="ic" placeholder="IC/Passport No." required>
                    </div>
                    <div class="input-wrapper">
                        <div class="name-group">
                            <input type="text" name="firstName" placeholder="First Name" required>
                            <input type="text" name="lastName" placeholder="Last Name" required>
                        </div>
                    </div>
                    <div class="input-wrapper">
                        <div class="radio-group">
                            <label>
                                <input type="radio" name="gender" value="male" required> Male
                            </label>
                            <label>
                                <input type="radio" name="gender" value="female" required> Female
                            </label>
                        </div>
                    </div>
                    <div class="input-wrapper">
                        <input type="email" name="email" placeholder="Email Address" required>
                    </div>
                    <div class="input-wrapper">
                        <input type="text" name="phoneNumber" placeholder="Phone Number" required>
                    </div>
                    <div class="input-wrapper">
                        <div class="select"></div>
                        <select name="occupation" id="occupation">
                            <option value="Occupation">Occupation</option>
                            <option value="Private">Private</option>
                            <option value="Government">Government</option>
                            <option value="Unemployed">Unemployed</option>
                            <option value="Retired">Retired</option>
                        </select>
                    </div>
                    <div class="input-wrapper">
                        <input type="password" name="password" value="password" required>
                    </div>
                    <div class="input-wrapper">
                        <input type="password" name="cfmpassword" value="cfmpassword" required>
                    </div>
                    <div class="input-wrapper">
                        <div class="radio-group">
                            <label>
                                MBIP Staff <input type="radio" name="staff" value="yes" onclick="toggleMbipStaffId()"
                                    required> Yes
                            </label>
                            <label>
                                <input type="radio" name="staff" value="no" onclick="toggleMbipStaffId()" required
                                    checked> No
                            </label>
                        </div>
                    </div>

                    <div class="input-wrapper mbip-staff-id">
                        <input type="text" name="mbipStaffId" id="mbip-staff-id" placeholder="MBIP Staff ID">
                    </div>
            </div>
            <div class="right-section">
                <h3>LOCATION DETAILS</h3>
                <form id="registrationForm" action="${pageContext.request.contextPath}/register" method="post"
                enctype="multipart/form-data">
                <div class="input-wrapper">
                    <textarea id="address" name="address" rows="4" cols="50" placeholder="Address in full"></textarea>
                </div>
                <div class="input-wrapper">
                    <div class="select"></div>
                    <select name="region" id="region">
                        <option value="Region">Region</option>
                        <option value="Pulai Indah">Pulai Indah</option>
                        <option value="Kangkar Pulai">Kangkar Pulai</option>
                        <option value="Pulai Utama">Pulai Utama</option>
                        <option value="Sri Pulai">Sri Pulai</option>
                        <option value="Taman Universiti">Taman Universiti</option>
                        <option value="Mutiara Rini">Mutiara Rini</option>
                        <option value="Lima Kedai">Lima Kedai</option>
                        <option value="Nusa Bayu">Nusa Bayu</option>
                        <option value="Gelang Patah">Gelang Patah</option>
                        <option value="Leisure Farm">Leisure Farm</option>
                        <option value="Tanjung Kupang">Tanjung Kupang</option>
                        <option value="Medini Iskandar">Medini Iskandar</option>
                        <option value="Kota Iskandar">Kota Iskandar</option>
                        <option value="Bukit Horizon">Bukit Horizon</option>
                        <option value="Impian Emas">Impian Emas</option>
                        <option value="Sri Skudai">Sri Skudai</option>
                        <option value="Skudai">Skudai</option>
                        <option value="Skudai Baru">Skudai Baru</option>
                        <option value="Selese Jaya">Selese Jaya</option>
                        <option value="Tun Aminah">Tun Aminah</option>
                        <option value="Nusa Bestari">Nusa Bestari</option>
                        <option value="Bukit Indah">Bukit Indah</option>
                        <option value="Sutera Utama">Sutera Utama</option>
                        <option value="Perling">Perling</option>                
                    </select>
                </div>
                <div class="input-wrapper">
                    <div class="select"></div>
                    <select name="category" id="category">
                        <option value="Category">Category</option>
                        <option value="A1">A1: Housing (High Rise)</option>
                        <option value="A2">A2: Housing (Landed)</option>
                        <option value="A3">A3: Institution</option>
                        <option value="A4">A4: MBIP Staff and Divisions</option>
                    </select>
                </div>
                <br>
                <div class="proof-document-outer">
                    <div class="proof-document-inner">
                        <label for="addressProof" class="form-label">Upload your address proof</label> 
                        <input type="file"
                            class="form-control" id="addressProof" name="addressProof" required>
                    </div>
                </div>

                <div>
                    <br>
                    <input type="submit" value="Submit">
                    <br>
                </div>
                </form>

                <script>
                    function toggleMbipStaffId() {
                        var mbipStaffInput = document.getElementById('mbip-staff-id');
                        var mbipStaffRadio = document.querySelector('input[name="staff"]:checked');
                        var categorySelect = document.getElementById('category');

                        if (mbipStaffInput && mbipStaffRadio && categorySelect) {
                            mbipStaffInput.style.display = mbipStaffRadio.value === 'yes' ? 'block' : 'none';

                            // Set default category to "A4" if MBIP Staff is selected
                            categorySelect.value = mbipStaffRadio.value === 'yes' ? 'A4' : 'Category';
                        }
                    }

                    // Attach an event listener to the forms
                    document.getElementById("registrationForm").addEventListener("submit", function (event) {

                });

                // Initial call to toggleMbipStaffId
                toggleMbipStaffId();
                </script>

            </div>
        </div>
    </body>

    </html>