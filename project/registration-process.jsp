<%@ page import="java.sql.*" %>
<%
    String name = request.getParameter("name");
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String specialization = request.getParameter("specialization");

    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        // Load JDBC driver (replace with your database driver)
        Class.forName("com.mysql.cj.jdbc.Driver");
        
        // Establish connection (replace with your DB URL, username, and password)
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/yourdbname", "yourusername", "yourpassword");
        
        // Query to insert new tutor (modify according to your schema)
        String sql = "INSERT INTO tutors (name, username, password, specialization) VALUES (?, ?, ?, ?)";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, name);
        stmt.setString(2, username);
        stmt.setString(3, password);
        stmt.setString(4, specialization);
        
        int rowsInserted = stmt.executeUpdate();

        if (rowsInserted > 0) {
            // Registration successful
            response.sendRedirect("login.html");
        } else {
            // Registration failed
            response.sendRedirect("registration.html?error=true");
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("registration.html?error=true");
    } finally {
        // Close resources
        if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>