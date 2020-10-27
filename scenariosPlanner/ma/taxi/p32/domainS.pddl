(define (domain taxi)
	(:requirements :typing :strips :fluents :durative-actions :equality)
(:types
	agent location - object
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
	(busy ?agent - agent)
)

(:functions  
    (time-waited)
    (busy-time ?t - taxi)
    (lock-busy)
)

(:durative-action drive
	:parameters (?t - taxi ?from - location ?to - location)
	:duration (= ?duration 10)
	:condition (and
		(at start (at ?t ?from))
		(at start (directly-connected ?from ?to))
		(at start (free ?to))
		(at start (xfreex ?t))
		(at start (> (+ time-waited 0.0001) (busy-time ?t)))
	)
	:effect (and
		;(at start (not(all-taxi-busy-init)))
		(at start (not(busy ?t)))
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
		(at start (xfreex ?p))
		(at start (> (+ time-waited 0.0001) (busy-time ?t)))
	)
	:effect (and
		;(at start (not(all-taxi-busy-init)))
		(at start (not(busy ?t)))
		(at start (not (empty ?t)))
		(at start (not (at ?p ?l)))
		(at end (in ?p ?t))
		(at start (not (xfreex ?p)))
		(at end (xfreex ?p))
		(at start (not (xfreex ?t)))
		(at end (xfreex ?t))
	)
)


(:durative-action exit
	:parameters (?p - passenger ?t - taxi ?l - location)
	:duration (= ?duration 1)
	:condition (and
		(at start (in ?p ?t))
		(at start (at ?t ?l))
		(at start (goal-of ?p ?l))
		(at start (xfreex ?p))
		(at start (> (+ time-waited 0.0001) (busy-time ?t)))
	)
	:effect (and
		(at start (not(busy ?t)))
		(at start (not (in ?p ?t)))
		(at end (empty ?t))
		(at end (at ?p ?l))
		(at start (not (xfreex ?p)))
		(at end (xfreex ?p))
		(at start (not (xfreex ?t)))
		(at end (xfreex ?t))
	)
)

(:durative-action wait-end-action-taxi
	:parameters (?t - taxi)
	:duration (= ?duration 1)
	:condition (
	and
		(at start (= lock-busy 0))
		(at start (< (time-waited) (busy-time ?t)))
	)
	:effect (and 
	(at end (increase (time-waited) 1))
	(at start (increase (lock-busy) 1))
	(at end (increase (lock-busy) -1))
	)
	
)


)
