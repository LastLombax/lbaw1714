let siteRoot = document.location.origin; //"http://localhost:8000/"

let insertCommentBt = document.querySelector('#insertCommentBt');
insertCommentBt.addEventListener('click', insertComment);

let commentContainers;

let refreshFlag = true;

function addEventListeners() {
    let editBtns = document.querySelectorAll(".editComment");

    let deleteBtns = document.querySelectorAll(".deleteComment");

    commentContainers = document.querySelectorAll(".commentDiv");

    for (let i = 0; i < editBtns.length; i++) {
        editBtns[i].addEventListener('click', function(){

            refreshFlag = !refreshFlag;

            if(refreshFlag) //If disabled edit mode
                return commentsRefresh();

            let idComment = deleteBtns[i].querySelector('.comment-id').innerHTML;



            let commentMessage = commentContainers[i].querySelector(".commentText");

            commentMessage.innerHTML = '<input type="text" name="comment">';

            commentMessage.addEventListener('keyup', sendEditComment.bind(idComment));
        });
    }

    for (let i = 0; i < deleteBtns.length; i++) {

        deleteBtns[i].addEventListener('click', function () {

            refreshFlag = true;

            let idComment = deleteBtns[i].querySelector('.comment-id').innerHTML;


            let request = new XMLHttpRequest();

            request.open('DELETE', siteRoot + '/ajax/events/comment/', true);

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

function sendEditComment(event) {

    let idComment = this;

    if (event.keyCode !== 13)
        return;

    let commentText = document.querySelector(".commentDiv input").value;


    let request = new XMLHttpRequest();

    request.open('PATCH', siteRoot + '/ajax/events/comment/', true);

    request.setRequestHeader('X-CSRF-TOKEN', document.querySelector('meta[name="csrf-token"]').content);
    request.setRequestHeader("Content-type", "application/json");

    request.addEventListener('load', commentsRefresh);

    refreshFlag = true;

    let data = {
        'idComment': idComment,
        'commentText': commentText
    };
    request.send(JSON.stringify(data));

}


// Run refresh every 5s
window.setInterval(commentsRefresh, 5000);

window.addEventListener('load', commentsRefresh);


function commentsRefresh() {

    if(!refreshFlag)
        return;

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


        let commentStr = "<div class=\"commentDiv list-group-item list-group-item-action flex-column align-items-start\">" +
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
            "   <p class=\"mb-1 commentText\">" + comment.text  + "</p>\n" +
            "   <small> " + comment.date + "</small>\n" +
            "   </div>\n";

        commentDiv.innerHTML += commentStr;
        container.appendChild(commentDiv);

    });

    addEventListeners();
}
// Get the input field
let commentInput = document.getElementById("createComment");

commentInput.addEventListener("keyup", insertComment);



function insertComment(event) {
    event.preventDefault();

    refreshFlag = true;

    if (event.keyCode === 13 || event.type === "click") {
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
    }
}