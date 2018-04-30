<?php

	namespace App\Policies;
	use Auth;
	use App\Member;
	use App\Event;
	use Illuminate\Auth\Access\HandlesAuthorization;

	class MemberPolicy
	{
		use HandlesAuthorization;

		/**
		 * Determine whether the user can view the event.
		 *
		 * @param  \App\Member $user
		 * @param  \App\Event $event
		 * @return mixed
		 */
		public function view(Member $user, Event $event) {
			return true;
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
		 * Determine whether the user is an admin
		 *
		 * @param  \App\Member $user
		 * @param  \App\Event $event
		 * @return mixed
		 */
		public function isAdmin(Member $user) {

			$tuple = $user->eventTuples()->find($event->idevent);
			if ($tuple == null)
				return false;
			return $tuple->pivot->isadmin;

		}

		/**
		 * Determine whether the user is an admin
		 *
		 * @param  \App\Member $user
		 * @param  \App\Event $event
		 * @return mixed
		 */
		public function edit(Member $user) {
			return $user == Auth::user();

		}

	}
