(set-logic BV)


(synth-fun sub
	((parameter0 (_ BitVec 8)) (parameter1 (_ BitVec 8))) (_ BitVec 8)
	; non-terminals
	(
		(V (_ BitVec 8))
	)
	; grammar rules
	(
		(V (_ BitVec 8) (parameter0 parameter1 (bvadd V V) (bvsub V V)))
	)
)

; (define-fun add ((reg1 (_ BitVec 8)) (reg1 (_ BitVec 8))) (_ BitVec 8) (bvadd reg1 reg2))
(synth-fun add
	((parameter0 (_ BitVec 8)) (parameter1 (_ BitVec 8))) (_ BitVec 8)
	; non-terminals
	(
		(V1 (_ BitVec 8))
	)
	; grammar rules
	(
		(V1 (_ BitVec 8) (parameter0 parameter1 (bvadd V1 V1) (bvsub V1 V1) (bvand V1 V1) (bvor V1 V1)))
	)
)


(synth-fun funcand
	((parameter0 (_ BitVec 8)) (parameter1 (_ BitVec 8))) (_ BitVec 8)
	; non-terminals
	(
		(V2 (_ BitVec 8))
	)
	; grammar rules
	(
		(V2 (_ BitVec 8) (parameter0 parameter1 (bvadd V2 V2) (bvsub V2 V2) (bvand V2 V2) (bvor V2 V2)))
	)
)


(synth-fun funcor
	((parameter0 (_ BitVec 8)) (parameter1 (_ BitVec 8))) (_ BitVec 8)
	; non-terminals
	(
		(V3 (_ BitVec 8))
	)
	; grammar rules
	(
		(V3 (_ BitVec 8) (parameter0 parameter1 (bvadd V3 V3) (bvsub V3 V3) (bvand V3 V3) (bvor V3 V3)))
	)
)

; (synth-fun addOpcode () (_ BitVec 4))
; (synth-fun subOpcode () (_ BitVec 4))

; (synth-fun aluTrans1 
; 	((opcode (_ BitVec 4)) (reg1 (_ BitVec 8)) (reg2 (_ BitVec 8)))
; 		(regAInd (_ BitVec 2)) (regBInd (_ BitVec 2)) (regDInd (_ BitVec 2)) 
; 		(reg1 (_ BitVec 8)) (reg2 (_ BitVec 8)) (reg3 (_ BitVec 8)) (reg4 (_ BitVec 8))
; 		) 
; 	(_ BitVec 8)
; 	(
; 		(V (_ BitVec 8))
; 		(B Bool)
; 	)
; 	; grammar rules
; 	(
; 	 	(V (_ BitVec 8) (reg1 reg2 (bvadd V V) (bvsub V V)
; 	 		(ite B V V)))
; 	 	(B Bool ((and B B) (= opcode (_ bv0 4)) (= opcode (_ bv1 4))))
; 	)
; )


; (synth-fun updateR1
; 	((opcode (_ BitVec 4)) (regAInd (_ BitVec 2)) (regBInd (_ BitVec 2)) (regDInd (_ BitVec 2))
; 		(reg1 (_ BitVec 8)) (reg2 (_ BitVec 8)) (reg3 (_ BitVec 8)) (reg4 (_ BitVec 8)))
; 	(_ BitVec 8)
; 	)

; (define-fun add
; 	((reg1 (_ BitVec 8)) (reg2 (_ BitVec 8))) (_ BitVec 8)
; 	(aluTrans1 (_ bv0 4) reg1 reg2)
; 	)

; (define-fun sub
; 	((reg1 (_ BitVec 8)) (reg2 (_ BitVec 8))) (_ BitVec 8)
; 	(aluTrans1 (_ bv1 4) reg1 reg2)
; 	)

(declare-oracle-fun corr-oracle ./correctness-with-opcode/yosys-correctness.sh
	 ((-> (_ BitVec 8) (_ BitVec 8) (_ BitVec 8)))
	Bool
	)

; (declare-oracle-fun corr-oracle-add ./corr-add.sh
; 	((-> (_ BitVec 1) (_ BitVec 1) (_ BitVec 8) (_ BitVec 8) (_ BitVec 8) (_ BitVec 8) (_ BitVec 8)))
; 	Bool
; 	)

; (declare-oracle-fun corr-oracle-sub ./corr-sub.sh
; 	((-> (_ BitVec 8) (_ BitVec 8) (_ BitVec 8)))
; 	Bool
; 	)

(constraint 
	(and (corr-oracle sub) 
	(and (corr-oracle funcand) 
		(and (corr-oracle funcor) 
	(corr-oracle add)))
))
; ))
; (constraint (and (corr-oracle-sub sub) (corr-oracle-add add)))
; (constraint (corr-oracle add))
; (constraint (corr-oracle sub))
; (constraint (corr-oracle-add add))
; (constraint (corr-oracle-sub sub))

