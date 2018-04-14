<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateEventsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('events', function (Blueprint $table) {
            $table->increments('id');
            $table->string('name');
            $table->string('description');
            $table->string('imagepath');
            $table->date('startday');
            $table->date('endday');
            $table->timestamp('starttime');
            $table->timestamp('endtime');
            $table->string('country');
            $table->string('city');
            $table->string('address');
            $table->string('publiclink');
            $table->boolean('ispublic');
            $table->integer('community');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('events');
    }
}
