<script>

    function initMap() {

        let address = document.getElementById('address').innerHTML;
        let country = document.getElementById('country').innerHTML;



        let requestURL = 'https://maps.googleapis.com/maps/api/geocode/json?address=' +
            address + ',+CA&key=AIzaSyAr1_x1qNGarZz3rVGBTmTk2yDOAA-jkOI';

        console.log(requestURL);

        let request = new XMLHttpRequest();
        request.open('GET', requestURL);

        request.responseType = 'json';
        request.send();
        request.addEventListener('load', data = received);


        function received() {
            let data = request.response;


            let uluru;
            if(data.results.length !== 0)
                uluru = {lat: data.results[0].geometry.location.lat, lng: data.results[0].geometry.location.lng};
            else
                uluru = {lat: 0, lng: 0};

            let map = new google.maps.Map(document.getElementById('map'), {
                zoom: 4,
                center: uluru
            });
            let marker = new google.maps.Marker({
                position: uluru,
                map: map
            });
        }
    }
</script>