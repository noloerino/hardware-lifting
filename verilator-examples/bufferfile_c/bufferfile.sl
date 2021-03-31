(set-logic BV)

(synth-fun storeVal 
	((oldvalue (_ BitVec 8)) (addr (_ BitVec 4)) (newval (_ BitVec 8))) 
		(_ BitVec 8)
	; non-terminals
	(
		(V (_ BitVec 8)) 
		; (B Bool)
	)

	; grammar rules
	( 
	 (V (_ BitVec 8)
		(newval)
	 )
	 ; (B Bool
	 ; 	(= addr (_ bv4 4))
	 ; )
	)
)

(declare-var a1 (_ BitVec 4))
(declare-var v1 (_ BitVec 8))
; (declare-var a2 (_ BitVec 32))
; (declare-var v2 (_ BitVec 32))

; (assume (= a2 (_ bv4 4)))

(declare-oracle-fun rfsc ./obj_dir/Vtop 
	((_ BitVec 4) (_ BitVec 8)) 
	;(_ BitVec 4) (_ BitVec 8)) 
	(_ BitVec 8))



(constraint (= 
	;(storeVal 
	v1
	; (_ bv1 8)
	; (storeVal (_ bv0 8) a1 v1) 
	;(_ bv4 4) v2) 
	(rfsc a1 v1 
	;(_ bv4 4) v2)
	)))

(check-synth)
