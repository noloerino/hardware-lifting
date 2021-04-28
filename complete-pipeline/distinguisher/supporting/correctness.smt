(set-logic BV)
; written by the correctness oracle
(define-fun storeVal (( parameter0 (_ BitVec 8))( parameter1 (_ BitVec 8))) (_ BitVec 8) parameter1)

; generated by the correctness oracle

(declare-const i1 (_ BitVec 8))
(declare-const i2 (_ BitVec 8))
; (declare-const i3 (_ BitVec 8))

(define-fun fcorr ((x (_ BitVec 8)) (z (_ BitVec 8))) (_ BitVec 8) z)

(assert
	(not (= 
		(storeVal i1 i2)
		(fcorr i1 i2)
		))
	)

(check-sat)
(get-model)
