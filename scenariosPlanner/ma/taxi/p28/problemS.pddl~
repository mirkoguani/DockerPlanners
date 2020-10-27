(define (problem taxi-19) (:domain taxi)
(:objects
	g3 - location
	t2 - taxi
	p3 - passenger
	p4 - passenger
	p1 - passenger
	t1 - taxi
	p2 - passenger
	g2 - location
	d - location
	g1 - location
	h1 - location
	c - location
	e - location
	p7 - passenger
	h2 - location
	p5 - passenger
	h3 - location
	p6 - passenger
	t3 - taxi
)
(:init
	(xfreex p4)
	(xfreex p3)
	(xfreex t2)
	(xfreex p1)
	(xfreex t1)
	(xfreex p2)
	(xfreex p7)
	(xfreex p5)
	(xfreex p6)
	(xfreex t3)
	(directly-connected g1 c)
	(directly-connected g1 d)
	(directly-connected g1 e)
	(directly-connected g2 c)
	(directly-connected g2 d)
	(directly-connected g2 e)
	(directly-connected g3 c)
	(directly-connected g3 d)
	(directly-connected g3 e)
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
	(directly-connected d e)
	(directly-connected d h1)
	(directly-connected d h2)
	(directly-connected d h3)
	(directly-connected h1 c)
	(directly-connected h1 d)
	(directly-connected h1 e)
	(directly-connected h1 h2)
	(directly-connected h2 c)
	(directly-connected h2 d)
	(directly-connected h2 e)
	(directly-connected h2 h1)
	(directly-connected h2 h3)
	(directly-connected h3 c)
	(directly-connected h3 d)
	(directly-connected h3 e)
	(directly-connected h3 h2)
	(directly-connected e g1)
	(directly-connected e g2)
	(directly-connected e g3)
	(directly-connected e h1)
	(directly-connected e h2)
	(directly-connected e h3)
	(directly-connected e d)
	(at t1 g1)
	(at t2 d)
	(at t3 c)
	(empty t1)
	(empty t2)
	(empty t3)
	(at p1 h1)
	(at p2 h2)
	(at p3 h3)
	(at p4 d)
	(at p5 g3)
	(at p6 h1)
	(at p7 c)
	(free e)
	(free h1)
	(free h2)
	(free h3)
	(free g2)
	(free g3)
	(goal-of p1 h2)
	(goal-of p2 h3)
	(goal-of p3 c)
	(goal-of p4 c)
	(goal-of p5 d)
	(goal-of p6 h3)
	(goal-of p7 e)
	(= (time-travelled t1) 0)
	(= (time-travelled t2) 0)
	(= (time-travelled t3) 0)
)
(:goal
	(and
		(at t1 e)
		(at t2 d)
		(at t3 c)
		(at p1 h2)
		(at p2 h3)
		(at p3 c)
		(at p4 c)
		(at p5 d)
		(at p6 h3)
		(at p7 e)
;		(> (time-travelled t1) 400)
	)
)

(:metric maximize (time-travelled t1))
;(:metric minimize (time-travelled t1))


)
