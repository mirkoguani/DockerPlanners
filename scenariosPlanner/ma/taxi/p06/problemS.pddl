(define (problem taxi-06) (:domain taxi)
(:objects
	t2 - taxi
	p3 - passenger
	h1 - location
	p2 - passenger
	c - location
	g3 - location
	p4 - passenger
	g1 - location
	t3 - taxi
	h2 - location
	p1 - passenger
	g2 - location
	h3 - location
	t1 - taxi
)
(:init
	(xfreex p4)
	(xfreex t2)
	(xfreex t3)
	(xfreex p3)
	(xfreex p1)
	(xfreex t1)
	(xfreex p2)
	(directly-connected g1 c)
	(directly-connected g2 c)
	(directly-connected g3 c)
	(directly-connected c g1)
	(directly-connected c g2)
	(directly-connected c g3)
	(directly-connected c h1)
	(directly-connected c h2)
	(directly-connected c h3)
	(directly-connected h1 c)
	(directly-connected h1 h2)
	(directly-connected h2 c)
	(directly-connected h2 h1)
	(directly-connected h2 h3)
	(directly-connected h3 c)
	(directly-connected h3 h2)
	(at t1 g1)
	(at t2 g2)
	(at t3 g3)
	(empty t1)
	(empty t2)
	(empty t3)
	(at p1 h1)
	(at p2 h1)
	(at p3 h2)
	(at p4 h2)
	(free h1)
	(free h2)
	(free h3)
	(free c)
	(goal-of p1 h2)
	(goal-of p2 h2)
	(goal-of p3 h1)
	(goal-of p4 h1)
)
(:goal
	(and
		(at t1 g1)
		(at t2 g2)
		(at t3 g3)
		(at p1 h2)
		(at p2 h2)
		(at p3 h1)
		(at p4 h1)
	)
)
)