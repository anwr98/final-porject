<%@ page import="java.sql.*" %>

<%
    // Retrieve login credentials from the form
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    boolean isValidUser = false;
    String tutorName = "";
    String tutorId = "";

    try {
        // Load the MySQL JDBC driver
        Class.forName("com.mysql.jdbc.Driver");

        // Establish connection to the database
        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/coding_courses", "root", "0503089535a")) {

            // Prepare the SQL statement to find a matching tutor
            try (PreparedStatement stmt = con.prepareStatement("SELECT id, name FROM tutors WHERE phone = ? AND password = ?")) {
                
                // Set parameters for the prepared statement
                stmt.setString(1, username); // Assuming 'username' input is the phone number
                stmt.setString(2, password);

                // Execute the query
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        isValidUser = true;
                        tutorName = rs.getString("name");
                        tutorId = rs.getString("id");
                    }
                }
            }
        }

        // Redirect or display an error based on validation result
        if (isValidUser) {
            // Store the tutor's name and ID in the session
            session.setAttribute("tutorName", tutorName);
            session.setAttribute("tutorId", tutorId);

            // Redirect to the tutor's profile page or home page
            response.sendRedirect("profile-" + tutorId + ".html");  // Assumes the profile page follows the format profile-<id>.html
        } else {
            out.println("Invalid username or password. Please try again.");
        }
        
    } catch (Exception e) {
        // Print the stack trace for any errors encountered
        e.printStackTrace();

        // Display the error message on the web page
        out.println("Error: " + e.getMessage());
    }
%>
