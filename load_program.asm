        JMP reset       ;jump over pointers
        ;lib functions and function pointers
        .GLOB load_SR, load_FN, read_LT, AP_RUN, AP_STOP, AP_STEP
L_FN:   load_FN
L_SR:   load_SR
R_LT:   read_LT
RUN:    AP_RUN
STOP:   AP_STOP
STEP:   AP_STEP

        ;Store and load a floating point value at MA:010
reset:  NIOP 054        ;reset
start:  NIOS 054        ;set busy       
        LDA 0,SP_pt
        LDA 1,SP_TMA
        JSR LOAD_SP
        HALT
        JMP start

;floting point value fp01: 0.5?
SP_pt  :SP_0000
SP_TMA: 0000010         ;TMA address
SP_0000:0000000         ;SP value in address
SP_0001:0000000         ;SP value in address
SP_0002:0000000         ;SP value in address
SP_0003:0000000         ;SP value in address

;AC0 is pointer, AC1 is TMA
LOAD_SP:STA 3,SR_RET
        STA 0,sp_ptr
        MOV 1,0         ;move AC1 to AC0
        JSR @L_SR       ;load SR
        LDA 0,FN_TMA_D  ;load AC0 with TMA deposit
        JSR @L_FN       ;load FN depositing SR to TMA
        
        LDA 0,@sp_ptr   ;load AC0 Word 0
        JSR @L_SR       ;load SR
        LDA 0,FN_D_P0   ;load AC0 with deposit to SP[TMA] Word 0
        JSR @L_FN       ;load FN depositing SR to SP[TMA] Word 0
        
        LDA 0,@sp_ptr+1 ;load AC0 Word 1
        JSR @L_SR       ;load SR
        LDA 0,FN_D_P1   ;load AC0 with deposit to SP[TMA] Word 1
        JSR @L_FN       ;load FN depositing SR to SP[TMA] Word 1
        
        LDA 0,@sp_ptr+2 ;load AC0 Word 2
        JSR @L_SR       ;load SR
        LDA 0,FN_D_P2   ;load AC0 with deposit to SP[TMA] Word 2
        JSR @L_FN       ;load FN depositing SR to SP[TMA] Word 2
        
        LDA 0,@sp_ptr+3 ;load AC0 Word 3
        JSR @L_SR       ;load SR
        LDA 0,FN_D_P3   ;load AC0 with deposit to SP[TMA] Word 3
        JSR @L_FN       ;load FN depositing SR to SP[TMA] Word 3
        
        JMP @SR_RET
sp_ptr: 0
SR_RET: 0

;FN deposits
FN_TMA_D:0001003        ;FN: deposit SR in TMA
FN_D_P0: 0001010        ;FN: deposit SR in SP[TMA] P0
FN_D_P1: 0001030        ;FN: deposit SR in SP[TMA] P1
FN_D_P2: 0001050        ;FN: deposit SR in SP[TMA] P2
FN_D_P3: 0001070        ;FN: deposit SR in SP[TMA] P3

