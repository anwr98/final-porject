<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.SQLException" %>
<%@ page import="java.io.File, java.io.IOException, java.io.InputStream, java.io.InputStreamReader, java.io.BufferedReader" %>
<%@ page import="javax.servlet.http.Part" %>
<%@ page import="javax.servlet.ServletException" %>

<%
    // Retrieve the tutor ID from the session
    String tutorId = (String) session.getAttribute("tutorId");
    
    // Initialize variables for form data
    String notes = null;
    String profilePicPath = null;
    
    // Handle multipart form data (both text and file)
    try {
        // Extract notes from the form submission
        Part notesPart = request.getPart("notes");
        if (notesPart != null) {
            // Convert the InputStream of the notes part to a string manually
            StringBuilder notesBuilder = new StringBuilder();
            try (BufferedReader reader = new BufferedReader(new InputStreamReader(notesPart.getInputStream()))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    notesBuilder.append(line);
                }
            }
            notes = notesBuilder.toString().trim();
        }

        // Handle file upload if a file was submitted
        Part profilePic = request.getPart("profilePic");
        if (profilePic != null && profilePic.getSize() > 0) {
            String header = profilePic.getHeader("content-disposition");
            String fileName = header.substring(header.indexOf("filename=\"") + 10, header.lastIndexOf("\""));
            profilePicPath = "images/" + fileName;

            // Save the uploaded file to the specified directory
            File fileSaveDir = new File(application.getRealPath("/") + profilePicPath);
            profilePic.write(fileSaveDir.getAbsolutePath());
        }

        // Debug output to check the received values
        out.println("Notes: " + notes);
        out.println("Profile Picture Path: " + profilePicPath);

        // Update the database with the new notes and profile picture
        Class.forName("com.mysql.jdbc.Driver");
        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/coding_courses?enabledTLSProtocols=TLSv1.2", "root", "0503089535a")) {
            String sql = "UPDATE tutors SET notes = ?, profilePic = ? WHERE id = ?";
            try (PreparedStatement stmt = con.prepareStatement(sql)) {
                // Set the notes, or set null if they weren't provided
                stmt.setString(1, notes != null && !notes.isEmpty() ? notes : null);
                
                // Set the profile picture path, or set null if no picture was uploaded
                stmt.setString(2, profilePicPath != null ? profilePicPath : null);
                
                // Set the tutor ID for the WHERE clause
                stmt.setString(3, tutorId);
                
                int rowsUpdated = stmt.executeUpdate();
                out.println(rowsUpdated + " rows updated."); // Debugging output
            }
        }

        // Redirect back to the profile page after successful update
        response.sendRedirect("profile.jsp");

    } catch (SQLException e) {
        e.printStackTrace();
        out.println("SQL Error: " + e.getMessage());
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
        out.println("Error: MySQL Driver not found.");
    } catch (IOException e) {
        e.printStackTrace();
        out.println("File Upload Error: " + e.getMessage());
    } catch (ServletException e) {
        e.printStackTrace();
        out.println("Servlet Error: " + e.getMessage());
    }
%>
