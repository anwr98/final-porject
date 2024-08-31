<%@ page import="java.sql.*, java.io.*, javax.servlet.*, javax.servlet.http.*, java.util.*" %>

<%
    String courseName = request.getParameter("courseName");

    // Debugging output to check if courseName is retrieved
    System.out.println("Received Course Name: " + courseName);

    // Set a default course name if the input is null or empty
    if (courseName == null || courseName.trim().isEmpty()) {
        courseName = "Default Course Name";
    }
    

    Part courseImagePart = request.getPart("courseImage");
    String contentDisposition = courseImagePart.getHeader("content-disposition");
    String[] tokens = contentDisposition.split(";");
    String imageName = null;
    for (String token : tokens) {
        if (token.trim().startsWith("filename")) {
            imageName = token.substring(token.indexOf('=') + 2, token.length() - 1);
            break;
        }
    }

    // Handle the case where the image is not provided
    if (imageName == null || imageName.trim().isEmpty()) {
        imageName = "default-image.png"; // Provide a default image name
    }

    String imagePath = "images/" + imageName;
    
    try {
        // Save the uploaded image to the server
        String uploadPath = application.getRealPath("/") + imagePath;
        File file = new File(uploadPath);

        // Create directories if they do not exist
        if (!file.getParentFile().exists()) {
            file.getParentFile().mkdirs();
        }

        try (InputStream input = courseImagePart.getInputStream();
             OutputStream output = new FileOutputStream(file)) {
            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = input.read(buffer)) != -1) {
                output.write(buffer, 0, bytesRead);
            }
        }

        // Insert course data into the database
        Class.forName("com.mysql.jdbc.Driver");
        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/coding_courses?enabledTLSProtocols=TLSv1.2", "root", "0503089535a")) {
            String sql = "INSERT INTO courses (course_name, image_path) VALUES (?, ?)";
            try (PreparedStatement stmt = con.prepareStatement(sql)) {
                stmt.setString(1, courseName);
                stmt.setString(2, imagePath);

                stmt.executeUpdate();
            }
        }

        // Redirect to the admin dashboard with a success message
        response.sendRedirect("admin-dashboard.jsp?success=true");

    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
        out.println("An error occurred while adding the course: " + e.getMessage());
    } catch (IOException e) {
        e.printStackTrace();
        out.println("An error occurred while uploading the image: " + e.getMessage());
    }
%>
