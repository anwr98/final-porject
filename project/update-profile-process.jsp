<%@ page import="java.sql.*, java.io.*, javax.servlet.*, javax.servlet.http.*" %>
<%
    String courseDescription = request.getParameter("course_description");
    Part filePart = request.getPart("profile_picture");
    String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
    String uploadDir = getServletContext().getRealPath("") + File.separator + "images";

    Connection conn = null;
    PreparedStatement stmt = null;
    
    try {
        // Load JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/yourdbname", "yourusername", "yourpassword");

        // Save file to server
        File uploadFile = new File(uploadDir, fileName);
        try (InputStream fileContent = filePart.getInputStream()) {
            Files.copy(fileContent, uploadFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
        }

        // Update profile information
        String sql = "UPDATE tutors SET profile_picture = ?, course_description = ? WHERE id = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, fileName);
        stmt.setString(2, courseDescription);
        stmt.setInt(3, (Integer) session.getAttribute("tutor_id"));

        int rowsUpdated = stmt.executeUpdate();
        if (rowsUpdated > 0) {
            response.sendRedirect("profile-update-success.html");
        } else {
            response.sendRedirect("update-profile.jsp?error=true");
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("update-profile.jsp?error=true");
    } finally {
        if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>