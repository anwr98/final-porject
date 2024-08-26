<%@ page import="java.sql.*" %>

<%
    String course = "CSS";

    try {
        Class.forName("com.mysql.jdbc.Driver");

        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/coding_courses?enabledTLSProtocols=TLSv1.2", "root", "0503089535a")) {

            String sql = "SELECT name, phone, notes, profilePic FROM tutors WHERE course = ?";
            try (PreparedStatement stmt = con.prepareStatement(sql)) {
                stmt.setString(1, course);
                ResultSet rs = stmt.executeQuery();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CSS Tutors</title>
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
            </ul>
        </nav>
    </header>

    <main>
        <h1>CSS Tutors</h1>
        <div id="tutor-list-container">
<%
                if (!rs.isBeforeFirst()) {
                    out.println("<p>No tutors found for the course: " + course + "</p>");
                } else {
                    while (rs.next()) {
                        String tutorName = rs.getString("name");
                        String tutorPhone = rs.getString("phone");
                        String tutorNotes = rs.getString("notes");
                        String tutorProfilePic = rs.getString("profilePic");
%>
                        <div class="tutor-item">
                            <img src="<%= tutorProfilePic != null ? tutorProfilePic : "images/default.png" %>" alt="<%= tutorName %>" class="profile-picture">
                            <h2><%= tutorName %></h2>
                            <p><strong>Phone Number:</strong> <a href="tel:<%= tutorPhone %>"><%= tutorPhone %></a></p>
                            <p><strong>About Me:</strong> <%= tutorNotes != null ? tutorNotes : "No notes available." %></p>
                        </div>
<%
                    }
                }
%>
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
<%
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
