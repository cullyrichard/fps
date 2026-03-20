        .TEXT
        .GLOB load_SR, load_FN
        .GLOB load_PS
L_FN:   load_FN
L_SR:   load_SR

;AC0 is pointer, AC1 is TMA
load_PS:STA 3,SR_RET
        STA 0,ps_ptr
        MOV 1,0         ;move AC1 to AC0
        JSR @L_SR       ;load SR
        LDA 0,FN_TMA_D  ;load AC0 with TMA deposit
        JSR @L_FN       ;load FN depositing SR to TMA
        
        LDA 0,@ps_ptr   ;load AC0 Word 0
        JSR @L_SR       ;load SR
        LDA 0,FN_D_P0   ;load AC0 with deposit to PS[TMA] Word 0
        JSR @L_FN       ;load FN depositing SR to PS[TMA] Word 0
        
        LDA 0,@ps_ptr+1 ;load AC0 Word 1
        JSR @L_SR       ;load SR
        LDA 0,FN_D_P1   ;load AC0 with deposit to PS[TMA] Word 1
        JSR @L_FN       ;load FN depositing SR to PS[TMA] Word 1
        
        LDA 0,@ps_ptr+2 ;load AC0 Word 2
        JSR @L_SR       ;load SR
        LDA 0,FN_D_P2   ;load AC0 with deposit to PS[TMA] Word 2
        JSR @L_FN       ;load FN depositing SR to PS[TMA] Word 2
        
        LDA 0,@ps_ptr+3 ;load AC0 Word 3
        JSR @L_SR       ;load SR
        LDA 0,FN_D_P3   ;load AC0 with deposit to PS[TMA] Word 3
        JSR @L_FN       ;load FN depositing SR to PS[TMA] Word 3
        
        JMP @SR_RET
ps_ptr: 0
SR_RET: 0

;FN deposits
FN_TMA_D:0001003        ;FN: deposit SR in TMA
FN_D_P0: 0001010        ;FN: deposit SR in PS[TMA] P0
FN_D_P1: 0001030        ;FN: deposit SR in PS[TMA] P1
FN_D_P2: 0001050        ;FN: deposit SR in PS[TMA] P2
FN_D_P3: 0001070        ;FN: deposit SR in PS[TMA] P3