(define (problem taxi-19)

	(:domain taxi)
	
	(:objects
		t1 t2 t3 - taxi
		p1 p2 p3  - passenger
		g1 g2 g3 h1 h2 h3 - location
	)
		
	(:init
		(directly-connected g1 h1)
		(directly-connected h1 g1)
		(directly-connected g2 h2)
		(directly-connected h2 g2)
		(directly-connected g3 h3)
		(directly-connected h3 g3)
		(at t1 h1)
		(at t2 h2)
		(at t3 h3)
		(empty t1)
		(empty t2)
		(empty t3)
		(at p1 h1)
		(at p2 h2)
		(at p3 h3)
		(free g1)
		(free g2)
		(free g3)
		(goal-of p1 g1)
		(goal-of p2 g2)
		(goal-of p3 g3)
	)
	
	(:goal 	
		(and	(at t1 g1)
				(at t2 g2)
				(at t3 g3)
				(at p1 g1)
				(at p2 g2)
				(at p3 g3)
		)
	)
)
