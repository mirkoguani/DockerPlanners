(define (problem taxi-19) (:domain taxi)
(:objects
	t3 - taxi
	g3 - location
	t2 - taxi
	p1 - passenger
	m3 - location
	l1 - location
	l12 - location
	p3 - passenger
	p2 - passenger
	g2 - location
	m2 - location
	l21 - location
	m1 - location
	l32 - location
	t1 - taxi
	h3 - location
	h2 - location
	g1 - location
	h1 - location
	l22 - location
	l31 - location
	l11 - location
)
(:init
	(xfreex t3)
	(xfreex t1)
	(xfreex p2)
	(xfreex p3)
	(xfreex t2)
	(xfreex p1)
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
	(directly-connected h1 l11)
	(directly-connected l11 h1)
	(directly-connected l11 l12)
	(directly-connected l12 l11)
	(directly-connected l12 m1)
	(directly-connected m1 l12)
	(directly-connected h2 l21)
	(directly-connected l21 h2)
	(directly-connected l21 l22)
	(directly-connected l22 l21)
	(directly-connected l22 m2)
	(directly-connected m2 l22)
	(directly-connected h3 l31)
	(directly-connected l31 h3)
	(directly-connected l31 l32)
	(directly-connected l32 l31)
	(directly-connected l32 m3)
	(directly-connected m3 l32)
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
	(free l11)
	(free l12)
	(free l21)
	(free l22)
	(free l31)
	(free l32)
	(free m1)
	(free m2)
	(free m3)
	(goal-of p1 g1)
	(goal-of p2 g2)
	(goal-of p3 g3)
	(= (time-travelled t1) 0)
	(= (time-travelled t2) 0)
	(= (time-travelled t3) 0)
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

(:metric minimize 
			(time-travelled t1)
        
    )

)
