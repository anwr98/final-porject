// Example to populate dynamic content
document.addEventListener('DOMContentLoaded', function() {
    // Simulating dynamic data
    document.getElementById('institutions-count').innerText = '500';
    document.getElementById('subjects-count').innerText = '200';
    document.getElementById('teachers-count').innerText = '1500';
});
document.addEventListener('DOMContentLoaded', function() {
    const likeButton = document.getElementById('like-button');
    const dislikeButton = document.getElementById('dislike-button');
    const likeCountElem = document.getElementById('like-count');
    const dislikeCountElem = document.getElementById('dislike-count');

    // Example to populate dynamic like/dislike counts
document.addEventListener('DOMContentLoaded', function() {
    // Simulating dynamic data
    document.getElementById('like-count').innerText = '100'; // Replace with actual value
    document.getElementById('dislike-count').innerText = '10'; // Replace with actual value
});

    

    function updateCount(type) {
        const xhr = new XMLHttpRequest();
        xhr.open('POST', 'update-feedback.jsp', true);
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                if (xhr.status === 200) {
                    const response = JSON.parse(xhr.responseText);
                    likeCountElem.textContent = Likes: ${response.likes};
                    dislikeCountElem.textContent = Dislikes: ${response.dislikes};
                } else {
                    console.error('Error updating count');
                }
            }
        };
        xhr.send(type=${type});
    }
});