<?php

$query = \App\Http\Controllers\EventController::topEvents(2,0);


echo '<!DOCTYPE html>';
echo '<html >';
echo '<head>';
echo '<meta charset="UTF-8">';
echo '<title>Clean Slider With Curved Background</title>';
echo '<link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700" rel="stylesheet" type="text/css">';
echo '<link rel="stylesheet" href="' . asset('slideshow/css/style.css') . '">';
echo '</head>';

echo '<body>';
    echo '<div class="cont">';
        echo '<div class="app">';

            echo '<div class="app__bgimg">';

                $i = 0;

                foreach ($query as $event){
                    $i++;
                    echo '<div class="app__bgimg-image app__bgimg-image--' . $i .'" style="background-image: url(\'' . Storage::url($event->imagepath) . '\');">';
                    echo '</div>';
                }

            echo '</div>';

            echo '<div class="app__img">';
                echo '<img onmousedown="return false" src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/537051/whiteTest4.png" alt="city" />';
            echo '</div>';
            $i = 0;

            foreach ($query as $event){

                $i++;
                $eventsLink = route('events');
                $link = $eventsLink . '/' . $event->idevent;

                echo '<div class="app__text app__text--' . $i . '">';
                    if(strlen($event->name) > 12)
                        echo '<div class="app__text-line app__text-line--4" style="font-size: 2.5em;"><l onclick="window.open(\''. $link . '\')">' . substr($event->name,0,12) . ' ... </l></div>';
                    else
                        echo '<div class="app__text-line app__text-line--4" style="font-size: 2.5em;">' . $event->name . '</div>';
                echo '<div class="app__text-line app__text-line--3" style="font-size: 1.5em;">' . $event->country->name . '</div>';
                    echo '<div class="app__text-line app__text-line--2">' . $event->startday . '</div>';
                    echo '<div class="app__text-line app__text-line--1"><img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/537051/opus-attachment.png" alt="" /></div>';
                echo '</div>';

            }
        echo '</div>';

        echo '<div class="pages">';
            echo '<ul class="pages__list">';

                $i = 0;

                foreach ($query as $event){
                    $i++;
                    if($i == 1)
                        echo '<li data-target="1" class="pages__item pages__item--1 page__item-active"></li>';
                    else
                        echo '<li data-target="' . $i . '" class="pages__item pages__item--' . $i . '"></li>';
                }

            echo '</ul>';
        echo '</div>';
    echo '</div>';

    echo '<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>';
    echo '<script src="' . asset('slideshow/js/index.js') . '"></script>';
echo '</body>';

echo '</html>';
