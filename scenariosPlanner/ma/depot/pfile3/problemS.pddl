(define (problem depotprob1935) (:domain depot)
(:objects
	crate0 - crate
	distributor1 - distributor
	crate4 - crate
	crate5 - crate
	distributor0 - distributor
	pallet0 - pallet
	pallet1 - pallet
	depot0 - depot
	hoist2 - hoist
	hoist1 - hoist
	truck1 - truck
	pallet2 - pallet
	driver1 - driver
	crate1 - crate
	crate2 - crate
	truck0 - truck
	driver0 - driver
	hoist0 - hoist
	crate3 - crate
)
(:init
	(xfreex depot0)
	(xfreex driver0)
	(xfreex distributor1)
	(xfreex driver1)
	(xfreex distributor0)
	(driving driver0 truck0)
	(driving driver1 truck1)
	(at pallet0 depot0)
	(clear crate1)
	(at pallet1 distributor0)
	(clear crate4)
	(at pallet2 distributor1)
	(clear crate5)
	(at truck0 depot0)
	(at truck1 distributor0)
	(at hoist0 depot0)
	(available depot0 hoist0)
	(at hoist1 distributor0)
	(available distributor0 hoist1)
	(at hoist2 distributor1)
	(available distributor1 hoist2)
	(at crate0 distributor0)
	(on crate0 pallet1)
	(at crate1 depot0)
	(on crate1 pallet0)
	(at crate2 distributor1)
	(on crate2 pallet2)
	(at crate3 distributor0)
	(on crate3 crate0)
	(at crate4 distributor0)
	(on crate4 crate3)
	(at crate5 distributor1)
	(on crate5 crate2)
)
(:goal
	(and
		(on crate0 crate1)
		(on crate1 pallet2)
		(on crate2 pallet0)
		(on crate3 crate2)
		(on crate4 pallet1)
		(on crate5 crate0)
	)
)
)