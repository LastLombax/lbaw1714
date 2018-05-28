@extends('layout')

@section('title')
    {{--@dd($community);--}}
    {{$community->name}} | ReEvent
@endsection

@section('titleIcon')
    <i class="fas fa-user"></i>
@endsection

@section('pageTitle')
    Edit - {{$community->name}}
@endsection

@section('content')
<br>
  <form action="{{ route('editCommunity', $community)}}" method="POST" enctype="multipart/form-data">

    {{ method_field('PATCH') }}
    {{ csrf_field() }}


    <div class="col-lg-12" style="padding-left: 0; padding-right:0; border: 1px solid #ccc;">
        <div class="bs-ccomponent">

            <div style="background-color: #eee; padding: 20px; padding-top: 10px;">
                <fieldset>
                  <div class="form-group">
                      <label class="col-form-label" for="name">
                        <b>Community Name</b>
                      </label>
                      @if($errors->has('name'))
                      <input type="text" style="width:100%;" class="form-control col-xs-3 is-invalid" placeholder="Enter community name" id="communityName" maxlength="80" name="name">
                       <div class="alert alert-dismissible alert-danger">
                           <button type="button" class="close" data-dismiss="alert">&times;</button>
                        <strong>Error: </strong>{{$errors->first('name')}}
                       </div>
                       @else
                        <input type="text" style="width:100%;" class="form-control col-xs-3" placeholder="Enter community name" id="communityName" value="{{$community->name}}" maxlength="80" name="name">
                        @endif
                  </div>

                <div class="form-group">
                    <label class="col-form-label" for="description"  style="width:100%;">
                      <b>Description</b>
                    </label>
                      @if($errors->has('description'))
                        <div class="form-inline form-group mb-2" style="width:100%;">
                        <textarea class="form-control is-invalid" placeholder="Description" id="description" maxlength="255" style="width:100%;" name="description" > </textarea>
                      </div>
                        <div class="alert alert-dismissible alert-danger">
                             <button type="button" class="close" data-dismiss="alert">&times;</button>
                          <strong>Error: </strong>{{$errors->first('name')}}
                         </div>
                      @else
                       <div class="form-inline form-group mb-2" style="width:100%;">
                        <textarea class="form-control" placeholder="Description" id="description" maxlength="255" style="width:100%;" name="description">{{$community->description}} </textarea>
                      </div>
                      @endif
                  </div>

                   <div class="form-group">
                        <label class="col-form-label" for="visibility">
                            <b>Visibility</b>
                        </label>
                        <br>
                        <div class="btn-group" data-toggle="buttons">
                            <div class="btn-group btn-group-toggle" data-toggle="buttons">

                              @if ($community->isPublic)
                                <label class="btn btn-secondary active">
                                    <input name="visibility" type="radio" name="options" id="option1" autocomplete="off" checked=""> Public
                                </label>
                                <label class="btn btn-secondary">
                                    <input name ="visibility" type="radio" name="options" id="option2" autocomplete="off"> Private
                                </label>

                                @else
                                <label class="btn btn-secondary active">
                                    <input name="visibility" type="radio" name="options" id="option1" autocomplete="off"> Public
                                </label>
                                <label class="btn btn-secondary">
                                    <input checked="" name ="visibility" type="radio" name="options" id="option2" autocomplete="off"> Private
                                </label>
                                @endif
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-form-label" for="image">
                            <b>Community photo</b>
                        </label>
                        <input type="file" class="form-control-file" id="image" aria-describedby="fileHelp">
                        <small id="fileHelp" class="form-text text-muted">Choose an image that represents your Community, such as a logo or a photo of your
                            group.
                        </small>
                    </div>
                  <button type="submit"  class="btn btn-primary d-block ml-auto mt-3">Edit</button>
                </fieldset>

            </div>
        </div>
    </div>
</form>
@endsection