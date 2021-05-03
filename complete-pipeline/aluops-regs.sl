(set-logic BV)


; (synth-fun sub
; 	((reg1 (_ BitVec 8)) (reg2 (_ BitVec 8))) (_ BitVec 8)
; 	; non-terminals
; 	(
; 		(V (_ BitVec 8))
; 	)
; 	; grammar rules
; 	(
; 		(V (_ BitVec 8) (reg1 reg2 (bvadd V V) (bvsub V V)))
; 	)
; )

(synth-fun add
	((param0 (_ BitVec 1)) (param1 (_ BitVec 1)) 
		(param2 (_ BitVec 8)) (param3 (_ BitVec 8)) (param4 (_ BitVec 8)) (param5 (_ BitVec 8))) 
	(_ BitVec 8)
	; non-terminals
	(
		(V1 (_ BitVec 8)) (V2 (_ BitVec 8)) (V3 (_ BitVec 8)) (B Bool) (A (_ BitVec 1)) 
	)
	; grammar rules
	( 
		(V1 (_ BitVec 8) 
			(
				; reg1 reg2 reg3 reg4 
				(bvadd V2 V2)
			))
		(V2 (_ BitVec 8)
			(
				V3 (ite B V2 V2))
			)
		(V3 (_ BitVec 8) (param4 param5 param2 param3))
		;	 (bvsub V1 V1) (ite B V1 V1))) 
		(B Bool (true false (and B B) (= A (_ bv0 1)) (= A (_ bv1 1))
			(= A (_ bv2 1)) (= A (_ bv3 1))))
		(A (_ BitVec 1) (param0 param1))
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


; (declare-oracle-fun corr-oracle ./correctness/yosys-correctness.sh
; 	((-> (_ BitVec 8) (_ BitVec 8) (_ BitVec 8)))
; 	Bool
	; )

(declare-oracle-fun corr-oracle-add ./corr-add.sh
	((-> (_ BitVec 1) (_ BitVec 1) (_ BitVec 8) (_ BitVec 8) (_ BitVec 8) (_ BitVec 8) (_ BitVec 8)))
	Bool
	)

; (declare-oracle-fun corr-oracle-sub ./corr-sub.sh
; 	((-> (_ BitVec 8) (_ BitVec 8) (_ BitVec 8)))
; 	Bool
; 	)

; (constraint (and (corr-oracle sub) (corr-oracle add)))
; (constraint (and (corr-oracle-sub sub) (corr-oracle-add add)))
; (constraint (corr-oracle add))
; (constraint (corr-oracle sub))
(constraint (corr-oracle-add add))
; (constraint (corr-oracle-sub sub))

; distinguishing oracle
; (oracle-constraint 
; 	./distinguisher-with-regs/distinguish-add.sh 
; 	(
; 		(add (-> (_ BitVec 2) (_ BitVec 2) (_ BitVec 8) (_ BitVec 8) (_ BitVec 8) (_ BitVec 8) (_ BitVec 8)))
; 		; (f2 (-> (_ BitVec 8) (_ BitVec 4) (_ BitVec 8) (_ BitVec 8)))
; 		)
; 	(
; 		(correct Bool)
; 		; (opcode (_ BitVec 4))
; 		(rega (_ BitVec 2)) 
; 		(regb (_ BitVec 2)) 

; 		(reg1 (_ BitVec 8)) 
; 		(reg2 (_ BitVec 8)) 
; 		; (i_addr (_ BitVec 4)) 
; 		(reg3 (_ BitVec 8))
; 		(reg4 (_ BitVec 8))
; 		(regOut (_ BitVec 8)) 
; 		)
; 	(=> (not correct) 
; 			(= 	(add rega regb reg1 reg2 reg3 reg4) 
; 				regOut))
; 	)

(oracle-constraint
	./random-oracle.py
	(
		)
	(
		(rega (_ BitVec 1)) 
		(regb (_ BitVec 1)) 

		(reg1 (_ BitVec 8)) 
		(reg2 (_ BitVec 8)) 
		; (i_addr (_ BitVec 4)) 
		(reg3 (_ BitVec 8))
		(reg4 (_ BitVec 8))
		(regOut (_ BitVec 8)) 
		)
		(= 	(add rega regb reg1 reg2 reg3 reg4) 
			regOut)
	)

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

(check-synth)