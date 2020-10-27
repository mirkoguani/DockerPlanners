(define (problem taxi-08) (:domain taxi)
(:objects
	p1 - passenger
	h2 - location
	p3 - passenger
	g1 - location
	d - location
	t3 - taxi
	p4 - passenger
	h3 - location
	g2 - location
	t2 - taxi
	t1 - taxi
	g3 - location
	c - location
	p2 - passenger
	h1 - location
)
(:init
	(xfreex t1)
	(xfreex p1)
	(xfreex p3)
	(xfreex t3)
	(xfreex p4)
	(xfreex t2)
	(xfreex p2)
	(directly-connected g1 c)
	(directly-connected g1 d)
	(directly-connected g2 c)
	(directly-connected g2 d)
	(directly-connected g3 c)
	(directly-connected g3 d)
	(directly-connected c g1)
	(directly-connected c g2)
	(directly-connected c g3)
	(directly-connected c d)
	(directly-connected c h1)
	(directly-connected c h2)
	(directly-connected c h3)
	(directly-connected d g1)
	(directly-connected d g2)
	(directly-connected d g3)
	(directly-connected d c)
	(directly-connected d h1)
	(directly-connected d h2)
	(directly-connected d h3)
	(directly-connected h1 c)
	(directly-connected h1 d)
	(directly-connected h1 h2)
	(directly-connected h2 c)
	(directly-connected h2 d)
	(directly-connected h2 h1)
	(directly-connected h2 h3)
	(directly-connected h3 c)
	(directly-connected h3 d)
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
	(at p4 d)
	(free h1)
	(free h2)
	(free h3)
	(free c)
	(free d)
	(goal-of p1 h2)
	(goal-of p2 h3)
	(goal-of p3 d)
	(goal-of p4 h1)
)
(:goal
	(and
		(at t1 g1)
		(at t2 g2)
		(at t3 g3)
		(at p1 h2)
		(at p2 h3)
		(at p3 d)
		(at p4 h1)
	)
)
)