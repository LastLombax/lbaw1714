<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\Pivot;

class EventMember extends Pivot
{
	/**
	 * The parent model of the relationship.
	 *
	 * @var \Illuminate\Database\Eloquent\Model
	 */
	public $pivotParent = 'App\Event';

	/**
	 * The name of the foreign key column.
	 *
	 * @var string
	 */
	protected $foreignKey = 'idevent';

	/**
	 * The name of the "other key" column.
	 *
	 * @var string
	 */
	protected $relatedKey = 'idmember';


// User model



// Category model



}
