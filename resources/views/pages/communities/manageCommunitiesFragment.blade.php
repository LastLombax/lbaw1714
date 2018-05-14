<?php
 

$query = \App\Http\Controllers\CommunityController::memberManageCommunities();
;

$communitiesLink = route('communities');
foreach ($query as $community){
  $link = $communitiesLink . '/' . $community->idcommunity;
  echo '
	<div class="col-lg-4">
     <div class="bs-ccomponent">
       	  <div class="card mb-4">
        	 <h3 class="card-header" style="border-bottom: 10px solid #158cb8">' .$community->name . '</h3>
	         <div class="card-body">
	           <h6 class="card-subtitle text-muted">';
	             echo $community->numMembers() . ' members'; //erro porque $community nao é um Model. How to fix?
	       echo'
          </h6>
	         </div>
             <img style="width: 100%; height: 200px; object-fit: cover;" src="'. Storage::url($community->imagepath) .'" alt="Card image" title="">
              <div class="card-body">
                <p class="card-text">'.$community->description.'</p>
              </div>
              <div class="card-footer text-muted">';
 				 echo "<a href=\"$link\"> Open community</a>";
 				 echo'
              </div>
          </div>
       </div>
   </div>
';
}


?>