(define (problem p) (:domain e)
(:objects
	o2 - heavyOb
	o4 - heavyOb
	loc7 - location
	loc3 - location
	a2 - person
	a1 - person
	loc6 - location
	o1 - lightOb
	o3 - lightOb
	a4 - person
	a3 - person
	loc2 - location
	loc1 - location
	loc4 - location
	loc5 - location
)
(:init
	(xfreex a4)
	(xfreex a2)
	(xfreex a1)
	(xfreex a3)
	(link loc1 loc2)
	(link loc2 loc1)
	(link loc3 loc2)
	(link loc2 loc3)
	(link loc2 loc4)
	(link loc4 loc2)
	(link loc5 loc4)
	(link loc4 loc5)
	(link loc4 loc7)
	(link loc7 loc6)
	(link loc6 loc5)
	(link loc5 loc6)
	(possible loc2 a1 )
	(possible loc3 a1 )
	(possible loc4 a1 )
	(possible loc5 a1 )
	(possible loc6 a1 )
	(possible loc7 a1 )
	(possible loc2 a2 )
	(possible loc4 a2 )
	(possible loc5 a2 )
	(possible loc6 a2 )
	(possible loc7 a2 )
	(possible loc4 a3 )
	(possible loc1 a3 )
	(possible loc3 a3 )
	(possible loc2 a3 )
	(possible loc5 a3 )
	(possible loc6 a4 )
	(possible loc5 a4 )
	(possible loc2 a4 )
	(possible loc3 a4 )
	(possible loc1 a4 )
	;(holds a2 o1)
	;(holds a3 o2)
	(empty a1)
	(empty a2)
	(empty a3)
	(empty a4)
	(strong a1)
	(strong a3)
	(at a1 loc1)
	(at a3 loc5)
	(at a2 loc3)
	(at a4 loc7)
	(ato o1 loc1)
	(ato o2 loc7)
	(ato o3 loc5)
	(ato o4 loc4)
)
(:goal
	(and
		(holds a2 o3)
		(holds a3 o2)
		(holds a4 o1)
		(holds a1 o4)
	)
)
(:metric minimize (total-time))
)