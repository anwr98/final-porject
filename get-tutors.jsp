<%@ page import="java.sql.*" %>
<%@ page contentType="application/json" %>
<%
    String course = request.getParameter("course");

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/coding_courses", "root", "");
        Statement stmt = con.createStatement();

        String query = "SELECT * FROM tutors WHERE course='" + course + "'";
        ResultSet rs = stmt.executeQuery(query);

        out.print("[");
        boolean first = true;
        while (rs.next()) {
            if (!first) {
                out.print(",");
            } else {
                first = false;
            }
            out.print("{");
            out.print("\"name\":\"" + rs.getString("name") + "\",");
            out.print("\"description\":\"" + rs.getString("description") + "\",");
            out.print("\"profilePic\":\"" + rs.getString("profilePic") + "\"");
            out.print("}");
        }
        out.print("]");
    } catch (Exception e) {
        e.printStackTrace();
        out.println("[]");
    }
%>

