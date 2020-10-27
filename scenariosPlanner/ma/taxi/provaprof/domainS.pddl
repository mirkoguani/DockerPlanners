(define (domain e)
	(:requirements :typing :fluents :durative-actions :strips :conditional-effects)
(:types
	person location ob - object
	person - agent
	heavyOb lightOb - ob
)
(:predicates
	(xfreex ?agent - agent)
	(ato ?o - ob ?w - location)
	(link ?x - location ?y - location)
	(strong ?agent - person)
	(empty ?agent - person)
	(at ?agent - person ?y - location)
	(holds ?agent - person ?x - ob)
	(possible ?x - location ?agent - person )
)


(:durative-action move
	:parameters (?agent - person ?x - location ?y - location)
	:duration (= ?duration 1)
	:condition (and
		(at start (at ?agent ?x))
		(at start (possible ?y ?agent ))
		(at start (link ?x ?y))
		(at start (xfreex ?agent))
	)
	:effect (and
		(at end (at ?agent ?y))
		(at start (not (at ?agent ?x)))
		(at start (not (xfreex ?agent)))
		(at end (xfreex ?agent))
	)
)


(:durative-action loadHeavy
	:parameters (?a - person ?x - location ?o - heavyOb)
	:duration (= ?duration 1)
	:condition (and
		(at start (at ?a ?x))
		(at start (ato ?o ?x))
		(at start (strong ?a))
		(at start (empty ?a))
		(at start (xfreex ?a))
	)
	:effect (and
		(at start (not (ato ?o ?x)))
		(at end (holds ?a ?o))
		(at end (not (empty ?a)))
		(at start (not (xfreex ?a)))
		(at end (xfreex ?a))
	)
)

(:durative-action loadLight
	:parameters (?a - person ?x - location ?o - lightOb)
	:duration (= ?duration 1)
	:condition (and
		(at start (at ?a ?x))
		(at start (ato ?o ?x))
		(at start (empty ?a))
		(at start (xfreex ?a))
	)
	:effect (and
		(at start (not (ato ?o ?x)))
		(at end (holds ?a ?o))
		(at end (not (empty ?a)))
		(at start (not (xfreex ?a)))
		(at end (xfreex ?a))
	)
)

(:durative-action put
	:parameters (?a - person ?x - location ?o - ob)
	:duration (= ?duration 1)
	:condition (and
		(at start (at ?a ?x))
		(at start (holds ?a ?o))
		(at start (xfreex ?a))
	)
	:effect (and
		(at start (not (xfreex ?a)))
		(at end (ato ?o ?x))
		(at end (empty ?a))
		(at start (not (holds ?a ?o)))
		(at end (xfreex ?a))
	)
)

)