<%@ page import="java.sql.*" %>

<%
    // Retrieve form data from the registration page
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String password = request.getParameter("password");
    String course = request.getParameter("course");

    // Debugging output (you can remove this later)
    out.println("Name: " + name);
    out.println("Email: " + email);
    out.println("Phone: " + phone);
    out.println("Password: " + password);
    out.println("Course: " + course);

    try {
        // Load the MySQL JDBC Driver
        Class.forName("com.mysql.jdbc.Driver");

        // Establish a connection to the database
        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/coding_courses?enabledTLSProtocols=TLSv1.2", "root", "0503089535a")) {
            // Prepare an SQL statement to insert the tutor's information into the database
            String sql = "INSERT INTO tutors (name, email, phone, password, course) VALUES (?, ?, ?, ?, ?)";
            try (PreparedStatement stmt = con.prepareStatement(sql)) {
                // Set the parameters for the SQL statement
                stmt.setString(1, name);
                stmt.setString(2, email);
                stmt.setString(3, phone);
                stmt.setString(4, password);
                stmt.setString(5, course);

                // Execute the SQL statement
                int rowsInserted = stmt.executeUpdate();

                // Confirm whether the insertion was successful
                if (rowsInserted > 0) {
                    out.println("<p>Tutor successfully registered!</p>");
                } else {
                    out.println("<p>Registration failed. Please try again.</p>");
                }
            }
        }

        // Redirect the tutor to the login page after successful registration
        response.sendRedirect("login.html");

    } catch (SQLException e) {
        // Print any SQL errors that occur
        e.printStackTrace();
        out.println("SQL Error: " + e.getMessage());

    } catch (ClassNotFoundException e) {
        // Print any ClassNotFoundException errors (if the JDBC driver is not found)
        e.printStackTrace();
        out.println("Error: MySQL Driver not found.");
    }
%>
