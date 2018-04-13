<?php

class eventController_Controller extends  Base_Controller {

    public  $restful = true;

    public function get_index(){
        return View::make('event.index');
    }
}