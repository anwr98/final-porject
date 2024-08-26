<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HTML Tutors</title>
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
                <li><a href="contact.html">Contact Us</a></li>
            </ul>
        </nav>
    </header>

    <main>
        <h1>HTML Tutors</h1>
        <div class="tutor-list">
            <%
                Connection con = null;
                PreparedStatement stmt = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/coding_courses?enabledTLSProtocols=TLSv1.2", "root", "0503089535a");

                    String query = "SELECT name, phone, notes, profilePic FROM tutors WHERE course = 'HTML'";
                    stmt = con.prepareStatement(query);
                    rs = stmt.executeQuery();

                    while (rs.next()) {
                        String tutorName = rs.getString("name");
                        String tutorPhone = rs.getString("phone");
                        String tutorNotes = rs.getString("notes");
                        String profilePic = rs.getString("profilePic");

                        if (profilePic == null || profilePic.isEmpty()) {
                            profilePic = "images/default.png"; 
                        }
                        %>
                        <div class="tutor-item">
                            <img src="<%= profilePic %>" alt="<%= tutorName %>" class="profile-picture">
                            <div class="tutor-name"><%= tutorName %></div>
                            <div class="tutor-phone">Phone Number: <a href="tel:<%= tutorPhone %>"><%= tutorPhone %></a></div>
                            <div class="tutor-about">About Me: <%= tutorNotes != null && !tutorNotes.isEmpty() ? tutorNotes : "No notes available." %></div>
                        </div>
                        <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (con != null) con.close();
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
