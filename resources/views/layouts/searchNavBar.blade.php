<div class="container" style="padding-top:-20px;">
    <div class="row">
        <div class="col-xs-8 col-xs-offset-2">
            <div class="input-group">
                <div class="input-group-btn search-panel">
                    <button id="filterBy" type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <span id="search_concept">Filter by</span> <span class="caret"></span>
                    </button>
                    <div class="dropdown-menu" role="menu" aria-labelledby="filterBy" style="padding-left: 10px; padding-right: 10px;">
                        <li class="form-group dropdown-item">
                            <label class="col-form-label" for="inputDefault">
                                <b>Price</b>
                            </label>
                            <input type="number" min="0" > to
                            <input type="number" min="1" >
                        </li>
                        <li class="form-group">
                            <label class="col-form-label" for="inputDefault">
                                <b>Categories</b>
                            </label>
                            <input type="text" class="form-control col-xs-3" placeholder="Enter category name" id="categorySearch" maxlength="80">
                        </li>
                    </div>
                </div>
                <input type="hidden" name="search_param" value="all" id="search_param">
                <input type="text" class="form-control" name="x" placeholder="Search term...">
                <span class="input-group-btn">
              <button class="btn btn-default" type="button"><span class="glyphicon glyphicon-search"></span></button>
          </span>
            </div>
        </div>
    </div>
</div>