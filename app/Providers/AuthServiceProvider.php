<?php

namespace App\Providers;

use Illuminate\Support\Facades\Gate;
use Illuminate\Foundation\Support\Providers\AuthServiceProvider as ServiceProvider;

class AuthServiceProvider extends ServiceProvider
{
    /**
     * The policy mappings for the application.
     *
     * @var array
     */
    protected $policies = [
    ];

    /**
     * Register any authentication / authorization services.
     *
     * @return void
     */
    public function boot()
    {
        $this->registerPolicies();

				Gate::define('event-admin', 'App\Policies\EventPolicy@isAdmin');
                Gate::define('event-view', 'App\Policies\EventPolicy@view');
                Gate::define('edit-profile', 'App\Policies\MemberPolicy@edit');
                Gate::define('community-admin', 'App\Policies\CommunityPolicy@isAdmin');

		}
}
