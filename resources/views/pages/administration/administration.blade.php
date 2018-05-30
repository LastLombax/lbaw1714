
@extends('layout')

@section('extraScript')
    <script defer
            src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAr1_x1qNGarZz3rVGBTmTk2yDOAA-jkOI&callback=initMap">
    </script>
    
@endsection


@section('titleIcon')
    <i class="fas fa-cogs"></i>
@endsection

@section('pageTitle')
    Administration
@endsection

@section('content')

<div class="container">
		

		<div class="bs-docs-section">
			<div class="row">

				<div class="col-lg-12" style="padding-top:23px">

					
					<ul class="nav nav-tabs">
						<li class="nav-item">
							<a class="nav-link active show" data-toggle="tab" href="#disable-community">Disable a Community</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" data-toggle="tab" href="#disable-event">Disable an Event</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" data-toggle="tab" href="#ban-user">Ban a User</a>
						</li>
					</ul>

					<div id="myTabContent" class="tab-content">
							
						<div class="tab-pane fade active show" id="disable-community">
							<div class="col-lg-12" style="padding-left: 0px;padding-right: 0px;">
								<div class="bs-ccomponent">
									<div class="list-group">
                                       @include('pages.administration.communities')
									</div>
								</div>
								
							</div>

						</div>

						<div class="tab-pane fade" id="disable-event">
							<div class="col-lg-12" style="padding-left: 0px;padding-right: 0px;">
								<div class="bs-ccomponent">
                                   <div class="list-group">
                                        @include('pages.administration.events')
									</div>

								</div>
								
							</div>
						</div>

						<div class="tab-pane fade" id="ban-user">
							<div class="col-lg-12" style="padding-left: 0px;padding-right: 0px;">
								<div class="bs-ccomponent">
									<div class="list-group">
                                       @include('pages.administration.members')
									</div>
								</div>
								
							</div>
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>

@endsection
