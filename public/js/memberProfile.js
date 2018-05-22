let befriendBtn = document.querySelector("#befriendBtn");

befriendBtn.addEventListener('click', function (event) {
    let siteRoot = document.location.origin; //"http://localhost:8000/"
    let friendUsername = "teste";

    let request = new XMLHttpRequest();
    request.open('post', siteRoot + '/buddies/add/' + encodeForAjax({'friend': friendUsername}), true);

    request.setRequestHeader("Content-type", "application/x-www-form-urlencoded");

    request.addEventListener('load', function () {
        let answer = JSON.parse(this.responseText);
        console.log(answer);

        request.classList.add("display: none");
    });

    request.send();

    event.preventDefault();
});

