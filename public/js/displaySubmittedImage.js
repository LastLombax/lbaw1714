let fileName = document.querySelector('#imagePath').value;

fileName.addEventListener('submit', function () {
    let imgTag = document.createElement('img');
    imgTag.className += "src=\"" + fileName.value + "\"";

    console.log("DEBUG: " + "\"src=\\\"\" + fileName.value + \"\\\"\"");
    let imgField = document.querySelector('#imgField');
    imgField.appendChild(imgTag);
});
