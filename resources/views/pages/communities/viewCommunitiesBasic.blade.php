@extends('layout')

@section('content')

<?php

echo '  
           
       <legend style=" color: #333; padding: 20px; margin-left: 0; padding-left: 0;">
       
           <i class="fas fa-calendar-check" ></i>
           <span style="margin-left: .5rem;">
           Search Results</span>
      
                </legend>
        ';

if (sizeof($communities) == 0)
echo '
        <div class="bs-ccomponent">
        <div class="card mb-4" style="box-shadow: 1px 1px 30px #ddd;">
            <div class="card-body">   
                There is no community!
        </div>
        </div>';

echo '<div class="row justify-content-center align-items-center">  ';


foreach ($communities as $community){
    $image = '/storage/' . $community->imagepath;
    $link = '/communities/' . $community->idcommunity;
   echo'
   <br>
        <div class="col-lg-4 align-self-start">' .
   '              <div class="bs-ccomponent">' .
   '                <div class="card mb-4" style="box-shadow: 1px 1px 30px #ddd;">' .
   '                  <div class="card-body">' .
   '                  <h3 class="card-title" style="background-color: #fff;"><a style="color: #000;" href="{{asset(\\\'communities/\' . $community->idcommunity .\'\\\')}}">' . $community->name . '</a></h3>' .
   '                  </div>
                      <img style="width: 100%; height: 200px; object-fit: cover;" src="' . $image . '" alt="community Image">' .
   '                  <div class="card-body">' .
   '                    <p class="card-text">'. $community->description .'</p>' .
   '                  </div>' .
   '                  <div class="card-footer text-muted" style="background-color: #fff; text-align: right;">' .
   '                    <a href="' . $link . '" class="card-link">Open community</a>' .
   '                  </div>' .
   '                </div>' .
   '              </div>' .
   '            </div>';
};

echo '</div>';
?>
@endsection