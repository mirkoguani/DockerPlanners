(define (problem taxi-02) (:domain taxi)
(:objects
	g3 - location
	p3 - passenger
	t1 - taxi
	h3 - location
	t3 - taxi
	g2 - location
	p2 - passenger
	t2 - taxi
	h2 - location
	g1 - location
	c - location
	h1 - location
	p1 - passenger
)
(:init
	(xfreex p1)
	(xfreex p3)
	(xfreex t1)
	(xfreex t3)
	(xfreex p2)
	(xfreex t2)
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
	(directly-connected h2 c)
	(directly-connected h3 c)
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
	(goal-of p1 c)
	(goal-of p2 c)
	(goal-of p3 c)
)
(:goal
	(and
		(at t1 g1)
		(at t2 g2)
		(at t3 g3)
		(at p1 c)
		(at p2 c)
		(at p3 c)
	)
)
)