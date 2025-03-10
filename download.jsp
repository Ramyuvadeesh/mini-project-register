<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Alternate Staff Records</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        /* General Page Styles */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            text-align: center;
            padding: 20px;
        }

        /* Styled Button */
        #openPopup {
            background-color: #007bff;
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: 0.3s ease-in-out;
        }

        #openPopup:hover {
            background-color: #0056b3;
        }

        /* Popup Modal */
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
        }

        .modal-content {
            background-color: #fff;
            margin: 10% auto;
            padding: 20px;
            border-radius: 10px;
            width: 80%;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.3);
            text-align: left;
        }

        .close {
            float: right;
            font-size: 24px;
            cursor: pointer;
            color: red;
        }

        .close:hover {
            color: darkred;
        }

        /* Date Filter Styling */
        #dateFilter {
            padding: 8px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        /* Styled Table */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
            background: white;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }

        th {
            background-color: #007bff;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tr:hover {
            background-color: #ddd;
        }

        /* Filter Button */
        button {
            background-color: #28a745;
            color: white;
            padding: 8px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: 0.3s ease;
        }

        button:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>

    <!-- Button to Open Popup -->
    <button id="openPopup">View Records</button>

    <!-- Popup Modal -->
    <div id="recordPopup" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <h2>Alternate Staff Records</h2>

            <!-- Date Filter -->
            <label for="dateFilter"><b>Choose a Date:</b></label>
            <input type="date" id="dateFilter">
            <button onclick="filterRecords()">Filter</button>

            <!-- Table to Display Records -->
            <table border="1" id="staffTable">
                <thead>
                    <tr>
                        <th>Date</th>
                        <th>Time</th>
                        <th>Staff ID</th>
                        <th>Staff Name</th>
                        <th>Department</th>
                        <th>Class</th>
                        <th>Room Number</th>
                        <th>Course</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Data will be loaded dynamically -->
                </tbody>
            </table>
        </div>
    </div>

    <script>
        $(document).ready(function() {
            // Open popup and load all records
            $("#openPopup").click(function() {
                $("#recordPopup").show();
                loadAllRecords(); // Load full table when opening
            });

            // Close popup
            $(".close").click(function() {
                $("#recordPopup").hide();
            });
        });

        function loadAllRecords() {
            $.ajax({
                url: "filterRecords.jsp",
                type: "GET",
                data: { date: "" }, // Empty date to load all records
                success: function(response) {
                    $("#staffTable tbody").html(response);
                },
                error: function() {
                    alert("Error loading records.");
                }
            });
        }

        function filterRecords() {
            var selectedDate = document.getElementById("dateFilter").value;
            if (selectedDate === "") {
                alert("Please select a date.");
                return;
            }

            $.ajax({
                url: "filterRecords.jsp",
                type: "GET",
                data: { date: selectedDate },
                success: function(response) {
                    $("#staffTable tbody").html(response);
                },
                error: function() {
                    alert("Error fetching filtered records.");
                }
            });
        }
    </script>

</body>
</html>
