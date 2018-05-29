<?php

	namespace App\Policies;

	use App\Member;
	use App\Event;
	use Illuminate\Auth\Access\HandlesAuthorization;
    use Illuminate\Support\Facades\DB;

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
		    if($event->ispublic)
			    return true;

		    if(sizeof(DB::table('event_member')->
                where([ ['idevent', '=', $event->idevent],
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
		 * @param  \App\Event $event
		 * @return mixed
		 */
		public function isAdmin(Member $user, Event $event) {

			$tuple = $user->eventTuples()->find($event->idevent);
			if ($tuple == null)
				return false;
			return $tuple->pivot->isadmin;

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
			if ($tuple == null)
				return false;
			return $tuple->pivot->isadmin;

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
			if ($tuple == null)
				return false;
			return $tuple->pivot->isadmin;
		}
	}
