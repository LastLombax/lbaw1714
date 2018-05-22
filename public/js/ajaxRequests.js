let siteRoot = document.location.origin; //"http://localhost:8000/"

function ajax(type, url, data, onSuccess, onFailure) {
    let request = new XMLHttpRequest();

    if(onSuccess == null)
        return;

    if(type === "GET")
    request.open('type', siteRoot + '/' + url + encodeForAjax(data), true);

    request.addEventListener('load', onSuccess);
}

function encodeForAjax(data) {
    return Object.keys(data).map(function(k){
        return encodeURIComponent(k) + '=' + encodeURIComponent(data[k])
    }).join('&');
}