<%@ page import="java.sql.*" %>
<%
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String course = request.getParameter("course");

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/coding_courses", "root", "");
        Statement stmt = con.createStatement();

        String query = "INSERT INTO tutors (name, email, username, password, course) VALUES ('" + name + "', '" + email + "', '" + username + "', '" + password + "', '" + course + "')";
        stmt.executeUpdate(query);

        response.sendRedirect("login.html");
    } catch (Exception e) {
        e.printStackTrace();
        out.println("Error: " + e.getMessage());
    }
%>
