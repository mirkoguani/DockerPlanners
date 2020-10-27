(define (domain elevators-sequencedstrips)
	(:requirements :typing :fluents :durative-actions)
(:types
	passenger elevator count - object
	slow-elevator fast-elevator - elevator
	elevator slow-elevator fast-elevator - agent
)
(:predicates
	(xfreex ?agent - agent)
	(next ?n1 - count ?n2 - count)
	(passenger-at ?person - passenger ?floor - count)
	(above ?floor1 - count ?floor2 - count)
	(can-hold ?agent - elevator ?n - count)
	(reachable-floor ?agent - elevator ?floor - count)
	(lift-at ?lift - elevator ?floor - count)
	(boarded ?person - passenger ?lift - elevator)
	(passengers ?lift - elevator ?n - count)
)
(:functions
	(total-cost) - number
	(travel-slow ?f1 - count ?f2 - count) - number
	(travel-fast ?f1 - count ?f2 - count) - number
)

(:durative-action move-up-slow
	:parameters (?lift - slow-elevator ?f1 - count ?f2 - count)
	:duration (= ?duration 10)
	:condition (and
		(at start (lift-at ?lift ?f1))
		(at start (above ?f1 ?f2))
		(at start (reachable-floor ?lift ?f2))
		(at start (xfreex ?lift))
	)
	:effect (and
		(at end (lift-at ?lift ?f2))
		(at start (not (lift-at ?lift ?f1)))
		(at end (increase ( total-cost ) ( travel-slow ?f1 ?f2 )))
		(at start (not (xfreex ?lift)))
		(at end (xfreex ?lift))
	)
)


(:durative-action move-down-slow
	:parameters (?lift - slow-elevator ?f1 - count ?f2 - count)
	:duration (= ?duration 10)
	:condition (and
		(at start (lift-at ?lift ?f1))
		(at start (above ?f2 ?f1))
		(at start (reachable-floor ?lift ?f2))
		(at start (xfreex ?lift))
	)
	:effect (and
		(at end (lift-at ?lift ?f2))
		(at start (not (lift-at ?lift ?f1)))
		(at end (increase ( total-cost ) ( travel-slow ?f2 ?f1 )))
		(at start (not (xfreex ?lift)))
		(at end (xfreex ?lift))
	)
)


(:durative-action move-up-fast
	:parameters (?lift - fast-elevator ?f1 - count ?f2 - count)
	:duration (= ?duration 5)
	:condition (and
		(at start (lift-at ?lift ?f1))
		(at start (above ?f1 ?f2))
		(at start (reachable-floor ?lift ?f2))
		(at start (xfreex ?lift))
	)
	:effect (and
		(at end (lift-at ?lift ?f2))
		(at start (not (lift-at ?lift ?f1)))
		(at end (increase ( total-cost ) ( travel-fast ?f1 ?f2 )))
		(at start (not (xfreex ?lift)))
		(at end (xfreex ?lift))
	)
)


(:durative-action move-down-fast
	:parameters (?lift - fast-elevator ?f1 - count ?f2 - count)
	:duration (= ?duration 5)
	:condition (and
		(at start (lift-at ?lift ?f1))
		(at start (above ?f2 ?f1))
		(at start (reachable-floor ?lift ?f2))
		(at start (xfreex ?lift))
	)
	:effect (and
		(at end (lift-at ?lift ?f2))
		(at start (not (lift-at ?lift ?f1)))
		(at end (increase ( total-cost ) ( travel-fast ?f2 ?f1 )))
		(at start (not (xfreex ?lift)))
		(at end (xfreex ?lift))
	)
)


(:durative-action board
	:parameters (?lift - elevator ?p - passenger ?f - count ?n1 - count ?n2 - count)
	:duration (= ?duration 1)
	:condition (and
		(at start (lift-at ?lift ?f))
		(at start (passenger-at ?p ?f))
		(at start (passengers ?lift ?n1))
		(at start (next ?n1 ?n2))
		(at start (can-hold ?lift ?n2))
		(at start (xfreex ?lift))
	)
	:effect (and
		(at start (not (passenger-at ?p ?f)))
		(at end (boarded ?p ?lift))
		(at start (not (passengers ?lift ?n1)))
		(at end (passengers ?lift ?n2))
		(at start (not (xfreex ?lift)))
		(at end (xfreex ?lift))
	)
)


(:durative-action leave
	:parameters (?lift - elevator ?p - passenger ?f - count ?n1 - count ?n2 - count)
	:duration (= ?duration 1)
	:condition (and
		(at start (lift-at ?lift ?f))
		(at start (boarded ?p ?lift))
		(at start (passengers ?lift ?n1))
		(at start (next ?n2 ?n1))
		(at start (xfreex ?lift))
	)
	:effect (and
		(at end (passenger-at ?p ?f))
		(at start (not (boarded ?p ?lift)))
		(at start (not (passengers ?lift ?n1)))
		(at end (passengers ?lift ?n2))
		(at start (not (xfreex ?lift)))
		(at end (xfreex ?lift))
	)
)

)
