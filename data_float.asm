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
        LDA 0,fp01_pt
        LDA 1,fp01_MA
        JSR LOAD_FP
        HALT
        JMP start

;floting point value fp01: 0.5?
fp01_pt:fp01_ex
fp01_MA:0000010         ;MA address
fp01_ex:0001000         ;value 1 exponent: 512 : 2^0 : 1
fp01_mh:0002000         ;value 1 mantissa high : 01 0000 0000 0000 : 0.5?
fp01_ml:0000000         ;value 1 mantissa low  : 0

;AC0 is pointer, AC1 is MA
LOAD_FP:STA 3,SR_RET
        STA 0,fp_ptr
        MOV 1,0         ;move AC1 to AC0
        JSR @L_SR       ;load SR
        LDA 0,FN_MA_D   ;load AC0 with MA deposit
        JSR @L_FN       ;load FN depositing SR to MA
        
        LDA 0,@fp_ptr   ;load AC0 first value exponent
        JSR @L_SR       ;load SR
        LDA 0,FN_D_EX   ;load AC0 with deposit to MD exponent
        JSR @L_FN       ;load FN depositing SR to MD exponent
        
        LDA 0,@fp_ptr+1 ;load AC0 first value upper mantissa
        JSR @L_SR       ;load SR
        LDA 0,FN_D_MH   ;load AC0 with deposit to MD upper mantissa
        JSR @L_FN       ;load FN depositing SR to MD upper mantissa
        
        LDA 0,@fp_ptr+2 ;load AC0 first value upper mantissa
        JSR @L_SR       ;load SR
        LDA 0,FN_D_ML   ;load AC0 with deposit to MD lower mantissa
        JSR @L_FN       ;load FN depositing SR to MD lower mantissa
        
        JMP @SR_RET
fp_ptr: 0
SR_RET: 0

;FN deposits
FN_MA_D:0001002         ;FN: deposit SR in MA
FN_D_EX:0001035         ;FN: deposit SR in MD[MA] expoent
FN_D_MH:0001055         ;FN: deposit SR in MD[MA] upper mantissa
FN_D_ML:0001075         ;FN: deposit SR in MD[MA] lower mantissa

