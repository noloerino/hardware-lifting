(set-logic BV)

(synth-fun alu 
    ; inputs: A, B, operation
    ((io_A (_ BitVec 32)) (io_B (_ BitVec 32)) (io_alu_op (_ BitVec 4)))
    ; returns: calculated output
    (_ BitVec 32)
    ; non-terminals
    (
        (BV32 (_ BitVec 32))
        (BV4 (_ BitVec 4))
        (B Bool)
    )

    ; grammar rules
    (
        (BV32 (_ BitVec 32) (
            io_A io_B
            ; (bvadd BV32 BV32)
            ; (bvneg BV)
            (ite B BV BV)
            )
        )
        (BV4 (_ BitVec 4) (
            io_alu_op
            #x0 #x1 #x2 #x3
            #x4 #x5 #x6 #x7
            #x8 #x9 #xA #xB
            #xC #xD #xE #xF
            (ite B BV4 BV4)
            )
        )
        (B Bool (
            (and B B) (or B B) (not B)
            (= BV32 BV32) ; (bvsle BV32 BV32) (bvsge BV32 BV32) (bvslt BV32 BV32) (bvsgt BV32 BV32)
            (= BV4 BV4) ; (bvsle BV4 BV4) (bvsge BV4 BV4) (bvslt BV4 BV4) (bvsgt BV4 BV4)
            )
        )
    )
)

(declare-var a (_ BitVec 32))
(declare-var b (_ BitVec 32))
(declare-var sel (_ BitVec 4))

(declare-oracle-fun sim ./obj_dir/VALUSimple ((_ BitVec 32) (_ BitVec 32) (_ BitVec 4)) (_ BitVec 32))

; 10 = copy_a, 11 = copy_b
(assert (or (= sel #xA) (= sel #xB)))
(constraint (=> (= sel #xA) (= (alu a b sel) a)))
(constraint (=> (= sel #xB) (= (alu a b sel) b)))
(constraint (= (alu a b sel) (sim a b sel)))

(check-synth)