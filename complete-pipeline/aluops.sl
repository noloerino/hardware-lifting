(set-logic BV)

(synth-fun add
	((reg1 (_ BitVec 8)) (reg2 (_ BitVec 8))) (_ BitVec 8)
	; non-terminals
	(
		(V (_ BitVec 8))
	)
	; grammar rules
	(
	 (
	 	V 
	 	; (_ BitVec 8) 
	 	; (reg1 (_ bv4 8)) (reg2 (_ bv4 8)) 
	 	(bvadd reg1 reg2) 
	 	; (bvsub V V)
	 )
	)
)

(synth-fun sub
	((reg1 (_ BitVec 8)) (reg2 (_ BitVec 8))) (_ BitVec 8)
	; non-terminals
	(
		(V (_ BitVec 8))
	)
	; grammar rules
	(
		(V (_ BitVec 8) reg1 reg2 (bvadd V V) (bvsub V V))
	)
)

(declare-oracle-fun corr-oracle ./correctness/yosys-correctness.sh
	((-> (_ BitVec 8) (_ BitVec 8) (_ BitVec 8)))
	Bool
	)

; (declare-oracle-fun corr-oracle-add ./corr-add.sh
; 	((-> (_ BitVec 8) (_ BitVec 8) (_ BitVec 8)))
; 	Bool
; 	)

; (declare-oracle-fun corr-oracle-sub ./corr-sub.sh
; 	((-> (_ BitVec 8) (_ BitVec 8) (_ BitVec 8)))
; 	Bool
; 	)

(constraint (corr-oracle add))
(constraint (corr-oracle sub))
; (constraint (corr-oracle-add add))
; (constraint (corr-oracle-sub sub))

; distinguishing oracle
(oracle-constraint 
	./distinguisher/distinguish-add.sh 
	(
		(add (-> (_ BitVec 8) (_ BitVec 8) (_ BitVec 8)))
		; (f2 (-> (_ BitVec 8) (_ BitVec 4) (_ BitVec 8) (_ BitVec 8)))
		)
	(
		(correct Bool)
		; (opcode (_ BitVec 4))
		(reg1 (_ BitVec 8)) 
		; (i_addr (_ BitVec 4)) 
		(reg2 (_ BitVec 8))
		(regD (_ BitVec 8))
		)
	(=> (not correct) 
			(= 	(add reg1 reg2) 
				regD))
	)

(oracle-constraint 
	./distinguisher/distinguish-sub.sh 
	(
		(sub (-> (_ BitVec 8) (_ BitVec 8) (_ BitVec 8)))
		; (f2 (-> (_ BitVec 8) (_ BitVec 4) (_ BitVec 8) (_ BitVec 8)))
		)
	(
		(correct Bool)
		; (opcode (_ BitVec 4))
		(reg1 (_ BitVec 8)) 
		; (i_addr (_ BitVec 4)) 
		(reg2 (_ BitVec 8))
		(regD (_ BitVec 8))
		)
	(=> (not correct) 
			(= 	(sub reg1 reg2) 
				regD))
	)

(check-synth)