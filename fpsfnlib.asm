        ; Store increment load MA with function
        NIOP 054        ;reset
start:  NIOS 054        ;set busy
        LDA 0,test_MA   ;load AC0 test value
        JSR load_SR     ;load SR
        LDA 0,FN_MA_D   ;load AC0 with MA deposit increment
        JSR load_FN     ;load FN
        LDA 0,FN_MD_D   ;load AC0 with DM_MA deposit increment
        JSR load_FN     ;load FN
        LDA 0,FN_MA_E   ;load AC0 with MA examine to LN
        JSR load_FN     ;load FN
        JSR read_LT     ;read LT
        HALT            ;examine AC1
        JMP start

test_MA:0000010         ;MA address
FN_MA_D:0001102         ;FN_MA_D command
FN_MA_E:0002102         ;FN_MA_E command
FN_MD_D:0002115         ;FN_MD_D command

;AC0 is FN
load_FN:STA 3,FN_RET
        STA 1,SAC1
        LDA 1,FN_w
        DOA 1,054
        DOB 0,054
        LDA 1,SAC1
        JMP @FN_RET

;AC0 is SR
load_SR:STA 3,FN_RET
        STA 1,SAC1
        LDA 1,SR_w
        DOA 1,054
        DOB 0,054
        LDA 1,SAC1
        JMP @FN_RET

;AC0 is LT
read_LT:STA 3,FN_RET
        STA 1,SAC1
        LDA 1,LT_r 
        DOA 1,054
        DIB 0,054
        LDA 1,SAC1
        JMP @FN_RET

;runs AP
AP_RUN: STA 3,FN_RET2
        STA 0,SAC0
        LDA 0,FN_RUN
        JSR load_FN
        LDA 0,SAC0
        JMP @FN_RET2

;stops AP
AP_STOP:STA 3,FN_RET2
        STA 0,SAC0
        LDA 0,FN_STOP
        JSR load_FN
        LDA 0,SAC0
        JMP @FN_RET2

;steps AP
AP_STEP:STA 3,FN_RET2
        STA 0,SAC0
        LDA 0,FN_STEP
        JSR load_FN
        LDA 0,SAC0
        JMP @FN_RET2

FN_RET2:0
FN_RET: 0

SAC1:   0
SAC0:   0

SR_w:   0021031
FN_w:   0022031
LT_r:   0023030

FN_STOP:0100000
FN_RUN: 0040000
FN_STEP:0010000
