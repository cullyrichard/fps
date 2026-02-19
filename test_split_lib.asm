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

        LDA 0,fp01_MA   ;load AC0 first value address
        JSR @L_SR       ;load SR
        LDA 0,FN_MA_D   ;load AC0 with MA deposit
        JSR @L_FN       ;load FN depositing SR to MA

        LDA 0,fp01_ex   ;load AC0 first value exponent
        JSR @L_SR       ;load SR
        LDA 0,FN_D_EX   ;load AC0 with deposit to MD exponent
        JSR @L_FN       ;load FN depositing SR to MD exponent

        LDA 0,fp01_mh   ;load AC0 first value upper mantissa
        JSR @L_SR       ;load SR
        LDA 0,FN_D_MH   ;load AC0 with deposit to MD upper mantissa
        JSR @L_FN       ;load FN depositing SR to MD upper mantissa

        LDA 0,fp01_ml   ;load AC0 first value upper mantissa
        JSR @L_SR       ;load SR
        LDA 0,FN_D_ML   ;load AC0 with deposit to MD lower mantissa
        JSR @L_FN       ;load FN depositing SR to MD lower mantissa
	
        LDA 0,fp01_MA   ;load AC0 first value address
        JSR @L_SR       ;load SR
        LDA 0,FN_MA_D   ;load AC0 with MA deposit to initiate read
        JSR @L_FN       ;load FN depositing SR to MA

	LDA 0,FN_E_EX
        JSR @L_FN       ;load FN
        JSR @R_LT       ;read LT
        HALT            ;examine AC0 for exponent

	LDA 0,FN_E_EX
        JSR @L_FN       ;load FN
        JSR @R_LT       ;read LT
        HALT            ;examine AC0 for upper mantissa

	LDA 0,FN_E_EX
        JSR @L_FN       ;load FN
        JSR @R_LT       ;read LT
        HALT            ;examine AC0 for lower mantissa
        JMP start	;return to start

;floting point value fp01: 0.5?
fp01_MA:0000010         ;MA address
fp01_ex:0001000		;value 1 exponent: 512 : 2^0 : 1
fp01_mh:0002000		;value 1 mantissa high : 01 0000 0000 0000 : 0.5?
fp01_ml:0000000		;value 1 mantissa low  : 0
;FN deposits
FN_MA_D:0001002         ;FN: deposit SR in MA
FN_D_EX:0001035         ;FN: deposit SR in MD[MA] expoent
FN_D_MH:0001055         ;FN: deposit SR in MD[MA] upper mantissa
FN_D_ML:0001075         ;FN: deposit SR in MD[MA] lower mantissa
;FN examines
FN_E_EX:0002035         ;FN: examine to LT MD[MA] expoent
FN_E_MH:0002055         ;FN: examine to LT MD[MA] upper mantissa
FN_E_ML:0002075         ;FN: examine to LT MD[MA] lower mantissa

