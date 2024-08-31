<%@ page import="java.sql.*, java.util.*" %>

<%
    // Fetch the list of courses from the database
    List<Map<String, String>> courses = new ArrayList<>();

    try {
        Class.forName("com.mysql.jdbc.Driver");

        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/coding_courses?enabledTLSProtocols=TLSv1.2", "root", "0503089535a")) {
            String sql = "SELECT course_name, image_path FROM courses";
            try (PreparedStatement stmt = con.prepareStatement(sql)) {
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    Map<String, String> course = new HashMap<>();
                    course.put("course_name", rs.getString("course_name"));
                    course.put("image_path", rs.getString("image_path"));
                    courses.add(course);
                }
            }
        }
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Online Coding Courses</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>

    <!-- Header -->
    <header>
        <div id="logo-container">
            <img src="images/logo.png" alt="Courses Online" id="logo" onclick="location.href='index.jsp';">
        </div>
        <nav>
            <ul>
                <li><a href="index.jsp">Home</a></li>
                <li><a href="index.jsp#about">About Us</a></li>
                <li><a href="index.jsp#courses">Our Courses</a></li>
                <li><a href="index.jsp#contact">Contact Us</a></li>
                <li><a href="login.html">Login</a></li>
            </ul>
        </nav>
    </header>

    <!-- Hero Section -->
    <section id="hero">
        <div class="hero-content">
            <a href="#courses" class="cta-button">Explore Courses</a>
        </div>
    </section>

    <section id="about">
        <h2>About Us</h2>
        <p>At Online Course, we are dedicated to providing top-quality online coding courses that empower individuals to learn and excel in the field of programming. Whether you're a beginner looking to start your journey in coding or an experienced developer aiming to enhance your skills, our platform offers a diverse range of courses tailored to meet your needs. Our expert tutors are passionate about teaching and committed to helping you achieve your goals. Join our community of learners today and take the first step towards mastering the world of coding.</p>
    </section>

    <!-- Our Courses Section -->
    <section id="courses">
        <h2>Our Courses</h2>
        <div class="course-list">
            <% for (Map<String, String> course : courses) { %>
                <div class="course-item">
                    <a href="<%= course.get("course_name").toLowerCase() %>-tutors.jsp">
                        <img src="<%= course.get("image_path") %>" alt="<%= course.get("course_name") %>">
                        <p><%= course.get("course_name") %></p>
                    </a>
                </div>
            <% } %>
        </div>
    </section>

    <!-- Contact Us Section -->
    <section id="contact">
        <h2>Contact Us</h2>
        <form action="contact-process.jsp" method="post">
            <label for="name">Name:</label>
            <input type="text" id="name" name="name" required>

            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>

            <label for="phone">Phone Number:</label>
            <input type="tel" id="phone" name="phone" required>

            <label for="course">Select a Course:</label>
            <select id="course" name="course" required>
                <% for (Map<String, String> course : courses) { %>
                    <option value="<%= course.get("course_name") %>"><%= course.get("course_name") %></option>
                <% } %>
            </select>

            <label for="note">Note:</label>
            <textarea id="note" name="note" rows="4" required></textarea>

            <button type="submit">Submit</button>
        </form>
    </section>

    <!-- Footer -->
    <footer>
        <div class="footer-content">
            <p>Follow us:</p>
            <a href="https://facebook.com" target="_blank"><i class="fab fa-facebook"></i></a>
            <a href="https://twitter.com" target="_blank"><i class="fab fa-twitter"></i></a>
            <a href="https://instagram.com" target="_blank"><i class="fab fa-instagram"></i></a>
        </div>
    </footer>

    <script src="script.js"></script>
</body>
</html>
