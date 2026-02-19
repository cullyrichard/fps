        .TEXT
        .GLOB load_SR, load_FN, read_LT, AP_RUN, AP_STOP, AP_STEP
;AC0 is FN
load_FN:STA 1,SAC1  ;store AC1 to SAC1
        LDA 1,FN_w  ;load AC1 with CMD: RSU(0) FN(22) PIO(03) Write(1)
        DOA 1,054   ;push AC1 to CMD
        DOB 0,054   ;push AC0 to FN
        LDA 1,SAC1  ;resor AC1
        JMP 0,3     ;jump mode3: AC3
;AC0 is SR
load_SR:STA 1,SAC1  ;store AC1 to SAC1
        LDA 1,SR_w  ;load AC1 with CMD: RSU(0) SR(21) PIO(03) Write(1)
        DOA 1,054   ;push AC1 to CMD
        DOB 0,054   ;push AC0 to SR
        LDA 1,SAC1  ;resor AC1
        JMP 0,3     ;jump mode3: AC3
;AC0 is LT
read_LT:STA 1,SAC1  ;store AC1 to SAC1
        LDA 1,LT_r  ;load AC1 with CMD: RSU(0) LT(23) PIO(03) Read(0)
        DOA 1,054   ;push AC1 to CMD
        DIB 0,054   ;pull LT to AC0
        LDA 1,SAC1  ;resor AC1
        JMP 0,3     ;jump mode3: AC3
;runs AP
AP_RUN: STA 3,FN_RET
        STA 0,SAC0
        LDA 0,FN_RUN
        JSR load_FN
        LDA 0,SAC0
        JMP @FN_RET
;stops AP
AP_STOP:STA 3,FN_RET
        STA 0,SAC0
        LDA 0,FN_STOP
        JSR load_FN
        LDA 0,SAC0
        JMP @FN_RET
;continue execution AP
AP_CONT:STA 3,FN_RET
        STA 0,SAC0
        LDA 0,FN_CONT
        JSR load_FN
        LDA 0,SAC0
        JMP @FN_RET
;steps AP
AP_STEP:STA 3,FN_RET
        STA 0,SAC0
        LDA 0,FN_STEP
        JSR load_FN
        LDA 0,SAC0
        JMP @FN_RET
;reset AP
AP_REST:STA 3,FN_RET
        STA 0,SAC0
        LDA 0,FN_REST
        JSR load_FN
        LDA 0,SAC0
        JMP @FN_RET
FN_RET: 0
SAC1:   0
SAC0:   0
SR_w:   0021031
FN_w:   0022031
LT_r:   0023030
FN_STOP:0100000
FN_RUN: 0040000
FN_CONT:0020000
FN_STEP:0010000
FN_REST:0004000