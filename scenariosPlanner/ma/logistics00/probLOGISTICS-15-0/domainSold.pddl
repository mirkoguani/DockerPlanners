(define (domain logistics)
	(:requirements :typing :fluents :durative-actions)
(:types
	package location vehicle city - object
	airport - location
	airplane truck - vehicle
	truck airplane - agent
)
(:predicates
	(xfreex ?agent - agent)
	(at ?obj - object ?loc - location)
	(in ?obj1 - package ?veh - vehicle)
	(in-city ?agent - truck ?loc - location ?city - city)
)

(:durative-action load-airplane
	:parameters (?airplane - airplane ?obj - package ?loc - airport)
	:duration (= ?duration 1)
	:condition (and
		(at start (at ?obj ?loc))
		(at start (at ?airplane ?loc))
		(at start (xfreex ?airplane))
	)
	:effect (and
		(at start (not (at ?obj ?loc)))
		(at end (in ?obj ?airplane))
		(at start (not (xfreex ?airplane)))
		(at end (xfreex ?airplane))
	)
)


(:durative-action unload-airplane
	:parameters (?airplane - airplane ?obj - package ?loc - airport)
	:duration (= ?duration 1)
	:condition (and
		(at start (in ?obj ?airplane))
		(at start (at ?airplane ?loc))
		(at start (xfreex ?airplane))
	)
	:effect (and
		(at start (not (in ?obj ?airplane)))
		(at end (at ?obj ?loc))
		(at start (not (xfreex ?airplane)))
		(at end (xfreex ?airplane))
	)
)


(:durative-action fly-airplane
	:parameters (?airplane - airplane ?loc-from - airport ?loc-to - airport)
	:duration (= ?duration 1)
	:condition (and
		(at start (at ?airplane ?loc-from))
		(at start (xfreex ?airplane))
	)
	:effect (and
		(at start (not (at ?airplane ?loc-from)))
		(at end (at ?airplane ?loc-to))
		(at start (not (xfreex ?airplane)))
		(at end (xfreex ?airplane))
	)
)


(:durative-action load-truck
	:parameters (?truck - truck ?obj - package ?loc - location)
	:duration (= ?duration 1)
	:condition (and
		(at start (at ?truck ?loc))
		(at start (at ?obj ?loc))
		(at start (xfreex ?truck))
	)
	:effect (and
		(at start (not (at ?obj ?loc)))
		(at end (in ?obj ?truck))
		(at start (not (xfreex ?truck)))
		(at end (xfreex ?truck))
	)
)


(:durative-action unload-truck
	:parameters (?truck - truck ?obj - package ?loc - location)
	:duration (= ?duration 1)
	:condition (and
		(at start (at ?truck ?loc))
		(at start (in ?obj ?truck))
		(at start (xfreex ?truck))
	)
	:effect (and
		(at start (not (in ?obj ?truck)))
		(at end (at ?obj ?loc))
		(at start (not (xfreex ?truck)))
		(at end (xfreex ?truck))
	)
)


(:durative-action drive-truck
	:parameters (?truck - truck ?loc-from - location ?loc-to - location ?city - city)
	:duration (= ?duration 1)
	:condition (and
		(at start (at ?truck ?loc-from))
		(at start (in-city ?truck ?loc-from ?city))
		(at start (in-city ?truck ?loc-to ?city))
		(at start (xfreex ?truck))
	)
	:effect (and
		(at start (not (at ?truck ?loc-from)))
		(at end (at ?truck ?loc-to))
		(at start (not (xfreex ?truck)))
		(at end (xfreex ?truck))
	)
)

)