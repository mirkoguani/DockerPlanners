(define (problem logistics-15-0) (:domain logistics)
(:objects
	pos2 - location
	obj12 - package
	obj53 - package
	tru1 - truck
	cit3 - city
	cit2 - city
	pos5 - location
	obj21 - package
	pos1 - location
	obj11 - package
	apt4 - airport
	apn2 - airplane
	obj52 - package
	cit4 - city
	obj31 - package
	obj23 - package
	pos4 - location
	tru5 - truck
	pos3 - location
	apt1 - airport
	apn1 - airplane
	obj51 - package
	tru4 - truck
	tru2 - truck
	obj41 - package
	apt2 - airport
	apt3 - airport
	apt5 - airport
	obj32 - package
	obj33 - package
	cit5 - city
	tru3 - truck
	cit1 - city
	obj43 - package
	obj13 - package
	obj22 - package
	obj42 - package
)
(:init
	(xfreex tru2)
	(xfreex tru3)
	(xfreex apn2)
	(xfreex tru5)
	(xfreex tru4)
	(xfreex apn1)
	(xfreex tru1)
	(at apn1 apt5)
	(at apn2 apt2)
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
	(at tru5 pos5)
	(at obj51 pos5)
	(at obj52 pos5)
	(at obj53 pos5)
	(in-city tru1 pos1 cit1)
	(in-city tru1 apt1 cit1)
	(in-city tru2 pos2 cit2)
	(in-city tru2 apt2 cit2)
	(in-city tru3 pos3 cit3)
	(in-city tru3 apt3 cit3)
	(in-city tru4 pos4 cit4)
	(in-city tru4 apt4 cit4)
	(in-city tru5 pos5 cit5)
	(in-city tru5 apt5 cit5)
)
(:goal
	(and
		(at obj22 apt4)
		(at obj31 apt4)
		(at obj43 pos5)
		(at obj13 apt1)
		(at obj23 pos4)
		(at obj12 pos2)
		(at obj51 pos3)
		(at obj32 pos3)
		(at obj11 apt3)
		(at obj42 apt2)
		(at obj52 apt4)
		(at obj33 apt3)
		(at obj21 pos3)
		(at obj53 apt2)
		(at obj41 apt1)
	)
)
)