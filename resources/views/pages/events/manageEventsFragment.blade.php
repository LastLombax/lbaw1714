<?php
 

$query = \App\Http\Controllers\EventController::memberManageEvents();


$eventsLink = route('events');
foreach ($query as $event){
  $link = $eventsLink . '/' . $event->idevent;
  echo '
	<div class="col-lg-4">
     <div class="bs-ccomponent">
       	  <div class="card mb-4">
        	 <h3 class="card-header" style="border-bottom: 10px solid #158cb8">' .$event->name . '</h3>
	         <div class="card-body">
	           <h6 class="card-subtitle text-muted">';
	          
	          $start = strtotime($event->startday);
		      $end = strtotime($event->endday);
		      if ($start == $end) 
		          echo date('F d, Y', $start);
		      else 
		          echo date('F d, Y', $start) . ' - ' . date('F d, Y', $end);
		       
	          	echo ' </h6>
	         </div>
             <img style="width: 100%; height: 200px; object-fit: cover;" src="'.$event->imagepath.'" alt="Card image" title="">
              <div class="card-body">
                <p class="card-text">'.$event->description.'</p>
              </div>
              <div class="card-footer text-muted">';
 				 echo "<a href=\"$link\"> Open Event</a>";
 				 echo'
              </div>
          </div>
       </div>
   </div>
';
}


?>