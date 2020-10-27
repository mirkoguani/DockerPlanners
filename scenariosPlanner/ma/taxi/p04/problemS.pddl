(define (problem taxi-04) (:domain taxi)
(:objects
	p2 - passenger
	t2 - taxi
	h1 - location
	c - location
	g3 - location
	h3 - location
	h2 - location
	g1 - location
	p3 - passenger
	p1 - passenger
	t1 - taxi
	g2 - location
	t3 - taxi
)
(:init
	(xfreex p2)
	(xfreex t2)
	(xfreex p3)
	(xfreex p1)
	(xfreex t1)
	(xfreex t3)
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
	(at p2 h2)
	(at p3 h3)
	(free h1)
	(free h2)
	(free h3)
	(free c)
	(goal-of p1 h2)
	(goal-of p2 h3)
	(goal-of p3 h1)
)
(:goal
	(and
		(at t1 g1)
		(at t2 g2)
		(at t3 g3)
		(at p1 h2)
		(at p2 h3)
		(at p3 h1)
	)
)
)