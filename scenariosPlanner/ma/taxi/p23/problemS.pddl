(define (problem taxi-19) (:domain taxi)
(:objects
	g2 - location
	h1 - location
	t2 - taxi
	t1 - taxi
	t3 - taxi
	g1 - location
	h2 - location
	p1 - passenger
	p3 - passenger
	g3 - location
	h3 - location
	m3 - location
	p2 - passenger
	m1 - location
	m2 - location
)
(:init
	(xfreex p3)
	(xfreex p1)
	(xfreex t2)
	(xfreex t3)
	(xfreex p2)
	(xfreex t1)
	(directly-connected h1 m1)
	(directly-connected h2 m2)
	(directly-connected h3 m3)
	(directly-connected m1 h1)
	(directly-connected m2 h2)
	(directly-connected m3 h3)
	(directly-connected g1 m1)
	(directly-connected g2 m2)
	(directly-connected g3 m3)
	(directly-connected m1 g1)
	(directly-connected m2 g2)
	(directly-connected m3 g3)
	(at t1 h1)
	(at t2 h2)
	(at t3 h3)
	(empty t1)
	(empty t2)
	(empty t3)
	(at p1 m1)
	(at p2 m2)
	(at p3 m3)
	(free g1)
	(free g2)
	(free g3)
	(free m1)
	(free m2)
	(free m3)
	(goal-of p1 g1)
	(goal-of p2 g2)
	(goal-of p3 g3)
)
(:goal
	(and
		(at t1 g1)
		(at t2 g2)
		(at t3 g3)
		(at p1 g1)
		(at p2 g2)
		(at p3 g3)
	)
)
)