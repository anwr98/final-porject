<%@ page import="java.sql.*" %>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/coding_courses", "root", "");
        Statement stmt = con.createStatement();

        String query = "SELECT * FROM tutors WHERE username='" + username + "' AND password='" + password + "'";
        ResultSet rs = stmt.executeQuery(query);

        if (rs.next()) {
            response.sendRedirect("profile-" + username.toLowerCase() + ".html");
        } else {
            out.println("Invalid username or password.");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("Error: " + e.getMessage());
    }
%>
