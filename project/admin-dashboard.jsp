<%@ page import="java.sql.*, java.util.*" %>

<%
    String role = (String) session.getAttribute("role");
    if (!"admin".equals(role)) {
        response.sendRedirect("login.html");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
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
                <li><a href="logout.jsp">Logout</a></li>
            </ul>
        </nav>
    </header>

    <main>
        <h1>Welcome to Admin Dashboard</h1>

        <!-- Form to Add a New Course -->
        <section>
            <h2>Add a New Course</h2>
            <form action="add-course.jsp" method="post">
                <label for="courseName">Course Name:</label>
                <input type="text" id="courseName" name="courseName" required>
                <button type="submit">Add Course</button>
            </form>
        </section>

        <!-- Existing Courses with Delete Option -->
        <section>
            <h2>Existing Courses</h2>
            <ul>
                <%
                    try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/coding_courses?enabledTLSProtocols=TLSv1.2", "root", "0503089535a")) {
                        String sql = "SELECT * FROM courses";
                        try (PreparedStatement stmt = con.prepareStatement(sql);
                             ResultSet rs = stmt.executeQuery()) {
                            while (rs.next()) {
                                String courseId = rs.getString("id");
                                String courseName = rs.getString("name");
                %>
                                <li>
                                    <%= courseName %>
                                    <form action="delete-course.jsp" method="post" style="display:inline;">
                                        <input type="hidden" name="courseId" value="<%= courseId %>">
                                        <button type="submit">Delete</button>
                                    </form>
                                </li>
                <%
                            }
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                %>
            </ul>
        </section>
    </main>
</body>
</html>
