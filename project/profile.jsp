<%@ page import="java.sql.*" %>

<%
    // Retrieve tutor ID from session
    String tutorId = (String) session.getAttribute("tutorId");

    // Initialize variables to hold profile data
    String notes = "";
    String profilePic = "";

    try {
        // Load MySQL JDBC Driver
        Class.forName("com.mysql.jdbc.Driver");

        // Establish connection to the database
        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/coding_courses?enabledTLSProtocols=TLSv1.2", "root", "0503089535a")) {
            // Query to retrieve the tutor's notes and profile picture
            String sql = "SELECT notes, profilePic FROM tutors WHERE id = ?";
            try (PreparedStatement stmt = con.prepareStatement(sql)) {
                stmt.setString(1, tutorId);  // Set tutor ID
                ResultSet rs = stmt.executeQuery();

                if (rs.next()) {
                    notes = rs.getString("notes");  // Retrieve notes
                    profilePic = rs.getString("profilePic");  // Retrieve profile picture path
                }
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("SQL Error: " + e.getMessage());
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
        out.println("Error: MySQL Driver not found.");
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tutor Profile</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <header>
        <div id="logo-container">
            <img src="images/logo.png" alt="Courses Online" id="logo" onclick="location.href='index.html';">
        </div>
        <nav>
            <ul>
                <li><a href="index.html">Home</a></li>
                <li><a href="about.html">About Us</a></li>
                <li><a href="courses.html">Our Courses</a></li>
                <li><a href="contact.html">Contact Us</a></li>
                <li><a href="logout.jsp">Logout</a></li>
            </ul>
        </nav>
    </header>

    <main class="content-wrapper">
        <h1>Tutor Profile: <%= session.getAttribute("tutorName") %></h1>

        <div class="profile-container">
            <!-- Display profile picture or default image -->
            <img src="<%= profilePic != null && !profilePic.isEmpty() ? profilePic : "images/default.png" %>" alt="Profile Picture" class="profile-picture">

            <div class="profile-info">
                <!-- Display notes or fallback text -->
                <p><strong>About Me:</strong> <%= notes != null && !notes.isEmpty() ? notes : "No notes available." %></p>

                <!-- Form to update notes and profile picture -->
                <form action="update-profile.jsp" method="post" enctype="multipart/form-data">
                    <label for="notes">Add/Edit Note:</label>
                    <textarea id="notes" name="notes" rows="4" cols="50"><%= notes != null ? notes : "" %></textarea>
                
                    <label for="profilePic">Upload Profile Picture:</label>
                    <input type="file" id="profilePic" name="profilePic" accept="image/*">
                
                    <button type="submit">Update Profile</button>
                </form>
                
            </div>
        </div>
    </main>

    <footer>
        <div class="footer-content">
            <p>Follow us:</p>
            <a href="https://facebook.com" target="_blank"><i class="fab fa-facebook"></i></a>
            <a href="https://twitter.com" target="_blank"><i class="fab fa-twitter"></i></a>
            <a href="https://instagram.com" target="_blank"><i class="fab fa-instagram"></i></a>
        </div>
    </footer>
</body>
</html>
