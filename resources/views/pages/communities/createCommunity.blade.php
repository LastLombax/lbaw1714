@extends('layout')

@section('content')
  <div class="container"> 
     <form method="POST" action="{{ route('createCommunity') }}">
          {{ csrf_field() }}
     <div class="col-lg-12" style="padding-left: 0; padding-right:0; border: 1px solid #ccc;">
            <div class="bs-ccomponent">

                <div style="background-color: #eee; padding: 20px; padding-top: 10px;">
                    <fieldset>
                        <div class="form-group">
                            <label class="col-form-label" for="communityName">
                                <b>Community name</b>
                            </label>
                            <input id="communityName" name="communityName" type="text" class="form-control" placeholder="Community name"  maxlength="100" required>
                        </div>

                        <div class="form-group">
                            <label class="col-form-label" for="communityDescription">
                                <b>Description</b>
                            </label>
                            <textarea id="communityDescription" name="communityDescription" class="form-control" placeholder="Description" maxlength="255" required></textarea>
                        </div>

                        <div class="form-group">
                            <label class="col-form-label" for="communityVisibility">
                                <b>Visibility</b>
                            </label>
                            <br>
                            <div class="btn-group" data-toggle="buttons">
                                <div class="btn-group btn-group-toggle" data-toggle="buttons">
                                    <label class="btn btn-secondary active">
                                        <input  id="public" name="communityVisibility" type="radio" autocomplete="off" checked> Public
                                    </label>
                                    <label class="btn btn-secondary">
                                        <input id="private" name="communityVisibility" type="radio"  autocomplete="off"> Private
                                    </label>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-form-label" for="communityImage">
                                <b>Community photo</b>
                            </label>
                            <input id="communityImage" name="communityImage" type="file" class="form-control-file" aria-describedby="fileHelp">
                            <small id="fileHelp" class="form-text text-muted">Choose an image that represents your Community, such as a logo or a photo of your group.
                            </small>
                        </div>
                        
                    </fieldset>

                </div>
            </div>
        </div>
       <button type="submit"  class="btn btn-primary d-block ml-auto mt-3">Done</button>
    </div>
   
      </form>
    </div>

</div>

@endsection