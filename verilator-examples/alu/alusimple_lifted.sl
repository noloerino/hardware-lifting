(set-logic BV)

(synth-fun alu 
    ; inputs: A, B, operation
    ((io_A (_ BitVec 32)) (io_B (_ BitVec 32)) (io_alu_op (_ BitVec 1)))
    ; returns: calculated output
    (_ BitVec 32)
    ; non-terminals
    (
        (BV32 (_ BitVec 32))
        (BV1 (_ BitVec 1))
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
        (BV1 (_ BitVec 1) (
            io_alu_op
            #b0 #b1
            (ite B BV1 BV1)
            )
        )
        (B Bool (
            (and B B) (or B B) (not B)
            (= BV32 BV32)
            (= BV1 BV1)
            )
        )
    )
)

(declare-var a (_ BitVec 32))
(declare-var b (_ BitVec 32))
(declare-var sel (_ BitVec 1))

(declare-oracle-fun sim ./obj_dir/VALUSimple_Lifted ((_ BitVec 32) (_ BitVec 32) (_ BitVec 1)) (_ BitVec 32))

; 10 = copy_a, 11 = copy_b
; (assert (or (= sel #xA) (= sel #xB)))
(constraint (=> (= sel #b0) (= (alu a b sel) a)))
(constraint (=> (= sel #b1) (= (alu a b sel) b)))
(constraint (= (alu a b sel) (sim a b sel)))

(check-synth)