sat
(model 
  (define-fun i1 () (_ BitVec 8)
    #xff)
  (define-fun i2 () (_ BitVec 8)
    #xff)
  (define-fun f1 ((x!0 (_ BitVec 8)) (x!1 (_ BitVec 8))) (_ BitVec 8)
    #x00)
  (define-fun funcand ((x!0 (_ BitVec 8)) (x!1 (_ BitVec 8))) (_ BitVec 8)
    (bvnot (bvor (bvnot x!1) (bvnot x!0))))
)
