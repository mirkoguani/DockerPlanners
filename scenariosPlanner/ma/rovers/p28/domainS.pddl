(define (domain rover)
	(:requirements :typing :fluents :durative-actions)
(:types
	mode lander rover store camera objective waypoint - object
	rover - agent
)
(:predicates
	(xfreex ?agent - agent)
	(visible ?w - waypoint ?p - waypoint)
	(visible_from ?o - objective ?w - waypoint)
	(at_rock_sample ?w - waypoint)
	(at_soil_sample ?w - waypoint)
	(at_lander ?x - lander ?y - waypoint)
	(communicated_image_data ?o - objective ?m - mode)
	(communicated_rock_data ?w - waypoint)
	(communicated_soil_data ?w - waypoint)
	(empty ?s - store)
	(full ?s - store)
	(supports ?c - camera ?m - mode)
	(calibration_target ?i - camera ?o - objective)
	(channel_free ?l - lander)
	(at ?agent - rover ?y - waypoint)
	(can_traverse ?agent - rover ?x - waypoint ?y - waypoint)
	(equipped_for_soil_analysis ?agent - rover)
	(equipped_for_rock_analysis ?agent - rover)
	(equipped_for_imaging ?agent - rover)
	(have_rock_analysis ?agent - rover ?w - waypoint)
	(have_soil_analysis ?agent - rover ?w - waypoint)
	(calibrated ?c - camera ?agent - rover)
	(available ?agent - rover)
	(have_image ?agent - rover ?o - objective ?m - mode)
	(store_of ?s - store ?agent - rover)
	(on_board ?i - camera ?agent - rover)
)

(:durative-action navigate
	:parameters (?x - rover ?y - waypoint ?z - waypoint)
	:duration (= ?duration 10)
	:condition (and
		(at start (can_traverse ?x ?y ?z))
		(at start (available ?x))
		(at start (at ?x ?y))
		(at start (visible ?y ?z))
		(at start (xfreex ?x))
	)
	:effect (and
		(at start (not (at ?x ?y)))
		(at end (at ?x ?z))
		(at start (not (xfreex ?x)))
		(at end (xfreex ?x))
	)
)


(:durative-action sample_soil
	:parameters (?x - rover ?s - store ?p - waypoint)
	:duration (= ?duration 5)
	:condition (and
		(at start (at ?x ?p))
		(at start (at_soil_sample ?p))
		(at start (equipped_for_soil_analysis ?x))
		(at start (store_of ?s ?x))
		(at start (empty ?s))
		(at start (xfreex ?x))
	)
	:effect (and
		(at start (not (empty ?s)))
		(at end (full ?s))
		(at end (have_soil_analysis ?x ?p))
		(at start (not (at_soil_sample ?p)))
		(at start (not (xfreex ?x)))
		(at end (xfreex ?x))
	)
)


(:durative-action sample_rock
	:parameters (?x - rover ?s - store ?p - waypoint)
	:duration (= ?duration 5)
	:condition (and
		(at start (at ?x ?p))
		(at start (at_rock_sample ?p))
		(at start (equipped_for_rock_analysis ?x))
		(at start (store_of ?s ?x))
		(at start (empty ?s))
		(at start (xfreex ?x))
	)
	:effect (and
		(at start (not (empty ?s)))
		(at end (full ?s))
		(at end (have_rock_analysis ?x ?p))
		(at start (not (at_rock_sample ?p)))
		(at start (not (xfreex ?x)))
		(at end (xfreex ?x))
	)
)


(:durative-action drop
	:parameters (?x - rover ?y - store)
	:duration (= ?duration 2)
	:condition (and
		(at start (store_of ?y ?x))
		(at start (full ?y))
		(at start (xfreex ?x))
	)
	:effect (and
		(at start (not (full ?y)))
		(at end (empty ?y))
		(at start (not (xfreex ?x)))
		(at end (xfreex ?x))
	)
)


(:durative-action calibrate
	:parameters (?r - rover ?i - camera ?t - objective ?w - waypoint)
	:duration (= ?duration 2)
	:condition (and
		(at start (equipped_for_imaging ?r))
		(at start (calibration_target ?i ?t))
		(at start (at ?r ?w))
		(at start (visible_from ?t ?w))
		(at start (on_board ?i ?r))
		(at start (xfreex ?r))
	)
	:effect (and
		(at end (calibrated ?i ?r))
		(at start (not (xfreex ?r)))
		(at end (xfreex ?r))
	)
)


(:durative-action take_image
	:parameters (?r - rover ?p - waypoint ?o - objective ?i - camera ?m - mode)
	:duration (= ?duration 2)
	:condition (and
		(at start (calibrated ?i ?r))
		(at start (on_board ?i ?r))
		(at start (equipped_for_imaging ?r))
		(at start (supports ?i ?m))
		(at start (visible_from ?o ?p))
		(at start (at ?r ?p))
		(at start (xfreex ?r))
	)
	:effect (and
		(at end (have_image ?r ?o ?m))
		(at start (not (calibrated ?i ?r)))
		(at start (not (xfreex ?r)))
		(at end (xfreex ?r))
	)
)


(:durative-action communicate_soil_data
	:parameters (?r - rover ?l - lander ?p - waypoint ?x - waypoint ?y - waypoint)
	:duration (= ?duration 2)
	:condition (and
		(at start (at ?r ?x))
		(at start (at_lander ?l ?y))
		(at start (have_soil_analysis ?r ?p))
		(at start (visible ?x ?y))
		(at start (available ?r))
		(at start (channel_free ?l))
		(at start (xfreex ?r))
	)
	:effect (and
		(at start (not (available ?r)))
		(at start (not (channel_free ?l)))
		(at end (channel_free ?l))
		(at end (communicated_soil_data ?p))
		(at end (available ?r))
		(at start (not (xfreex ?r)))
		(at end (xfreex ?r))
	)
)


(:durative-action communicate_rock_data
	:parameters (?r - rover ?l - lander ?p - waypoint ?x - waypoint ?y - waypoint)
	:duration (= ?duration 2)
	:condition (and
		(at start (at ?r ?x))
		(at start (at_lander ?l ?y))
		(at start (have_rock_analysis ?r ?p))
		(at start (visible ?x ?y))
		(at start (available ?r))
		(at start (channel_free ?l))
		(at start (xfreex ?r))
	)
	:effect (and
		(at start (not (available ?r)))
		(at start (not (channel_free ?l)))
		(at end (channel_free ?l))
		(at end (communicated_rock_data ?p))
		(at end (available ?r))
		(at start (not (xfreex ?r)))
		(at end (xfreex ?r))
	)
)


(:durative-action communicate_image_data
	:parameters (?r - rover ?l - lander ?o - objective ?m - mode ?x - waypoint ?y - waypoint)
	:duration (= ?duration 2)
	:condition (and
		(at start (at ?r ?x))
		(at start (at_lander ?l ?y))
		(at start (have_image ?r ?o ?m))
		(at start (visible ?x ?y))
		(at start (available ?r))
		(at start (channel_free ?l))
		(at start (xfreex ?r))
	)
	:effect (and
		(at start (not (available ?r)))
		(at start (not (channel_free ?l)))
		(at end (channel_free ?l))
		(at end (communicated_image_data ?o ?m))
		(at end (available ?r))
		(at start (not (xfreex ?r)))
		(at end (xfreex ?r))
	)
)

)
