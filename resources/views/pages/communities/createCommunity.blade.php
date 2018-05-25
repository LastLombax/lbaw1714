@extends('layout')

@section('titleIcon')
    <i class="fas fa-user"></i>
@endsection

@section('pageTitle')
    Creating a Community
@endsection

@section('content')
    <form method="POST" action="{{ route('createCommunity') }}">
        {{ csrf_field() }}
        <div class="row align-items-center">

            <div class="col-md-4 align-self-start" style="padding-top: 25px;">
                <div style="background-color: #eee; padding: 20px; padding-top: 10px; border: 1px solid #ccc; box-shadow: 1px 1px 30px #ddd;">
                    <div class="form-group">
                        <label class="col-form-label" for="communityImage">
                            <b>Community photo</b>
                        </label>

                        @if ($errors->has('communityImage'))
                            <input id="communityImage" name="communityImage" type="file"
                                   class="form-control-file is-invalid" aria-describedby="fileHelp">
                            <small id="fileHelp" class="form-text text-muted">Choose an image that represents
                                your Community, such as a logo or a photo of your group.
                            </small>
                            <div class="alert alert-dismissible alert-danger">
                                <button type="button" class="close" data-dismiss="alert">&times;</button>
                                <strong>Error: </strong>{{$errors->first('communityImage')}}
                            </div>
                        @else
                            <div id="dvPreview" style="filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=image);
                    /*min-height: 400px; min-width: 400px;*/">
                                <img width="100%" height="200" style="object-fit: cover;"
                                     src="{{asset('img/preview.jpg')}}">
                            </div>
                            <input id="communityImage" name="communityImage" type="file"
                                   class="form-control-file" aria-describedby="fileHelp">
                            <small id="fileHelp" class="form-text text-muted">Choose an image that represents
                                your Community, such as a logo or a photo of your group.
                            </small>
                        @endif

                    </div>
                </div>
            </div>

            <div class="col-md-8 align-self-start" style="padding-top: 25px;">
                <div class="bs-ccomponent">

                    <div style="background-color: #eee; padding: 20px; padding-top: 10px; border: 1px solid #ccc; box-shadow: 1px 1px 30px #ddd;">
                        <fieldset>
                            <div class="form-group">
                                <label class="col-form-label" for="communityName">
                                    <b>Community name</b>
                                </label>
                                @if ($errors->has('communityName'))
                                    <input id="communityName" name="communityName" type="text"
                                           class="form-control is-invalid" placeholder="Community name" maxlength="100"
                                           required>
                                    <div class="alert alert-dismissible alert-danger">
                                        <button type="button" class="close" data-dismiss="alert">&times;</button>
                                        <strong>Error: </strong>{{$errors->first('communityName')}}
                                    </div>
                                @else
                                    <input id="communityName" name="communityName" type="text" class="form-control "
                                           placeholder="Community name" maxlength="100" required>
                                @endif
                            </div>

                            <div class="form-group">
                                <label class="col-form-label" for="communityDescription">
                                    <b>Description</b>
                                </label>
                                @if ($errors->has('communityDescription'))
                                    <textarea id="communityDescription" name="communityDescription"
                                              class="form-control is-invalid" placeholder="Description" maxlength="255"
                                              required></textarea>
                                    <div class="alert alert-dismissible alert-danger">
                                        <button type="button" class="close" data-dismiss="alert">&times;</button>
                                        <strong>Error: </strong>{{$errors->first('communityDescription')}}
                                    </div>
                                @else
                                    <textarea id="communityDescription" name="communityDescription" class="form-control"
                                              placeholder="Description" maxlength="255" required></textarea>
                                @endif
                            </div>

                            <div class="form-group">
                                <label class="col-form-label" for="communityVisibility">
                                    <b>Visibility</b>
                                </label>
                                <br>
                                <div class="btn-group" data-toggle="buttons">
                                    <div class="btn-group btn-group-toggle" data-toggle="buttons">
                                        <label class="btn btn-secondary active">
                                            <input id="public" name="communityVisibility" type="radio"
                                                   autocomplete="off" checked> Public
                                        </label>
                                        <label class="btn btn-secondary">
                                            <input id="private" name="communityVisibility" type="radio"
                                                   autocomplete="off"> Private
                                        </label>
                                    </div>
                                </div>
                            </div>

                        </fieldset>

                    </div>
                </div>
            </div>

        </div>
        <button type="submit" style="box-shadow: 1px 1px 30px #ddd;"
                class="btn btn-primary d-block ml-auto mt-3">Create
        </button>
    </form>
@endsection