<script>

    function initMap() {

        let address = document.getElementById('address').innerHTML;
        let country = document.getElementById('country').innerHTML;



        var requestURL = 'https://maps.googleapis.com/maps/api/geocode/json?address=' +
            address + ',+CA&key=AIzaSyAr1_x1qNGarZz3rVGBTmTk2yDOAA-jkOI';

        console.log(requestURL);

        var request = new XMLHttpRequest();
        request.open('GET', requestURL);

        request.responseType = 'json';
        request.send();
        request.addEventListener('load', data = received);


        function received() {
            let data = request.response;

            console.log(data);


            if(data.results.length != 0)
                var uluru = {lat: data.results[0].geometry.location.lat, lng: data.results[0].geometry.location.lng};
            else
                var uluru = {lat: 0, lng: 0};

            var map = new google.maps.Map(document.getElementById('map'), {
                zoom: 4,
                center: uluru
            });
            var marker = new google.maps.Marker({
                position: uluru,
                map: map
            });
        }
    }
</script>