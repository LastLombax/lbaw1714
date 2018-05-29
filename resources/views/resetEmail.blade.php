<html>
    <head>
        <title>ReEvent</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    </head>
<body>
    <div class="container">
        <h1>Message received from website contact form</h1>

        <p><strong>Name:</strong> {{$name}}</p>
        <p><strong>Email address:</strong> {{$email}}</p>
        <p><strong>Content:</strong> {{$content}}</p>

        {{-- <form action="">
            <div class="form-group {{ $errors->has('name') ? 'has-error' : '' }}">
                <label for="name">Name:</label>
                <input type="text" name="name">
                <span class="text-danger">{{ $errors->first('name') }}</span>
            </div>

            <div class="form-group {{ $errors->has('email') ? 'has-error' : '' }}">
                <label for="email">Email:</label>
                <input type="email" name="email" placeholder="example@example.com">
                <span class="text-danger">{{ $errors->first('email') }}</span>
            </div>

            <div class="form-group {{ $errors->has('message') ? 'has-error' : '' }}">
                <label for="message">Message:</label>
                <textarea name="message" placeholder="Enter message..."></textarea>
                <span class="text-danger">{{ $errors->first('message') }}</span>
            </div>

            <div class="form-group">
                <button class="btn btn-success">Contact US!</button>
            </div>
        </form> --}}
    </div>
</body>
</html>