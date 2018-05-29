
function addEventListners() {
    let editBtns = document.querySelectorAll(".editComment");

    let deleteBtns = document.querySelectorAll(".deleteComment");

    for (let i = 0; i < editBtns.length; i++) {
        editBtns[i].addEventListener('click', function () {
            let idComment = editBtns[i].querySelector('.comment-id').innerHTML;
            console.log("EDITAR " + idComment);

        });
    }

    for (let i = 0; i < deleteBtns.length; i++) {
        console.log(deleteBtns[i]);
        //let commentID = deleteBtns[i].querySelector(".comment-id");
        deleteBtns[i].addEventListener('click', function (event) {
            let idComment = deleteBtns[i].querySelector('.comment-id').innerHTML;
            console.log("DELETE " + idComment);

            let request = new XMLHttpRequest();

            request.open('DELETE', siteRoot + '/ajax/events/comment/', true);

            //request.setRequestHeader('X-HTTP-METHOD-OVERRIDE', 'DELETE');
            request.setRequestHeader('X-CSRF-TOKEN', document.querySelector('meta[name="csrf-token"]').content);
            request.setRequestHeader("Content-type", "application/json");

            request.addEventListener('load', commentsRefresh);

            let data = {
                'idComment': idComment
            };
            request.send(JSON.stringify(data));
        });
    }
}


// Run refresh every 5s
//window.setInterval(commentsRefresh, 5000);

window.addEventListener('load', commentsRefresh);


function commentsRefresh() {
    let idEvent = document.querySelector("#eventID").innerHTML;

    let request = new XMLHttpRequest();
    request.open('GET', siteRoot + '/ajax/events/comments?idEvent=' + idEvent, true);

    request.setRequestHeader('X-CSRF-TOKEN', document.querySelector('meta[name="csrf-token"]').content);

    request.addEventListener('load', displayComments);

    request.send();

}

function displayComments() {
    let comments = JSON.parse(this.responseText);

    let container = document.querySelector('#comments-container');

    container.innerHTML = "";

    comments.forEach(function (comment) {
        let commentDiv = document.createElement("div");

        commentDiv.class ="list-group-item list-group-item-action flex-column align-items-start";


        let commentStr = "<div class=\"list-group-item list-group-item-action flex-column align-items-start\">" +
            "   <div class=\"d-flex w-100 justify-content-between\">" +
            "            <a href=\"/members/" + comment.username +"\">\n" +
            "               <h5 class=\"mb-1\">" + comment.authorName + "</h5>" +
            "            </a>";

        if(comment.isAuthor) {
            commentStr +=
                "        <div class=\"commentActions\" style=\"font-size: 18px; text-align: right; color: #999\">\n" +
                "            <button class=\"editComment\" onmouseenter=\"this.style.color='#222'\" onmouseleave=\"this.style.color='#444'\" style=\"cursor: pointer; color:#444;\">\n" +
                "               <i class=\"fas fa-pencil-alt\"></i>\n" +
                "               <span class=\"comment-id\"\n" +
                "               style=\"display: none\">" + comment.idcomment + "</span>\n" +
                "           </button>\n" +
                "           <button class=\"deleteComment\" onmouseenter=\"this.style.color='#222'\" onmouseleave=\"this.style.color='#444'\" style=\"cursor: pointer; color:#444;\"\">\n" +
                "            <i class=\"fas fa-trash-alt\"></i>\n" +
                "            <span class=\"comment-id\"\n" +
                "               style=\"display: none\">" + comment.idcomment + "</span>\n" +
                "           </button>\n" +
                "        </div>\n";
        }
        commentStr +=
            "   </div>\n" +
            "   <p class=\"mb-1\">" + comment.text  + "</p>\n" +
            "   <small> " + comment.date + "</small>\n" +
            "   </div>\n";

        commentDiv.innerHTML += commentStr;
        container.appendChild(commentDiv);

    });

    addEventListners();
}
// Get the input field
let commentInput = document.getElementById("createComment");

commentInput.addEventListener("keyup", function(event) {

  if (event.keyCode === 13) {
    let siteRoot = document.location.origin;

    let request = new XMLHttpRequest();

    request.open('POST', siteRoot + '/ajax/events/comment', true);

    request.setRequestHeader('X-CSRF-TOKEN', document.querySelector('meta[name="csrf-token"]').content);
    request.setRequestHeader("Content-type", "application/json");

    request.addEventListener('load', commentsRefresh);

    let idEvent = document.querySelector("#eventID").innerHTML;
    let data = {'idEvent': idEvent,
                'text':  commentInput.value};

    commentInput.value = "";//Deletes input value

    request.send(JSON.stringify(data));

    event.preventDefault();

  }

});


