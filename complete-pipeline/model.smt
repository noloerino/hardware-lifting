(error "line 17 column 39: Sort mismatch at argument #1 for function (declare-fun add
             ((_ BitVec 2)
              (_ BitVec 2)
              (_ BitVec 8)
              (_ BitVec 8)
              (_ BitVec 8)
              (_ BitVec 8))
             (_ BitVec 8)) supplied sort is (_ BitVec 1)")
sat
(model 
  (define-fun i2 () (_ BitVec 8)
    #x00)
  (define-fun i1 () (_ BitVec 8)
    #x00)
  (define-fun i3 () (_ BitVec 8)
    #x00)
  (define-fun i0 () (_ BitVec 8)
    #x00)
  (define-fun fcorr ((x!0 (_ BitVec 8)) (x!1 (_ BitVec 8))) (_ BitVec 8)
    (bvadd x!1 x!0))
  (define-fun add ((x!0 (_ BitVec 2))
   (x!1 (_ BitVec 2))
   (x!2 (_ BitVec 8))
   (x!3 (_ BitVec 8))
   (x!4 (_ BitVec 8))
   (x!5 (_ BitVec 8))) (_ BitVec 8)
    (let ((a!1 (ite (= x!4 #b00)
                    x!3
                    (ite (= x!4 #b01) x!2 (ite (= x!4 #b10) x!1 x!0)))))
      (bvadd (ite (= x!5 #b00) x!3 (ite (= x!5 #b01) x!2 x!0)) a!1)))
)
