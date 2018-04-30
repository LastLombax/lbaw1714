let imgPath = document.querySelector('#imagePath');
let imgTag = document.querySelector('#imgField img');
console.log(imgPath);


imgPath.addEventListener('change', function () {
    console.log("Entrou");
    console.log("DEBUG: " + "\"src=\"" + imgPath.value + "\"");

        if (typeof (FileReader) != "undefined") {
            $("#dvPreview").show();
            $("#dvPreview").append("<img />");
            var reader = new FileReader();
            reader.onload = function (e) {
                imgTag.setAttribute("src", e.target.result);
                // $("#dvPreview img").attr("src", e.target.result);
            }
            reader.readAsDataURL($(this)[0].files[0]);
        } else {
            alert("This browser does not support FileReader.");
        }

});
