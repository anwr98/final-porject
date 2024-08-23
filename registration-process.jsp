<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.SQLException" %>

<%
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String course = request.getParameter("course");

    // Debugging Output
    out.println("Name: " + name);
    out.println("Email: " + email);
    out.println("Username: " + username);
    out.println("Password: " + password);
    out.println("Course: " + course);

    try {
        // Ensure you have the correct MySQL driver class for your version of MySQL
        Class.forName("com.mysql.jdbc.Driver");

        // Establish a database connection
        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/coding_courses?enabledTLSProtocols=TLSv1.2", "root", "0503089535a")) {
            String sql = "INSERT INTO tutors (name, email, password, phone, course) VALUES (?, ?, ?, ?, ?)";
            try (PreparedStatement stmt = con.prepareStatement(sql)) {
                stmt.setString(1, name);
                stmt.setString(2, email);
                stmt.setString(3, password);
                stmt.setString(4, username);
                stmt.setString(5, course);
                
                int n = stmt.executeUpdate();
                out.println(n + " rows inserted");
            }
        }
        // Redirect after successful registration
        response.sendRedirect("login.html");

    } catch (SQLException e) {
        e.printStackTrace();
        out.println("Error: " + e.getMessage());
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
        out.println("Error: MySQL Driver not found");
    }
%>


