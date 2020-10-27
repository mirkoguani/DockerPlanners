(define (problem logistics-11-0) (:domain logistics)
(:objects
	apn1 - airplane
	apt4 - airport
	obj43 - package
	tru2 - truck
	pos2 - location
	obj31 - package
	cit3 - city
	cit2 - city
	pos1 - location
	tru1 - truck
	obj33 - package
	tru3 - truck
	apt1 - airport
	obj22 - package
	obj13 - package
	obj42 - package
	apt3 - airport
	obj32 - package
	cit1 - city
	obj21 - package
	pos3 - location
	obj41 - package
	tru4 - truck
	obj23 - package
	obj11 - package
	pos4 - location
	obj12 - package
	cit4 - city
	apt2 - airport
)
(:init
	(xfreex apn1)
	(xfreex tru1)
	(xfreex tru4)
	(xfreex tru2)
	(xfreex tru3)
	(at apn1 apt3)
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
	(at tru4 pos4)
	(at obj41 pos4)
	(at obj42 pos4)
	(at obj43 pos4)
	(in-city tru1 pos1 cit1)
	(in-city tru1 apt1 cit1)
	(in-city tru2 pos2 cit2)
	(in-city tru2 apt2 cit2)
	(in-city tru3 pos3 cit3)
	(in-city tru3 apt3 cit3)
	(in-city tru4 pos4 cit4)
	(in-city tru4 apt4 cit4)
)
(:goal
	(and
		(at obj33 apt1)
		(at obj22 apt2)
		(at obj43 pos4)
		(at obj11 pos1)
		(at obj23 pos1)
		(at obj31 pos1)
		(at obj12 apt2)
		(at obj13 pos4)
		(at obj42 apt2)
		(at obj21 pos4)
		(at obj41 pos4)
	)
)
)