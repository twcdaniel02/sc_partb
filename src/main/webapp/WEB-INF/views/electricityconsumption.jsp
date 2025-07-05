<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
	crossorigin="anonymous">
<title>Electricity Consumption</title>
<link rel="stylesheet" href="./resources/css/consumption.css">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
	crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<jsp:include page="headerUser.jsp" />
	<div class="title">
		<h1>ELECTRICITY COMSUMPTION SUBMISSION</h1>
	</div>
	<div class="calendar-image">
		<div class="calendar-container">
			<div class="calendar-header">
				<button id="prevBtn" onclick="prevMonth()">&lt;</button>
				<h2 id="monthYear"></h2>
				<button id="nextBtn" onclick="nextMonth()">&gt;</button>
			</div>
			<div class="calendar-body" id="calendarBody"></div>
			<div class="calendar-date">
				<label for="startDate">Start Date:</label> <input type="text"
					id="startDate" readonly> <label for="endDate">End
					Date:</label> <input type="text" id="endDate" readonly>
			</div>
		</div>
		<div class="semak-Image">
			<img
				src="https://p.sda1.dev/14/5112b1c0a8e3cd002b85d059ff45ed2c/image.png"
				alt="semak bill" width="400" height="270">
		</div>
	</div>
	<form action="electricitySubmit" method="post"
		enctype="multipart/form-data">
		<div class="form-container">
			<div class="form-input-value mb-3">
				<div>
					<label for="days" class="form-label">The number of days for
						each month</label> <input type="text" class="form-control" id="days"
						value="" readonly disabled>
				</div>
				<div>
					<label for="proportionalFactor" class="form-label">Proportional
						Factor</label> <input type="text" class="form-control"
						id="proportionalFactor" name="proportionalFactor"
						value="${electricityCon.electricityProportionalFactor}" required
						disabled>
				</div>
				<div>
					<label for="waterUsageRM" class="form-label">The current
						electric usage value (in RM)</label> <input type="text"
						class="form-control" id="electricityUsageRM"
						name="electricityUsageRM"
						value="${electricityCon.electricUsageValueRM}" required disabled>
				</div>
				<div>
					<label for="waterUsageM3" class="form-label">The current
						electric usage value (kWh)</label> <input type="text" class="form-control"
						id="electricityUsageM3" name="electricityUsageM3"
						value="${electricityCon.electricUsageValueM3}" required disabled>
				</div>
			</div>
			<div class="form-upload">
				<div>
					<label for="billImage" class="form-label">Uploaded bill</label>
					<button type="button" class="btn btn-outline-secondary"
						data-bs-toggle="modal" data-bs-target="#Modal">
						Image
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
							fill="currentColor" class="bi bi-box-arrow-up-right"
							viewBox="0 0 16 16">
  								<path fill-rule="evenodd"
								d="M8.636 3.5a.5.5 0 0 0-.5-.5H1.5A1.5 1.5 0 0 0 0 4.5v10A1.5 1.5 0 0 0 1.5 16h10a1.5 1.5 0 0 0 1.5-1.5V7.864a.5.5 0 0 0-1 0V14.5a.5.5 0 0 1-.5.5h-10a.5.5 0 0 1-.5-.5v-10a.5.5 0 0 1 .5-.5h6.636a.5.5 0 0 0 .5-.5" />
 								<path fill-rule="evenodd"
								d="M16 .5a.5.5 0 0 0-.5-.5h-5a.5.5 0 0 0 0 1h3.793L6.146 9.146a.5.5 0 1 0 .708.708L15 1.707V5.5a.5.5 0 0 0 1 0z" />
							</svg>
					</button>
				</div>
				<div>
					<c:choose>
						<c:when test="${electricityCon.status == 'APPROVED'}">
							<br><h5>Status: <span class="badge text-bg-success">Approved</span></h5>
						</c:when>
						<c:when test="${electricityCon.status == 'PENDING'}">
							<br><h5>Status: <span class="badge text-bg-info">Pending</span></h5>
						</c:when>
						<c:when test="${electricityCon.status == 'DISAPPROVED'}">
							<br><h5>Status: <span class="badge text-bg-danger">Disapproved</span></h5>
						</c:when>
						<c:otherwise>
							<br><h5>Error</h5>
						</c:otherwise>
					</c:choose>
				</div>
				<div class="submit-btn">
					<a href="electricityConsumptionEdit" ><button type="button" class="btn btn-primary">Edit</button></a>
				</div>
			</div>
		</div>
	</form>

	<!-- Modal -->
	<div class="modal fade" id="Modal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="exampleModalLabel">Image</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<img width="500px"
						src="data:image/*;base64,${Base64.getEncoder().encodeToString(electricityCon.electricConsumptionProof)}" />
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>

	<script>
    let currentDate = new Date();
 // Get the first day of the month and the total number of days
    const firstDay = new Date(currentDate.getFullYear(), currentDate.getMonth(), 1);
    const lastDay = new Date(currentDate.getFullYear(), currentDate.getMonth() + 1, 0);
    let selectedStartDate = null;
    let selectedEndDate = null;

    function renderCalendar() {
        const calendarBody = document.getElementById('calendarBody');
        const monthYear = document.getElementById('monthYear');
        console.log(monthYear);
        const startDateInput = document.getElementById('startDate');
        const endDateInput = document.getElementById('endDate');
        
        document.getElementById('days').value = lastDay.getDate();

        // Clear previous content
        calendarBody.innerHTML = '';

        // Set the month and year in the header
       	monthYear.textContent = formatMonthYear(currentDate);

        // Create day elements for each day in the month
        for (let i = 1; i <= lastDay.getDate(); i++) {
            const day = document.createElement('div');
            day.classList.add('day');
            day.textContent = i;

            // Highlight selected range
            if (selectedStartDate && selectedEndDate) {
                const currentDay = new Date(currentDate.getFullYear(), currentDate.getMonth(), i);
                if (currentDay >= selectedStartDate && currentDay <= selectedEndDate) {
                    day.classList.add('selected-range');
                }
            }

            // Attach click event to select start and end dates
            day.addEventListener('click', () => handleDateSelection(i));

            calendarBody.appendChild(day);
        }

        // Update the input fields with selected dates
        startDateInput.value = selectedStartDate ? selectedStartDate.toDateString() : '';
        endDateInput.value = selectedEndDate ? selectedEndDate.toDateString() : '';
    }

    function handleDateSelection(day) {
        const selectedDate = new Date(currentDate.getFullYear(), currentDate.getMonth(), day);

        // If both start and end dates are selected, reset the selection
        if (selectedStartDate && selectedEndDate) {
            selectedStartDate = selectedDate;
            selectedEndDate = null;
        } else if (!selectedStartDate) {
            // If start date is not selected, set it
            selectedStartDate = selectedDate;
        } else {
            // If start date is selected but end date is not, set the end date
            selectedEndDate = selectedDate;
        }

        // If end date is before start date, swap them
        if (selectedStartDate && selectedEndDate && selectedStartDate > selectedEndDate) {
            [selectedStartDate, selectedEndDate] = [selectedEndDate, selectedStartDate];
        }

        // Re-render the calendar
        renderCalendar();
    }

    function prevMonth() {
        currentDate.setMonth(currentDate.getMonth() - 1);
        renderCalendar();
    }

    function nextMonth() {
        currentDate.setMonth(currentDate.getMonth() + 1);
        renderCalendar();
    }
    
    function formatMonthYear(date) {
        const options = { month: 'long', year: 'numeric' };
        return new Intl.DateTimeFormat('default', options).format(date);
    }

    // Initial render
    renderCalendar();
</script>
</body>
</html>