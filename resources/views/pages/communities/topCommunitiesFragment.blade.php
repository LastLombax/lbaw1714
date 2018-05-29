<?php

use Illuminate\Support\Facades\Auth;


$query = \App\Http\Controllers\CommunityController::topCommunities(4,0);

$first = $query[0];
$communitiesLink = route('communities');

$link = $communitiesLink . '/' .$first->idcommunity;

echo '<div class="card-body">';
echo '<h5 class="card-title" style="font-size: 1.2em "><a href="' . $link . '" >' . $first->name . '</a></h5>';
echo '<h6 class="card-subtitle text-muted ">'. $first->attendants .' members</h6>';
echo '</div>';

echo '<img style="width: 100%; height: 200px; object-fit: cover; " src="'.$first->imagepath.' " alt="Community image ">
        <div class="card-body ">
            <p class="card-text ">'. $first->description .'</p>
        </div>';
echo '<ul class="list-group list-group-flush">';

$i = 0;
foreach ($query as $community){
    $i++;
    if($i != 1)
    {
        echo '<li class="list-group-item" style="font-size: 1.2em">';
        $link = $communitiesLink . '/' .$community->idcommunity;
        echo "<a href=\"$link\"> $community->name</a>";
        echo '</li>';
    }
}

echo '</ul>';


echo '<div class="card-footer text-muted">';
if (Auth::guest())
			$communitiesLink = route('basicCommunitiesSearch');
echo "<a href=\"$communitiesLink\" class=\"card-link\">More communities</a>";
echo '</div>';
?>

