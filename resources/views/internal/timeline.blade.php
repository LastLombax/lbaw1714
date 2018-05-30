<?php

    use Illuminate\Support\Facades\Auth;
    $user = App\Member::find(Auth::id());
    $query = $user->upcomingEvents;

    //dd($query);

?>

<div id="time">
    <section id=timeline>
        @if(count($query) == 0)
            <div style="text-align: center">
                It seems you don't have any upcoming events<br>
                You should try browsing our available <a href="/events">events</a><br>
            </div>
        @else
            <div class="demo-card-wrapper">

                <?php
                $i = 0;

                foreach ($query as $event) {
                    $date = date_create_from_format('Y-m-d', $event->startday);
                    $month = date_format($date, "F");
                    $day = date_format($date, "d");
                    $year = date_format($date, "Y");

                    $i++;
                    $eventsLink = route('events');
                    $link = $eventsLink . '/' . $event->idevent;

                    echo ' <div class="demo-card demo-card--step' . $i . '">';
                    echo '<div class="head">';
                    echo '<div class="number-box">';
                    echo '<span>' . $day . '</span>';
                    echo '</div>';
                    if (strlen($event->name) > 20)
                        echo '<h2><span class="small">' . $month . ', ' . $year . '</span>' . substr($event->name, 0, 20) . '...</h2>';
                    else
                        echo '<h2><span class="small">' . $month . ', ' . $year . '</span>' . $event->name . '</h2>';
                    echo '</div>';
                    echo '<div class="body">';

                    if (strlen($event->description) < 130)
                        echo ' <p>' . $event->description . '</p>';
                    else
                        echo ' <p>' . substr($event->description, 0, 130) . '...' . '</p>';


                    echo '<a href="' . $link . '"><img style="width: 100%; height: 200px; object-fit: cover;" src="' . Storage::url($event->imagepath) . '" alt="Graphic"></a>';
                    echo '<table style="padding: 5px; width:100%;"><tr><td style="text-align: right; padding: 10px; width:100%; font-size:14px;"><a href="' . $link . '"> More</a></td></tr></table>';
                    echo '</div>';
                    echo '</div>';
                }
                ?>
            </div>
        @endif
    </section>
</div>
