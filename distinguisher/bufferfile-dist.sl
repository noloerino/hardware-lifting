(set-logic BV)

(synth-fun storeVal
	((oldvalue (_ BitVec 8)) (newval (_ BitVec 8))) 
		(_ BitVec 8)
	; non-terminals
	(
		(V (_ BitVec 8)) 
		; (B Bool)
	)

	; grammar rules
	(
	 (V (_ BitVec 8)
		(oldvalue (_ bv4 8))
	 )
	 ; (B Bool
	 ; 	(= addr (_ bv4 4))
	 ; )
	)
)

(declare-oracle-fun io-oracle Vtop 
	((_ BitVec 8) (_ BitVec 8)) 
	;(_ BitVec 4) (_ BitVec 8)) 
	(_ BitVec 8))

(declare-oracle-fun corr-oracle ./corr.sh
	((-> (_ BitVec 8) (_ BitVec 8) (_ BitVec 8)))
	Bool
	)

; (declare-oracle-fun dist-oracle ./distinguish.sh
; 	((-> (_ BitVec 8) (_ BitVec 8) (_ BitVec 8)))
; 		(
; 			(correct Bool)
; 			(i_prev (_ BitVec 8)) 
; 			(i_curr (_ BitVec 8))
; 		)
; 	)

(constraint (corr-oracle storeVal))


; distinguishing oracle
(oracle-constraint 
	./distinguish.sh 
	(
		(storeVal (-> (_ BitVec 8) (_ BitVec 8) (_ BitVec 8)))
		; (f2 (-> (_ BitVec 8) (_ BitVec 4) (_ BitVec 8) (_ BitVec 8)))
		)
	(
		(correct Bool)
		(i_prev (_ BitVec 8)) 
		; (i_addr (_ BitVec 4)) 
		(i_curr (_ BitVec 8))
		(i_out (_ BitVec 8))
		)
	(=> (not correct) 
			(= 	(storeVal i_prev i_curr) 
				i_out))
	)

(check-synth)