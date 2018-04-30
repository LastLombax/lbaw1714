<?php $query = \App\Http\Controllers\EventController::upcomingMemberEvents(); ?>

<div id="time">
<section id=timeline>
@if(count($query) == 0)
    
    It seems you don't have any upcoming events.<br>
    You should try browsing our available events.<br>
    [centered button]
@else
    <div class="demo-card-wrapper">

    <?php
    $i = 0;

    foreach ($query as $event){
        $i++;
        $eventsLink = route('events');
        $link = $eventsLink . '/' . $event->idevent;

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
                echo '<img style="width: 100%; height: 200px; object-fit: cover;" src="' . Storage::url($event->imagepath) . '" alt="Graphic">';
                echo '<table style="padding: 5px; width:100%;"><tr><td style="text-align: right; padding: 10px; width:100%; font-size:14px;"><a href="' . $link . '"> More</a></td></tr></table>';
            echo '</div>';
        echo '</div>';
     }
     ?>
     </div>
@endif
    </section>
</div>
