(define (problem logistics-8-0) (:domain logistics)
(:objects
	tru1 - truck
	obj22 - package
	apn1 - airplane
	cit2 - city
	obj11 - package
	obj21 - package
	obj32 - package
	cit3 - city
	obj12 - package
	cit1 - city
	obj33 - package
	tru3 - truck
	apt2 - airport
	pos1 - location
	pos3 - location
	tru2 - truck
	apt3 - airport
	apt1 - airport
	obj13 - package
	pos2 - location
	obj31 - package
	obj23 - package
)
(:init
	(xfreex tru1)
	(xfreex tru3)
	(xfreex apn1)
	(xfreex tru2)
	(at apn1 apt1)
	(at tru1 pos1)
	(at obj11 pos1)
	(at obj12 pos1)
	(at obj13 pos1)
	(at tru2 pos2)
	(at obj21 pos2)
	(at obj22 pos2)
	(at obj23 pos2)
	(at tru3 pos3)
	(at obj31 pos3)
	(at obj32 pos3)
	(at obj33 pos3)
	(in-city tru1 pos1 cit1)
	(in-city tru1 apt1 cit1)
	(in-city tru2 pos2 cit2)
	(in-city tru2 apt2 cit2)
	(in-city tru3 pos3 cit3)
	(in-city tru3 apt3 cit3)
)
(:goal
	(and
		(at obj11 pos3)
		(at obj21 pos2)
		(at obj31 apt3)
		(at obj22 pos3)
		(at obj12 pos1)
		(at obj23 apt2)
		(at obj13 apt2)
		(at obj32 apt1)
	)
)
)