(define (domain taxi)
	(:requirements :strips :typing :fluents :durative-actions)
(:types
	location agent - object
	taxi passenger - agent
)
(:predicates
	(xfreex ?agent - agent)
	(directly-connected ?l1 - location ?l2 - location)
	(at ?a - agent ?l - location)
	(in ?p - passenger ?t - taxi)
	(empty ?t - taxi)
	(free ?l - location)
	(goal-of ?p - passenger ?l - location)
)

(:durative-action drive
	:parameters (?t - taxi ?from - location ?to - location)
	:duration (= ?duration 1)
	:condition (and
		(at start (at ?t ?from))
		(at start (directly-connected ?from ?to))
		(at start (free ?to))
		(at start (forall ( ?t2 - taxi ?from2 - location ) ( not ( drive ?t2 ?from2 ?to ) )))
		(at start (forall ( ?t2 - taxi ?from2 - location ) ( not ( drive ?t2 ?from2 ?from ) )))
		(at start (forall ( ?p2 - passenger ) ( not ( enter ?p2 ?t ?from ) )))
		(at start (forall ( ?p2 - passenger ) ( not ( exit ?p2 ?t ?from ) )))
		(at start (xfreex ?t))
	)
	:effect (and
		(at start (not (at ?t ?from)))
		(at start (not (free ?to)))
		(at end (at ?t ?to))
		(at end (free ?from))
		(at start (not (xfreex ?t)))
		(at end (xfreex ?t))
	)
)


(:durative-action enter
	:parameters (?p - passenger ?t - taxi ?l - location)
	:duration (= ?duration 1)
	:condition (and
		(at start (at ?p ?l))
		(at start (at ?t ?l))
		(at start (empty ?t))
		(at start (forall ( ?p2 - passenger ) ( not ( enter ?p2 ?t ?l ) )))
		(at start (forall ( ?p2 - passenger ) ( not ( exit ?p2 ?t ?l ) )))
		(at start (xfreex ?p))
	)
	:effect (and
		(at start (not (empty ?t)))
		(at start (not (at ?p ?l)))
		(at end (in ?p ?t))
		(at start (not (xfreex ?p)))
		(at end (xfreex ?p))
	)
)


(:durative-action exit
	:parameters (?p - passenger ?t - taxi ?l - location)
	:duration (= ?duration 1)
	:condition (and
		(at start (in ?p ?t))
		(at start (at ?t ?l))
		(at start (goal-of ?p ?l))
		(at start (forall ( ?p2 - passenger ) ( not ( enter ?p2 ?t ?l ) )))
		(at start (xfreex ?p))
	)
	:effect (and
		(at start (not (in ?p ?t)))
		(at end (empty ?t))
		(at end (at ?p ?l))
		(at start (not (xfreex ?p)))
		(at end (xfreex ?p))
	)
)

)