<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<title>@yield('title')</title>

<link rel="shortcut icon" type="image/png" href="/icon/favicon.png" />
<script defer src="/js/scriptSearch.js"></script>

<!-- Bootstrap -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<link href="/css/bootstrap.min.css" rel="stylesheet">
<script src="/js/bootstrap.min.js"></script>


<!-- FontAwesome -->
<script defer src="https://use.fontawesome.com/releases/v5.0.8/js/all.js"></script>
<!-- GoogleImports -->
<link href="https://fonts.googleapis.com/css?family=Salsa" rel="stylesheet">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

<style type="text/css">
    .search {
        position: relative;
        color: #aaa;
        font-size: 16px;
    }

    .search input {
        width: 250px;
        height: 32px;

        background: #fcfcfc;
        border: 1px solid #aaa;
        border-radius: 5px;
        box-shadow: 0 0 3px #ccc, 0 10px 15px #ebebeb inset;
    }

    .search input { text-indent: 32px;}
    .search .fa-search {
        position: absolute;
        top: 10px;
        left: 10px;
    }
</style>