(oracle-constraint
	./random-io-oracles/random-add.py
	(
		)
	(
		(reg1 (_ BitVec 8)) 
		(reg2 (_ BitVec 8)) 
		(regOut (_ BitVec 8)) 
		)
	(= 	(add reg1 reg2) 
				regOut)
	)

(oracle-constraint
	./random-io-oracles/random-sub.py
	(
		)
	(
		(reg1 (_ BitVec 8)) 
		(reg2 (_ BitVec 8)) 
		(regOut (_ BitVec 8)) 
		)
	(= 	(sub reg1 reg2) 
				regOut)
	)

(oracle-constraint
	./random-io-oracles/random-or.py
	(
		)
	(
		(reg1 (_ BitVec 8)) 
		(reg2 (_ BitVec 8)) 
		(regOut (_ BitVec 8)) 
		)
	(= 	(funcor reg1 reg2) 
				regOut)
	)

(oracle-constraint
	./random-io-oracles/random-and.py
	(
		)
	(
		(reg1 (_ BitVec 8)) 
		(reg2 (_ BitVec 8)) 
		(regOut (_ BitVec 8)) 
		)
	(= 	(funcand reg1 reg2) 
				regOut)
	)


; distinguishing oracle
; (oracle-constraint 
; 	./distinguisher/distinguish-add.sh 
; 	(
; 		(add (-> (_ BitVec 8)(_ BitVec 8) (_ BitVec 8)))
; 		; (f2 (-> (_ BitVec 8) (_ BitVec 4) (_ BitVec 8) (_ BitVec 8)))
; 		)
; 	(
; 		(correct Bool)
; 		; (opcode (_ BitVec 4))
; 		; (rega (_ BitVec 2)) 
; 		; (regb (_ BitVec 2)) 

; 		(reg1 (_ BitVec 8)) 
; 		(reg2 (_ BitVec 8)) 
; 		; (i_addr (_ BitVec 4)) 
; 		; (reg3 (_ BitVec 8))
; 		; (reg4 (_ BitVec 8))
; 		(regOut (_ BitVec 8)) 
; 		)
; 	(=> (not correct) 
; 			(= 	(add reg1 reg2) 
; 				regOut))
; 	)

; (oracle-constraint 
; 	./distinguisher/distinguish-sub.sh 
; 	(
; 		(sub (-> (_ BitVec 8) (_ BitVec 8) (_ BitVec 8)))
; 		; (f2 (-> (_ BitVec 8) (_ BitVec 4) (_ BitVec 8) (_ BitVec 8)))
; 		)
; 	(
; 		(correct Bool)
; 		; (opcode (_ BitVec 4))
; 		(reg1 (_ BitVec 8)) 
; 		; (i_addr (_ BitVec 4)) 
; 		(reg2 (_ BitVec 8))
; 		(regD (_ BitVec 8))
; 		)
; 	(=> (not correct) 
; 			(= 	(sub reg1 reg2) 
; 				regD))
; 	)
; (oracle-constraint 
; 	./distinguisher/distinguish-or.sh 
; 	(
; 		(funcor (-> (_ BitVec 8) (_ BitVec 8) (_ BitVec 8)))
; 		; (f2 (-> (_ BitVec 8) (_ BitVec 4) (_ BitVec 8) (_ BitVec 8)))
; 		)
; 	(
; 		(correct Bool)
; 		; (opcode (_ BitVec 4))
; 		(reg1 (_ BitVec 8)) 
; 		; (i_addr (_ BitVec 4)) 
; 		(reg2 (_ BitVec 8))
; 		(regD (_ BitVec 8))
; 		)
; 	(=> (not correct) 
; 			(= 	(funcor reg1 reg2) 
; 				regD))
; 	)

; (oracle-constraint 
; 	./distinguisher/distinguish-and.sh 
; 	(
; 		(funcand (-> (_ BitVec 8) (_ BitVec 8) (_ BitVec 8)))
; 		; (f2 (-> (_ BitVec 8) (_ BitVec 4) (_ BitVec 8) (_ BitVec 8)))
; 		)
; 	(
; 		(correct Bool)
; 		; (opcode (_ BitVec 4))
; 		(reg1 (_ BitVec 8)) 
; 		; (i_addr (_ BitVec 4)) 
; 		(reg2 (_ BitVec 8))
; 		(regD (_ BitVec 8))
; 		)
; 	(=> (not correct) 
; 			(= 	(funcand reg1 reg2) 
; 				regD))
; 	)

(check-synth)