<%@ page import="java.sql.*" %>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        // Load JDBC driver (replace with your database driver)
        Class.forName("com.mysql.jdbc.Driver");
        
        // Establish connection (replace with your DB URL, username, and password)
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "0503089535a");
        
        // Query to check credentials (modify according to your schema)
        String sql = "SELECT * FROM users WHERE username=? AND password=?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, username);
        stmt.setString(2, password);
        
        rs = stmt.executeQuery();

        if (rs.next()) {
            // Authentication successful, redirect to tutor's profile page
            session.setAttribute("tutor_id", rs.getInt("id")); // Store tutor ID in session
            response.sendRedirect("tutor-profile.jsp"); // Redirect to profile page
        } else {
            // Authentication failed
            response.sendRedirect("login.html?error=true");
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("login.html?error=true");
    } finally {
        // Close resources
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>