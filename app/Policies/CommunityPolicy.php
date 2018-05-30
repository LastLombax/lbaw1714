<?php

	namespace App\Policies;

	use App\Member;
	use App\Community;
	use Illuminate\Auth\Access\HandlesAuthorization;
    use Illuminate\Support\Facades\DB;


    class CommunityPolicy
	{
		use HandlesAuthorization;

		/**
		 * Determine whether the user can view the event.
		 *
		 * @param  \App\Member $user
		 * @param  \App\Community $community
		 * @return mixed
		 */
		public function view(Member $user, Community $community) {

            if($community->ispublic)
			    return true;

		    if(sizeof(DB::table('community_member')->
                where([ ['idcommunity', '=', $community->idcommunity],
                        ['idmember', '=', $user->idmember]])->get()) > 0)
		        return true;

		    return false;
		}

		/**
		 * Determine whether the user can create events.
		 *
		 * @param  \App\Member $user
		 * @return mixed
		 */
		public function create(Member $user) {
			return true;
		}

		/**
		 * Determine whether the user is an admin of the event
		 *
		 * @param  \App\Member $user
		 * @param  \App\Community $community
		 * @return mixed
		 */
		public function isAdmin(Member $user, Community $community) {

			$tuple = $user->communityTuples()->find($community->idcommunity);
			if ($tuple == null)
				return false;
			return $tuple->pivot->isadmin;

		}

		/**
		 * Determine whether the user can update the event.
		 *
		 * @param  \App\Member $user
		 * @param  \App\Community $community
		 * @return mixed
		 */
		public function update(Member $user, Community $community) {

			$tuple = $user->eventTuples()->find($community->idcommunity);
			if ($tuple == null)
				return false;
			return $tuple->pivot->isadmin;

		}

		/**
		 * Determine whether the user can delete the event.
		 *
		 * @param  \App\Member $user
		 * @param  \App\Community $community
		 * @return mixed
		 */
		public function delete(Member $user, Community $community){

			$tuple = $user->eventTuples()->find($community->idcommunity);
			if ($tuple == null)
				return false;
			return $tuple->pivot->isadmin;
		}
	}
