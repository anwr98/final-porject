<%@ page import="java.sql.*" %>

<%
    String courseId = request.getParameter("course_id");

    try {
        Class.forName("com.mysql.jdbc.Driver");
        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/coding_courses?enabledTLSProtocols=TLSv1.2", "root", "0503089535a")) {
            String sql = "DELETE FROM courses WHERE id = ?";
            try (PreparedStatement stmt = con.prepareStatement(sql)) {
                stmt.setInt(1, Integer.parseInt(courseId));
                int rowsDeleted = stmt.executeUpdate();

                if (rowsDeleted > 0) {
                    response.sendRedirect("admin-dashboard.jsp?success=deleted");
                } else {
                    out.println("<p>Failed to delete course. Please try again.</p>");
                }
            }
        }
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
        out.println("Error: " + e.getMessage());
    }
%>
