<div class="form-group">
    <select id="country" name="country" class="form-control" required>
        <option value="">Choose</option>
        @foreach(App\Country::all() as $country)
           {{'<option value="' . $country->name .'">' . $country->name . '"</option>"'}}
        @endforeach
    </select>
</div>