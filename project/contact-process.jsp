<%@ page import="java.sql.*" %>
<%
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String message = request.getParameter("message");

    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/yourdbname", "root", "yourpassword");

        // Query to insert contact message
        String sql = "INSERT INTO contact_messages (name, email, message) VALUES (?, ?, ?)";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, name);
        stmt.setString(2, email);
        stmt.setString(3, message);
        
        int rowsInserted = stmt.executeUpdate();

        if (rowsInserted > 0) {
            response.sendRedirect("contact-us.html?success=true");
        } else {
            response.sendRedirect("contact-us.html?error=true");
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("contact-us.html?error=true");
    } finally {
        if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
