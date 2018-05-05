let editBtns = document.querySelectorAll(".editComment");

let delteBtns = document.querySelectorAll(".deleteComment");

for(let i = 0; i < editBtns.length; i++){
    editBtns[i].addEventListener('click', function (event) {
        console.log("EDITAR!!!!!");
        console.log(event);
    }) ;
}

for(let i = 0; i < editBtns.length; i++){
    delteBtns[i].addEventListener('click', function (event) {
        console.log("APAGAR!!!!!");

        console.log(event);
    }) ;
}


//Todo create event and show event ajax call scripts