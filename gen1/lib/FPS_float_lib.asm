        .TEXT
        .GLOB load_SR, load_FN
        .GLOB load_FP
L_FN:   load_FN
L_SR:   load_SR

;AC0 is pointer, AC1 is MA
load_FP:STA 3,SR_RET
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
