<?php

$query = \App\Http\Controllers\EventController::upcomingMemberEvents();


echo '<div id="time">';
echo '<section id=timeline>';
        echo '<div class="demo-card-wrapper">';

        $i = 0;

        foreach ($query as $event){
            $i++;

             echo ' <div class="demo-card demo-card--step' . $i . '">';
                echo '<div class="head">';
                    echo '<div class="number-box">';
                        echo '<span>0' . $i . '</span>';
                    echo '</div>';
                    if(strlen($event->name) > 20)
                        echo '<h2><span class="small">' . $event->startday . '</span>' . substr($event->name,0,20) . '...</h2>';
                    else
                        echo '<h2><span class="small">' . $event->startday . '</span>' . $event->name . '</h2>';
                echo '</div>';
                echo '<div class="body">';
                   echo ' <p>' . $event->description . '</p>';
                    echo '<img style="width: 100%; height: 200px; object-fit: cover;" src="' . $event->imagepath . '" alt="Graphic">';
                echo '</div>';
            echo '</div>';
        }

        echo '</div>';
    echo '</section>';
echo '</div>';

?>