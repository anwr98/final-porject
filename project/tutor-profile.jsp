<%@ page import="java.sql.*, java.util.*" %>

<%
    // Get the tutor ID from the query parameter
    String tutorId = request.getParameter("tutorId");

    if (tutorId == null) {
        response.sendRedirect("html-tutors.jsp"); // Redirect to the tutors list if no tutor ID is provided
        return;
    }

    // Fetch the tutor's details from the database using the tutorId
    String tutorName = "", tutorPhone = "", tutorNotes = "", tutorProfilePic = "";
    double averageRating = 0;
    int totalRatings = 0;

    // Initialize the comments list
    List<String> comments = new ArrayList<>();

    try {
        Class.forName("com.mysql.jdbc.Driver");

        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/coding_courses?enabledTLSProtocols=TLSv1.2", "root", "0503089535a")) {

            // Fetch tutor details (excluding rating)
            String sql = "SELECT name, phone, notes, profilePic FROM tutors WHERE id = ?";
            try (PreparedStatement stmt = con.prepareStatement(sql)) {
                stmt.setString(1, tutorId);
                ResultSet rs = stmt.executeQuery();

                if (rs.next()) {
                    tutorName = rs.getString("name");
                    tutorPhone = rs.getString("phone");
                    tutorNotes = rs.getString("notes");
                    tutorProfilePic = rs.getString("profilePic");
                } else {
                    response.sendRedirect("html-tutors.jsp"); // Redirect if tutor not found
                    return;
                }
            }

            // Fetch comments for the tutor
            String commentSql = "SELECT comment FROM comments WHERE tutor_id = ?";
            try (PreparedStatement commentStmt = con.prepareStatement(commentSql)) {
                commentStmt.setInt(1, Integer.parseInt(tutorId)); // Use Integer.parseInt() if tutorId is stored as an INT
                ResultSet commentRs = commentStmt.executeQuery();

                while (commentRs.next()) {
                    comments.add(commentRs.getString("comment"));
                }
            }

            // Fetch average rating and total ratings count
            String ratingSql = "SELECT AVG(rating) AS avgRating, COUNT(rating) AS totalRatings FROM ratings WHERE tutor_id = ?";
            try (PreparedStatement ratingStmt = con.prepareStatement(ratingSql)) {
                ratingStmt.setInt(1, Integer.parseInt(tutorId));
                ResultSet ratingRs = ratingStmt.executeQuery();

                if (ratingRs.next()) {
                    averageRating = ratingRs.getDouble("avgRating");
                    totalRatings = ratingRs.getInt("totalRatings");
                }
            }

        }
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile of <%= tutorName %></title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <header>
        <div id="logo-container">
            <img src="images/logo.png" alt="Courses Online" id="logo" onclick="location.href='index.html';">
        </div>
        <nav>
            <ul>
                <li><a href="index.html">Home</a></li>
                <li><a href="about.html">About Us</a></li>
                <li><a href="courses.html">Our Courses</a></li>
                <li><a href="contact.html">Contact Us</a></li>
            </ul>
        </nav>
    </header>

    <main>
        <h1>Profile of <%= tutorName %></h1>
        <div class="tutor-profile">
            <img src="<%= tutorProfilePic != null ? tutorProfilePic : "images/default.png" %>" alt="<%= tutorName %>" class="profile-picture-large">
            <p><strong>Phone Number:</strong> <a href="tel:<%= tutorPhone %>"><%= tutorPhone %></a></p>
            <p><strong>About Me:</strong> <%= tutorNotes != null ? tutorNotes : "No notes available." %></p>

            <!-- Display Average Rating -->
            <h2>Average Rating:</h2>
            <p><strong><%= averageRating %> / 5</strong> based on <%= totalRatings %> ratings.</p>

            <!-- Rating Form -->
            <h2>Rate this Tutor:</h2>
            <form id="ratingForm" action="rate-tutor.jsp" method="post">
                <input type="hidden" name="tutorId" value="<%= tutorId %>">
                <label for="rating">Rate this tutor:</label>
                <select name="rating" id="rating" required>
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                    <option value="5">5</option>
                </select>
                <button type="submit">Submit Rating</button>
            </form>

            <!-- Comment Form -->
            <form id="commentForm" action="add-note.jsp" method="post">
                <input type="hidden" name="tutorId" value="<%= tutorId %>">
                <label for="note">Add a Comment:</label>
                <textarea name="note" id="note" rows="4" required></textarea>
                <button type="submit">Add Comment</button>
            </form>

            <!-- Display Existing Comments -->
            <h2>Comments:</h2>
            <% if (comments.isEmpty()) { %>
                <p>No comments found for this tutor.</p>
            <% } else { %>
                <ul>
                <% for (String comment : comments) { %>
                    <li><%= comment %></li>
                <% } %>
                </ul>
            <% } %>

        </div>
    </main>

    <footer>
        <div class="footer-content">
            <p>Follow us:</p>
            <a href="https://facebook.com" target="_blank"><i class="fab fa-facebook"></i></a>
            <a href="https://twitter.com" target="_blank"><i class="fab fa-twitter"></i></a>
            <a href="https://instagram.com" target="_blank"><i class="fab fa-instagram"></i></a>
        </div>
    </footer>
</body>
</html>
