<%@ page import="java.sql.*" %>

<%
    // Get the comment and tutorId from the form
    String tutorId = request.getParameter("tutorId");
    String note = request.getParameter("note");

    try {
        Class.forName("com.mysql.jdbc.Driver");

        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/coding_courses?enabledTLSProtocols=TLSv1.2", "root", "0503089535a")) {

            // Insert the comment into the comments table
            String sql = "INSERT INTO comments (tutor_id, comment) VALUES (?, ?)";
            try (PreparedStatement stmt = con.prepareStatement(sql)) {
                stmt.setString(1, tutorId);
                stmt.setString(2, note);

                // Execute the insert statement
                stmt.executeUpdate();
            }
        }

        // Redirect back to the tutor's profile page after comment submission
        response.sendRedirect("tutor-profile.jsp?tutorId=" + tutorId);

    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
        out.println("An error occurred while adding the comment.");
    }
%>
