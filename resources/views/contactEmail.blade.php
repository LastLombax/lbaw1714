<html>
    <head>
        <title>ReEvent</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <link href="https://fonts.googleapis.com/css?family=Salsa" rel="stylesheet">
    </head>
<body>
    <div class="container">
        <h1 style="font-family: 'Salsa'; color: #008cba;">Re</h1>
        <h3>Message received from website contact form</h3>
        <p><strong>Sender:</strong> {{$name}} &lt;{{$email}}&gt;</p>
        <p>{{$content}}</p>
    </div>
</body>
</html>