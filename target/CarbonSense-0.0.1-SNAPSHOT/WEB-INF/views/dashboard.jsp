<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
                integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
                crossorigin="anonymous">
            <title>Dashboard</title>
            <link rel="stylesheet" href="./resources/css/dashboard.css">
            <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

            <title>Dashboard</title>

            <style>
                body {
                    padding: 130px;
                }

                .infobar {
                    width: 95%;
                    height: 100%;
                    background: rgba(217, 217, 217, 0);
                    border: 3px #002B7F solid;
                    padding: 20px;
                    font-weight: bold;
                    font-size: 20px;
                }

            </style>

        </head>

        <body>
            <jsp:include page="headerUser.jsp" />
            <div class="title">
                <h1>DASHBOARD</h1>
            </div>

            <div class="infobar">
                <div class="grid">
                    <div class="col1">Name: ${user.firstName} ${user.lastName}</div>
                    <div class="nric-number">NRIC Number: ${user.ic}</div>
                    <div class="col1">Residential Region: ${user.region}</div>
                    <div>Contact Number: ${user.phoneNumber}</div>
                    <div class="col1" style="grid-column: span 2;">Address: ${user.address}</div>
                    <div class="update-container">
                        <a href="${pageContext.request.contextPath}/profile" class="btn btn-primary">UPDATE</a>
                    </div>
                </div>
            </div>
            <br><br>
            <div class="row-below-infobar">
                <div class="row">
                    <div class="col-6">
                        <c:choose>
                            <c:when test="${user.category == 'A1'}">
                                <c:set var="categoryImage" value="./resources/images/highrise.png" />
                                <c:set var="categoryText" value="Category A1<br /><br />Housing (High Rise)" />
                            </c:when>
                            <c:when test="${user.category == 'A2'}">
                                <c:set var="categoryImage" value="./resources/images/landed.png" />
                                <c:set var="categoryText" value="Category A2<br /><br />Housing (Landed)" />
                            </c:when>
                            <c:when test="${user.category == 'A3'}">
                                <c:set var="categoryImage" value="./resources/images/institution.png" />
                                <c:set var="categoryText" value="Category A3<br /><br />Institution" />
                            </c:when>
                            <c:when test="${user.category == 'A4'}">
                                <c:set var="categoryImage" value="./resources/images/mbip.png" />
                                <c:set var="categoryText" value="Category A4<br /><br />MBIP Staff and Divisions" />
                            </c:when>
                            <c:otherwise>
                                <c:set var="categoryText" value="Category Not Found <br/><br/>Please update your profile !"/>
                            </c:otherwise>
                        </c:choose>
        
                        <div style="display: flex; align-items: center; justify-content: center; text-align: center;">
                            <img style="width: 160px; height: 160px" src="${categoryImage}" alt="category" />
                            <div style="color: black; font-size: 32px; font-family: Calibri; font-weight: 700; word-wrap: break-word; margin-left: 15px;">
                                ${categoryText}
                            </div>
                        </div>
                    </div>
                    <div class="col-6">
                        <div style="width: 100%; height: 100%; position: relative">
                            <div
                                style="position: absolute; color: black; font-size: 32px; font-family: Calibri; font-weight: 700; word-wrap: break-word; top: 0; text-align:center;">
                                TOTAL DATA SUBMITTED</div>
                            <div
                                style="width: 328px; position: absolute; color: black; font-size: 24px; font-family: Calibri; font-weight: 700; word-wrap: break-word; left: 0; top: 69px;">
                                WATER (L)<br />ENERGY (KWH)<br />COOKING OIL (L/KG)</div>
                            <div
                                style="width: 328px; position: absolute; text-align: right; color: black; font-size: 24px; font-family: Calibri; font-weight: 700; word-wrap: break-word; right: 0; top: 69px;">
                                ${waterConsumption}<br />${energyConsumption}<br />${cookingOilConsumption}</div>
                        </div>
                    </div>
                </div>
            </div>

        </body>

        </html>