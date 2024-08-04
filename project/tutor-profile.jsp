stmt.setInt(1, tutorId);
rs = stmt.executeQuery();

int likes = 0;
int dislikes = 0;

if (rs.next()) {
    likes = rs.getInt("likes");
    dislikes = rs.getInt("dislikes");
}

// Display tutor profile
response.setContentType("text/html");
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
<div class="header-container">
    <a href="index.html" class="logo-link">
        <img src="images/logo.png" alt="Courses Online Logo" class="logo">
    </a>
    <nav>
        <ul>
            <li><a href="index.html">Home Page</a></li>
            <li><a href="create-registration.html">Register</a></li>
            <li><a href="login.html">Login</a></li>
        </ul>
    </nav>
</div>
</header>

<div class="tutor-profile">
<h2>Tutor Profile</h2>
<!-- Display tutor details here -->
<!-- For example, fetching tutor's name and specialization from database -->
<% 
    String tutorSql = "SELECT * FROM tutors WHERE id = ?";
    try (PreparedStatement tutorStmt = conn.prepareStatement(tutorSql)) {
        tutorStmt.setInt(1, tutorId);
        try (ResultSet tutorRs = tutorStmt.executeQuery()) {
            if (tutorRs.next()) {
                String name = tutorRs.getString("name");
                String specialization = tutorRs.getString("specialization");
                String profilePicture = tutorRs.getString("profile_picture");
%>
                <img src="<%= profilePicture %>" alt="Profile Picture" class="tutor-profile-photo">
                <p>Name: <%= name %></p>
                <p>Specialization: <%= specialization %></p>
                <form action="update-feedback.jsp" method="post">
                    <input type="hidden" name="tutor_id" value="<%= tutorId %>">
                    <button type="submit" name="type" value="like" class="like-button">Like</button>
                    <button type="submit" name="type" value="dislike" class="dislike-button">Dislike</button>
                </form>
                <div id="feedback">
                    <p>Likes: <span id="like-count"><%= likes %></span></p>
                    <p>Dislikes: <span id="dislike-count"><%= dislikes %></span></p>
                </div>
<%
            }
        }
    }
%>
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
<%
} catch (Exception e) {
e.printStackTrace();
response.sendRedirect("error.html"); // Or another error page
} finally {
if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
}
%>

