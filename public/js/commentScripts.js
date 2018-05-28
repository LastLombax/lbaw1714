let editBtns = document.querySelectorAll(".editComment");

let deleteBtns = document.querySelectorAll(".deleteComment");
console.log(deleteBtns);

for(let i = 0; i < editBtns.length; i++){
    editBtns[i].addEventListener('click', function () {
        let idEvent =  editBtns[i].querySelector('.comment-id').innerHTML;
        console.log("EDITAR " + idEvent);


    }) ;
}

for(let i = 0; i < deleteBtns.length; i++){
    console.log(deleteBtns[i]);
    //let commentID = deleteBtns[i].querySelector(".comment-id");
    deleteBtns[i].addEventListener('click', function (event) {
        let idEvent =  deleteBtns[i].querySelector('.comment-id').innerHTML;
        console.log("DELETE " + idEvent);
    });
}


//Todo create event and show event ajax call scripts