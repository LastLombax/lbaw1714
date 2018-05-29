<?php
 
 use App\Community;

$query = \App\Http\Controllers\CommunityController::memberManageCommunities();


$communitiesLink = route('communities');

if (sizeof($query) == 0){
  $communitiesLink = $communitiesLink . '/create';

  echo '
          <div class="bs-ccomponent">
              <div class="card mb-4" style="box-shadow: 1px 1px 30px #ddd;">
                <div class="card-body">   
                  You do not own any community. Start by creating one'; echo "<a href=\" $communitiesLink \"> here</a>.";

 echo'         </div>
              </div>
              </div>';

}


foreach ($query as $community){
  $community = Community::find($community->idcommunity);
  
  $link = $communitiesLink . '/' . $community->idcommunity;
  echo '
	<div class="col-lg-4">
     <div class="bs-ccomponent">
       	  <div class="card mb-4">
        	 <h3 class="card-header" style="border-bottom: 10px solid #158cb8">' .$community->name . '</h3>
	         <div class="card-body">
	           <h6 class="card-subtitle text-muted">';
	             echo $community->numMembers() . ' members'; 
	       echo'
          </h6>
	         </div>
             <img style="width: 100%; height: 200px; object-fit: cover;" src="'. Storage::url($community->imagepath) .'" alt="Community image" title="">
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