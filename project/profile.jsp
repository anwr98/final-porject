<%@ page import="java.sql.*" %>
<%
    String tutorName = (String) session.getAttribute("tutorName");
    String tutorId = (String) session.getAttribute("tutorId");

    // Ensure the tutor is logged in
    if (tutorName == null || tutorId == null) {
        response.sendRedirect("login.html");
        return;
    }

    String notes = "";
    String profilePicture = "";

    // Retrieve tutor details from the database
    try {
        Class.forName("com.mysql.jdbc.Driver");
        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/coding_courses", "root", "0503089535a")) {
            String sql = "SELECT notes, profilePic FROM tutors WHERE id = ?";
            try (PreparedStatement stmt = con.prepareStatement(sql)) {
                stmt.setString(1, tutorId);

                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        notes = rs.getString("notes");
                        profilePicture = rs.getString("profilePic");
                    }
                }
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("Error: " + e.getMessage());
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile - <%= tutorName %></title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <header>
        <div id="logo-container">
            <img src="images/logo.png" alt="Courses Online" id="logo" onclick="location.href='index.html';">
        </div>
        <nav>
            <ul>
                <li><a href="index.html#about">Home</a></li>
                <li><a href="index.html#about">About Us</a></li>
                <li><a href="index.html#courses">Our Courses</a></li>
                <li><a href="index.html#contact">Contact Us</a></li>
                <li><a href="logout.jsp">Logout</a></li>
            </ul>
        </nav>
    </header>

    <main>
        <h1>Tutor Profile: <%= tutorName %></h1>
        <img src="<%= profilePicture %>" alt="Profile Picture" style="width:150px;height:auto;">
        <p><strong>About Me:</strong> <%= notes %></p>

        <form action="update-profile.jsp" method="post" enctype="multipart/form-data">
            <label for="notes">Add/Edit Note:</label>
            <textarea id="notes" name="notes" rows="4" cols="50"><%= notes %></textarea>

            <label for="profilePic">Upload Profile Picture:</label>
            <input type="file" id="profilePic" name="profilePic" accept="image/*">

            <button type="submit">Update Profile</button>
        </form>
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
