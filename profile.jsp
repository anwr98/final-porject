<%@ page import="java.sql.*" %>

<%
    String tutorName = (String) session.getAttribute("tutorName");
    String tutorId = (String) session.getAttribute("tutorId");

    if (tutorName == null) {
        response.sendRedirect("login.html");
        return;
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
        <h1>Welcome, <%= tutorName %>!</h1>
        <!-- You can dynamically load more data here using the tutorId -->
        <p>This is your profile page.</p>
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
