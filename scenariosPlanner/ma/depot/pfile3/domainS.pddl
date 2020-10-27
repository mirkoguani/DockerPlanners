(define (domain depot)
	(:requirements :typing :fluents :durative-actions)
(:types
	driver place locatable - object
	distributor depot - place
	truck hoist surface - locatable
	pallet crate - surface
	place driver - agent
)
(:predicates
	(xfreex ?agent - agent)
	(at ?x - locatable ?y - place)
	(on ?x - crate ?y - surface)
	(in ?x - crate ?y - truck)
	(clear ?x - surface)
	(lifting ?agent - place ?x - hoist ?y - crate)
	(available ?agent - place ?x - hoist)
	(driving ?agent - driver ?t - truck)
)

(:durative-action drive
	:parameters (?a - driver ?x - truck ?y - place ?z - place)
	:duration (= ?duration 50)
	:condition (and
		(at start (at ?x ?y))
		(at start (driving ?a ?x))
		(at start (xfreex ?a))
	)
	:effect (and
		(at end (at ?x ?z))
		(at start (not (at ?x ?y)))
		(at start (not (xfreex ?a)))
		(at end (xfreex ?a))
	)
)


(:durative-action lift
	:parameters (?p - place ?x - hoist ?y - crate ?z - surface)
	:duration (= ?duration 5)
	:condition (and
		(at start (at ?x ?p))
		(at start (available ?p ?x))
		(at start (at ?y ?p))
		(at start (on ?y ?z))
		(at start (clear ?y))
		(at start (xfreex ?p))
	)
	:effect (and
		(at end (lifting ?p ?x ?y))
		(at end (clear ?z))
		(at start (not (at ?y ?p)))
		(at start (not (clear ?y)))
		(at start (not (available ?p ?x)))
		(at start (not (on ?y ?z)))
		(at start (not (xfreex ?p)))
		(at end (xfreex ?p))
	)
)


(:durative-action drop
	:parameters (?p - place ?x - hoist ?y - crate ?z - surface)
	:duration (= ?duration 5)
	:condition (and
		(at start (at ?x ?p))
		(at start (at ?z ?p))
		(at start (clear ?z))
		(at start (lifting ?p ?x ?y))
		(at start (xfreex ?p))
	)
	:effect (and
		(at end (available ?p ?x))
		(at end (at ?y ?p))
		(at end (clear ?y))
		(at end (on ?y ?z))
		(at start (not (lifting ?p ?x ?y)))
		(at start (not (clear ?z)))
		(at start (not (xfreex ?p)))
		(at end (xfreex ?p))
	)
)


(:durative-action load
	:parameters (?p - place ?x - hoist ?y - crate ?z - truck)
	:duration (= ?duration 5)
	:condition (and
		(at start (at ?x ?p))
		(at start (at ?z ?p))
		(at start (lifting ?p ?x ?y))
		(at start (xfreex ?p))
	)
	:effect (and
		(at end (in ?y ?z))
		(at end (available ?p ?x))
		(at start (not (lifting ?p ?x ?y)))
		(at start (not (xfreex ?p)))
		(at end (xfreex ?p))
	)
)


(:durative-action unload
	:parameters (?p - place ?x - hoist ?y - crate ?z - truck)
	:duration (= ?duration 5)
	:condition (and
		(at start (at ?x ?p))
		(at start (at ?z ?p))
		(at start (available ?p ?x))
		(at start (in ?y ?z))
		(at start (xfreex ?p))
	)
	:effect (and
		(at end (lifting ?p ?x ?y))
		(at start (not (in ?y ?z)))
		(at start (not (available ?p ?x)))
		(at start (not (xfreex ?p)))
		(at end (xfreex ?p))
	)
)

)
