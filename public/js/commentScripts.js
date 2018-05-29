let editBtns = document.querySelectorAll(".editComment");

let deleteBtns = document.querySelectorAll(".deleteComment");
console.log(deleteBtns);

for(let i = 0; i < editBtns.length; i++){
    editBtns[i].addEventListener('click', function () {
        let idComment =  editBtns[i].querySelector('.comment-id').innerHTML;
        console.log("EDITAR " + idComment);

    }) ;
}

for(let i = 0; i < deleteBtns.length; i++){
    console.log(deleteBtns[i]);
    //let commentID = deleteBtns[i].querySelector(".comment-id");
    deleteBtns[i].addEventListener('click', function (event) {
        let idComment =  deleteBtns[i].querySelector('.comment-id').innerHTML;
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

// Run refresh every 5s
window.setInterval(commentsRefresh, 5000);


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

    })
}

//Todo create event and show event ajax call scripts