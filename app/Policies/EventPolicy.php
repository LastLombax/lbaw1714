<?php

	namespace App\Policies;

	use App\Member;
	use App\Event;
	use Illuminate\Auth\Access\HandlesAuthorization;

	class EventPolicy
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
		 * Determine whether the user can update the event.
		 *
		 * @param  \App\Member $user
		 * @param  \App\Event $event
		 * @return mixed
		 */
		public function update(Member $user, Event $event) {

			$tuple = $user->eventTuples()->find($event->idevent);

			return $tuple->pivot->isAdmin;

		}

		/**
		 * Determine whether the user can delete the event.
		 *
		 * @param  \App\Member $user
		 * @param  \App\Event $event
		 * @return mixed
		 */
		public function delete(Member $user, Event $event) {

			$tuple = $user->eventTuples()->find($event->idevent);

			return $tuple->pivot->isAdmin;
		}
	}
