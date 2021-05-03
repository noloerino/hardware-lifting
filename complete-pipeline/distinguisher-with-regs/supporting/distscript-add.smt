; written by distinguishing oracle
(set-logic BV)
(define-fun add (( parameter0 (_ BitVec 2))( parameter1 (_ BitVec 2))( parameter2 (_ BitVec 8))( parameter3 (_ BitVec 8))( parameter4 (_ BitVec 8))( parameter5 (_ BitVec 8))) (_ BitVec 8) (bvadd reg1 reg1))
(define-fun f1 ((a1 (_ BitVec 2)) (a2 (_ BitVec 2)) (a3 (_ BitVec 8)) (a4 (_ BitVec 8)) (a5 (_ BitVec 8)) (a6 (_ BitVec 8)))  (_ BitVec 8) ( bvadd ( ite ( and ( = a2 (_ bv3 2) ) ( = a2 (_ bv3 2) ) ) a3 a3 ) ( ite ( and ( = a2 (_ bv3 2) ) ( = a2 (_ bv3 2) ) ) a3 a3 ) ) )
(declare-const i1 (_ BitVec 2))
(declare-const i2 (_ BitVec 2))
(declare-const i3 (_ BitVec 8))
(declare-const i4 (_ BitVec 8))
(declare-const i5 (_ BitVec 8))
(declare-const i6 (_ BitVec 8))

(assert
    (not (= 
        (f1 i1 i2 i3 i4 i5 i6)
        (add i1 i2 i3 i4 i5 i6)
        ))
    )

(check-sat)
(get-value (i1))
(get-value (i2))
(get-value (i3))
(get-value (i4))
(get-value (i5))
(get-value (i6))

