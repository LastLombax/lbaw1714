let editBtns = document.querySelectorAll(".editComment");

let deleteBtns = document.querySelectorAll(".deleteComment");
console.log(deleteBtns);

for(let i = 0; i < editBtns.length; i++){
    editBtns[i].addEventListener('click', function (event) {
        console.log("EDITAR!!!!!");
        console.log(event);
    }) ;
}

for(let i = 0; i < deleteBtns.length; i++){
    console.log(deleteBtns[i]);
    //let commentID = deleteBtns[i].querySelector(".comment-id");
    deleteBtns[i].addEventListener('click', function (event) {
        console.log(commentID);
        console.log("APAGAR!!!!!");

        console.log(event);
    });
}


//Todo create event and show event ajax call scripts