; written by distinguishing oracle
(set-logic BV)
(define-fun add (( parameter0 (_ BitVec 8))( parameter1 (_ BitVec 8))) (_ BitVec 8) parameter1)
(define-fun f1 ((a1 (_ BitVec 8)) (a2 (_ BitVec 8)))  (_ BitVec 8) ( bvsub (_ bv0 8) (_ bv0 8) ) )
(declare-const i1 (_ BitVec 8))
(declare-const i2 (_ BitVec 8))

(assert
    (not (= 
        (f1 i1 i2)
        (add i1 i2)
        ))
    )

(check-sat)
(get-model)
