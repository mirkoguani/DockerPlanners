(define (problem taxi-10)

	(:domain taxi)
	
	(:objects
		t1 t2 t3 - taxi
		p1 p2 p3 p4 - passenger
		g1 g2 g3 c d h1 h2 h3 - location
	)
		
	(:init
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
		(goal-of p1 d)
		(goal-of p2 h1)
		(goal-of p3 h2)
		(goal-of p4 h3)
	)
	
	(:goal 	
		(and	(at t1 g1)
				(at t2 g2)
				(at t3 g3)
				(at p1 d)
				(at p2 h1)
				(at p3 h2)
				(at p4 h3)
		)
	)
)
