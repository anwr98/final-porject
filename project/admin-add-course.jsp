<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Course</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <header>
        <div id="logo-container">
            <img src="images/logo.png" alt="Courses Online" id="logo" onclick="location.href='index.jsp';">
        </div>
        <nav>
            <ul>
                <li><a href="admin-dashboard.jsp">Dashboard</a></li>
                <li><a href="logout.jsp">Logout</a></li>
            </ul>
        </nav>
    </header>

    <main>
        <h1>Add New Course</h1>
        <form action="admin-add-course-process.jsp" method="post" enctype="multipart/form-data">
            <label for="courseName">Course Name:</label>
            <input type="text" id="courseName" name="courseName" required>
        
            <label for="courseImage">Course Image:</label>
            <input type="file" id="courseImage" name="courseImage" accept="image/*" required>
        
            <button type="submit">Add Course</button>
        </form>
        
        
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
