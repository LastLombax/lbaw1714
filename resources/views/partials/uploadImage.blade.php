@section('extraScript')
    <script src="{{ asset('js/displaySubmittedImage.js') }}" defer></script>
@endsection

<div class="col-xl-3 align-self-start" style="padding-top: 25px;">
    <div style="background-color: #eee; border: 1px solid #ccc; box-shadow: 1px 1px 30px #ddd;">
        <div class="row align-items-center">
            <div class="col-md align-self-start">
                <div class="form-group" id="imgField" style="padding-left: 15px; padding-top: 10px">
                    <div id="dvPreview" style="filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=image);
                    /*min-height: 400px; min-width: 400px;*/">
                        <img width="100%" height="200" style="object-fit: cover;" src="{{asset('img/preview.jpg')}}">
                    </div>
                    <label for="eventImage">
                        <b>Image input</b>
                    </label>
                    <input id="imagePath" name="eventImage" type="file" accept="image/jpeg,image/gif,image/png"
                           class="form-control-file"
                           aria-describedby="fileHelp" value="Choose">
                    <br>
                    <small id="fileHelp" class="form-text text-muted">Choose a event
                        representative picture, such as a banner or photo of the venue
                    </small>
                </div>
            </div>
        </div>
    </div>
</div>