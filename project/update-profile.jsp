<%@ page import="java.sql.*" %>
<%
    Integer tutorId = (Integer) session.getAttribute("tutor_id");

    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/yourdbname", "root", "yourpassword");

        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String aboutCourse = request.getParameter("about_course");
            Part filePart = request.getPart("profile_picture"); // Retrieves profile picture from the form
            String profilePicturePath = "images/default-profile.png"; // Default image path
            
            if (filePart != null) {
                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                String uploadPath = getServletContext().getRealPath("") + "images/" + fileName;
                filePart.write(uploadPath);
                profilePicturePath = "images/" + fileName;
            }

            // Update tutor profile
            String sql = "UPDATE tutors SET profile_picture = ?, about_course = ? WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, profilePicturePath);
            stmt.setString(2, aboutCourse);
            stmt.setInt(3, tutorId);
            
            int rowsUpdated = stmt.executeUpdate();

            if (rowsUpdated > 0) {
                response.sendRedirect("tutor-profile.jsp"); // Redirect to the profile page
            } else {
                response.sendRedirect("update-profile.jsp?error=true");
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("update-profile.jsp?error=true");
    } finally {
        if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Profile</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <header>
        <div class="header-container">
            <a href="index.html" class="logo-link">
                <img src="images/logo.png" alt="Courses Online Logo" class="logo">
            </a>
            <nav>
                <ul>
                    <li><a href="index.html">Home Page</a></li>
                    <li><a href="login.html">Login</a></li>
                </ul>
            </nav>
        </div>
    </header>
    
    <div class="update-profile">
        <h2>Update Your Profile</h2>
        <form action="update-profile.jsp" method="post" enctype="multipart/form-data">
            <label for="about_course">About the Course:</label>
            <textarea id="about_course" name="about_course" rows="4" required></textarea>
            
            <label for="profile_picture">Profile Picture:</label>
            <input type="file" id="profile_picture" name="profile_picture" accept="image/*">
            
            <button type="submit">Update Profile</button>
        </form>
        <% if ("true".equals(request.getParameter("error"))) { %>
            <p style="color: red;">Profile update failed. Please try again.</p>
        <% } %>
    </div>
    
    <footer>
        <div class="footer-container">
            <a href="https://www.facebook.com" target="_blank" class="social-icon">
                <img src="images/facebook-icon.png" alt="Facebook">
            </a>
            <a href="https://www.twitter.com" target="_blank" class="social-icon">
                <img src="images/twitter-icon.png" alt="Twitter">
            </a>
            <a href="https://www.instagram.com" target="_blank" class="social-icon">
                <img src="images/instagram-icon.png" alt="Instagram">
            </a>
        </div>
    </footer>
</body>
</html>

