(set-logic BV)

(synth-fun add
	((parameter0 (_ BitVec 2)) (parameter1 (_ BitVec 2)) 
		(parameter2 (_ BitVec 8)) (parameter3 (_ BitVec 8)) (parameter4 (_ BitVec 8)) (parameter5 (_ BitVec 8))) 
	(_ BitVec 8)
	; non-terminals
	(
		(V1 (_ BitVec 8)) (V2 (_ BitVec 8)) (V3 (_ BitVec 8)) (B Bool) (A (_ BitVec 2)) 
	)
	; grammar rules
	( 
		(V1 (_ BitVec 8) 
			(	
				(bvadd V2 V2)
			))
		(V2 (_ BitVec 8)
			(
				V3 (ite B V2 V2))
			)
		(V3 (_ BitVec 8) (parameter4 parameter5 parameter2 parameter3))
		(B Bool (true false (and B B) (= A (_ bv0 2)) (= A (_ bv1 2))
			(= A (_ bv2 2)) (= A (_ bv3 2))))
		(A (_ BitVec 2) (parameter0 parameter1))
	)
)

(declare-oracle-fun corr-oracle-add ./corr-add.sh
	((-> (_ BitVec 2) (_ BitVec 2) (_ BitVec 8) (_ BitVec 8) (_ BitVec 8) (_ BitVec 8) (_ BitVec 8)))
	Bool
	)

(constraint (corr-oracle-add add))
(oracle-constraint
	./random-oracle.py
	(
		)
	(
		(rega (_ BitVec 2)) 
		(regb (_ BitVec 2))
		(reg1 (_ BitVec 8)) 
		(reg2 (_ BitVec 8)) 
		(reg3 (_ BitVec 8))
		(reg4 (_ BitVec 8))
		(regOut (_ BitVec 8)) 
		)
		(= 	(add rega regb reg1 reg2 reg3 reg4) 
			regOut)
	)

(check-synth)