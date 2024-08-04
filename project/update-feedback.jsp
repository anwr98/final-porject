<%@ page import="java.sql.*" %>
<%
    String type = request.getParameter("type"); // 'like' or 'dislike'
    Integer tutorId = (Integer) session.getAttribute("tutor_id");

    int likes = 0;
    int dislikes = 0;

    try {
        // Load JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");
        
        // Establish connection
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/yourdbname",
                                                           "yourusername", "yourpassword") {
        
            if ("like".equals(type)) {
                // Update likes
                String updateSql = "UPDATE tutors SET likes = likes + 1 WHERE id = ?";
                try (PreparedStatement stmt = conn.prepareStatement(updateSql)) {
                    stmt.setInt(1, tutorId);
                    stmt.executeUpdate();
                }
            } else if ("dislike".equals(type)) {
                // Update dislikes
                String updateSql = "UPDATE tutors SET dislikes = dislikes + 1 WHERE id = ?";
                try (PreparedStatement stmt = conn.prepareStatement(updateSql)) {
                    stmt = conn.prepareStatement(updateSql);
                    stmt.setInt(1, tutorId);
                    stmt.executeUpdate();
                }
            }

            // Fetch updated counts
            String querySql = "SELECT likes, dislikes FROM tutors WHERE id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(querySql)) {
                stmt.setInt(1, tutorId);
                try (rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        likes = rs.getInt("likes");
                        dislikes = rs.getInt("dislikes");
                    }
                }
            }
            // Send JSON response
            response.setContentType("application/json");
            response.getWriter().write("{\"likes\": " + likes + ", \"dislikes\": " + dislikes + "}");
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
    }
%>