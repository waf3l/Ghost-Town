

; PETSCII memory layout (example for a 40x25 screen)'
; byte  0         = border color'
; byte  1         = background color'
; bytes 2-1001    = screencodes'
; bytes 1002-2001 = color

screen_011 
!byte 0,0
!byte $A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$2E,$A0,$A0,$0B,$09,$0E,$07,$13,$2E,$06,$14,$20,$10,$12,$05,$13,$05,$0E,$14,$13,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$2E,$A0
!byte $A0,$A0,$2E,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$2E,$A0,$A0,$A0,$A0,$A0
!byte $A0,$A0,$A0,$2E,$A0,$2E,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$0F,$A0,$A0,$A0,$A0,$A0,$FE,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$2E,$A0,$A0,$A0,$A0,$2E,$A0,$A0
!byte $A0,$A0,$A0,$A0,$69,$E9,$68,$6C,$69,$E9,$A0,$A0,$69,$E9,$A0,$A0,$A0,$FE,$A0,$EC,$A0,$A0,$A0,$A0,$A0,$69,$E9,$A0,$FC,$A0,$68,$3A,$A0,$A0,$FC,$A0,$A0,$A0,$A0,$A0
!byte $E9,$A0,$F7,$68,$6C,$A0,$A0,$A0,$20,$A0,$D2,$A0,$E6,$A0,$D2,$D2,$DF,$D2,$A0,$D2,$7C,$FE,$D2,$A0,$D2,$68,$A0,$D2,$A0,$3A,$A0,$E6,$E1,$6C,$A0,$7B,$A0,$A0,$A0,$68
!byte $A0,$D2,$D2,$D2,$A0,$A0,$A0,$A0,$DF,$A0,$A0,$A0,$E6,$A0,$A0,$FC,$E6,$FB,$A0,$EC,$20,$20,$FB,$A0,$AC,$E6,$A0,$A0,$A0,$D0,$A0,$E6,$A0,$E6,$A0,$E8,$A0,$A0,$68,$A0
!byte $A0,$A0,$FE,$AE,$E8,$A0,$D2,$A0,$E6,$A0,$20,$A0,$E6,$D2,$D2,$A0,$E6,$5C,$69,$5C,$F7,$FC,$20,$A0,$DC,$E6,$A0,$7B,$A0,$E6,$A0,$E6,$A0,$E6,$A0,$E6,$A0,$D2,$A0,$A0
!byte $A0,$20,$D2,$A0,$E6,$AE,$A0,$A0,$E6,$A0,$A0,$EC,$E6,$E8,$A0,$AE,$E6,$E6,$E9,$E6,$E6,$E8,$A0,$A0,$E6,$E6,$DC,$A0,$E8,$E6,$A0,$A0,$D2,$A0,$A0,$E6,$A0,$A0,$D2,$A0
!byte $E8,$AE,$A0,$A0,$E6,$D2,$20,$D2,$E6,$D2,$D2,$D2,$E6,$D2,$D2,$D2,$E6,$E8,$D2,$E6,$E6,$E8,$AE,$D2,$E6,$A0,$D2,$D2,$D2,$E6,$D2,$D2,$20,$D2,$D2,$E6,$A0,$20,$AC,$A0
!byte $D2,$D2,$D2,$D2,$E6,$20,$DC,$20,$E6,$20,$20,$20,$DC,$20,$20,$20,$AE,$A0,$20,$E6,$E8,$E6,$E6,$20,$DC,$FB,$20,$20,$20,$E6,$20,$20,$20,$20,$20,$E6,$D2,$E6,$20,$D2
!byte $20,$20,$20,$20,$AE,$6C,$A0,$6C,$E6,$7B,$20,$6C,$A0,$7B,$20,$6C,$A0,$A0,$6C,$E6,$E6,$E6,$E6,$6C,$A0,$A0,$7B,$20,$6C,$A0,$7B,$20,$FB,$7B,$6C,$E6,$20,$DC,$E6,$20
!byte $7B,$20,$20,$6C,$A0,$A0,$A0,$E6,$E6,$E6,$A0,$A0,$AE,$A0,$A0,$A0,$AE,$A0,$A0,$A0,$E8,$E6,$E6,$E6,$E6,$E6,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$E6,$E6,$6C,$A0,$A0,$6C
!byte $E6,$AE,$A0,$A0,$E8,$E6,$E6,$E6,$A0,$E6,$E6,$E6,$E8,$E8,$A0,$65,$65,$27,$63,$63,$63,$63,$63,$63,$67,$E6,$E6,$AE,$A0,$E8,$E8,$E6,$E6,$E6,$E6,$AE,$A0,$E8,$E6,$E6
!byte $E8,$E6,$E6,$A0,$A0,$AE,$AE,$A0,$A0,$A0,$A0,$E8,$E6,$E6,$E6,$54,$05,$0E,$07,$0C,$09,$13,$08,$20,$67,$A0,$A0,$E6,$E6,$E6,$E6,$E6,$E8,$E8,$AE,$A0,$E6,$E6,$AE,$A0
!byte $A0,$A0,$A0,$E6,$E6,$AE,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$4C,$20,$20,$20,$20,$20,$20,$20,$20,$7A,$A0,$AE,$E8,$E6,$E6,$AE,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0
!byte $7C,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$20,$04,$05,$15,$14,$13,$03,$08,$20,$67,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$AE,$A0,$A0,$AE,$A0,$7C
!byte $E8,$A0,$A0,$A0,$A0,$A0,$63,$6A,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$20,$20,$20,$20,$20,$20,$20,$20,$20,$67,$A0,$A0,$A0,$A0,$A0,$A0,$9E,$A0,$AE,$AE,$AE,$E8,$AE,$A0,$7E
!byte $A0,$A0,$A0,$A0,$A0,$E8,$20,$6A,$A0,$A0,$A0,$A0,$C3,$A0,$A0,$65,$0D,$01,$07,$19,$01,$12,$15,$0C,$20,$A0,$A0,$A0,$A0,$A0,$69,$20,$5F,$AE,$AE,$E6,$A0,$A0,$7E,$20
!byte $7C,$A0,$AE,$A0,$20,$20,$20,$20,$20,$6A,$A0,$A0,$A0,$A0,$A0,$65,$20,$20,$20,$6F,$6F,$6F,$6F,$20,$7A,$A0,$AE,$E8,$A0,$E8,$20,$2B,$20,$E6,$E6,$E8,$E6,$E8,$A0,$20
!byte $27,$A0,$A0,$A0,$6F,$20,$20,$20,$64,$6A,$A0,$A0,$A0,$C6,$C6,$A0,$D0,$6A,$F4,$C3,$A0,$A0,$A0,$6A,$A0,$A0,$A0,$A0,$A0,$A0,$65,$20,$20,$63,$20,$5F,$E8,$7E,$7C,$20
!byte $20,$AE,$A0,$A0,$A0,$CA,$20,$20,$E5,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$6A,$A0,$A0,$A0,$A0,$F6,$6A,$A0,$F2,$F2,$F0,$F2,$F2,$20,$20,$20,$22,$22,$20,$AC,$20,$55,$49
!byte $20,$7C,$AE,$A0,$A0,$A0,$20,$6A,$A0,$AE,$A0,$A0,$AE,$A0,$A0,$A0,$F6,$6A,$E8,$E8,$E8,$AE,$7E,$20,$7E,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$7C,$20,$55,$73
!byte $20,$27,$E8,$AE,$7E,$7E,$20,$6A,$E8,$E8,$7E,$78,$EF,$7C,$A0,$AC,$F6,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
!byte $A0,$A0,$A0,$A0,$20,$20,$20,$20,$A0,$A0,$A0,$A0,$20,$20,$7C,$7C,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$A0,$A0
!byte $20,$20,$20,$20,$20,$20,$20,$A0,$A0,$A0,$20,$20,$20,$20,$20,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$A0,$A0,$A0,$A0,$A0,$A0
!byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$0C,$00,$00,$0E,$0E,$0E,$0E,$0E,$00,$0B,$0E,$0C,$0E,$0E,$0E,$0B,$0E,$0E,$0B,$0B,$00,$00,$00,$00,$00,$00,$00,$00,$00,$0F,$00
!byte $00,$00,$0C,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$0B,$00,$00,$00,$00,$00
!byte $00,$00,$00,$0B,$00,$0B,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$0B,$0D,$00,$00,$00,$00,$0A,$00,$00,$00,$00,$00,$00,$00,$00,$0B,$00,$00,$00,$00,$0B,$00,$00
!byte $00,$00,$00,$00,$00,$0D,$0B,$0D,$00,$0D,$0D,$0D,$00,$0D,$0D,$0D,$00,$0D,$0D,$0D,$00,$00,$0A,$0A,$0A,$00,$0A,$0A,$0A,$00,$0A,$0B,$00,$00,$0A,$00,$00,$00,$00,$00
!byte $0D,$0D,$0D,$0D,$0B,$0D,$0B,$0D,$0B,$0D,$09,$05,$0B,$0D,$09,$09,$0B,$09,$0D,$09,$00,$0B,$09,$0A,$09,$0B,$0A,$09,$02,$0B,$0A,$0B,$00,$0B,$02,$0B,$0A,$00,$00,$02
!byte $0D,$09,$09,$09,$0B,$0D,$05,$05,$0B,$0D,$00,$05,$0B,$0D,$05,$05,$0B,$00,$0D,$00,$06,$06,$00,$02,$00,$0B,$02,$00,$02,$0B,$0A,$0B,$0A,$0B,$02,$0B,$0A,$02,$0B,$02
!byte $0D,$00,$05,$05,$0B,$05,$09,$05,$0B,$05,$0B,$05,$0B,$09,$09,$05,$0B,$0B,$05,$0B,$0B,$0B,$0B,$02,$0B,$0B,$02,$02,$02,$0B,$02,$0B,$02,$0B,$02,$0B,$0A,$09,$02,$02
!byte $05,$0B,$09,$05,$0B,$05,$00,$05,$0B,$05,$05,$05,$0B,$05,$05,$05,$0B,$0B,$05,$0B,$0B,$0B,$0B,$02,$0B,$0B,$02,$02,$02,$0B,$02,$02,$09,$02,$02,$0B,$02,$00,$09,$02
!byte $05,$05,$05,$05,$0B,$09,$0B,$09,$0B,$09,$09,$09,$0B,$09,$09,$09,$0B,$0B,$09,$0B,$0B,$0B,$0B,$09,$0B,$0B,$09,$09,$09,$0B,$09,$09,$0B,$09,$09,$0B,$02,$0B,$00,$02
!byte $09,$09,$09,$09,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$09,$0B,$0B,$09
!byte $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B
!byte $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B
!byte $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$09,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B
!byte $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$07,$07,$07,$07,$07,$07,$07,$09,$09,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B
!byte $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$09,$09,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B
!byte $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$09,$09,$09,$09,$09,$09,$09,$09,$08,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B
!byte $0B,$0B,$0B,$0B,$0B,$0B,$0B,$08,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$09,$08,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B
!byte $0B,$0B,$0B,$0B,$0B,$0B,$0B,$09,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$09,$09,$09,$09,$09,$09,$09,$09,$09,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B
!byte $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$08,$0B,$0B,$0B,$0B,$0B,$0B,$09,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$09,$0B,$0B,$0B,$0B,$0B,$0C,$07,$0C,$0B,$0B,$0B,$0B,$0B,$0B,$06
!byte $00,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$08,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$09,$0B,$0B,$0B,$0B,$0B,$09,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0C,$0C,$0B,$0C,$0B,$0B,$0B,$0B,$06
!byte $06,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$08,$0B,$0B,$0B,$0B,$0B,$08,$0B,$0B,$0B,$0B,$0B,$0B,$0C,$0C,$0B,$04,$04,$0C,$0B,$0C,$0B,$0B
!byte $06,$0B,$0B,$0B,$0B,$0B,$0B,$09,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$08,$0B,$0B,$0B,$0B,$0B,$08,$0B,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0B,$0C,$0B,$0B
!byte $0B,$0B,$0B,$0B,$0B,$0B,$0B,$08,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$08,$0B,$0C,$0B,$0B,$0B,$08,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$03,$0C,$0C,$0C,$0C,$0C,$0C
!byte $00,$00,$00,$00,$0B,$0B,$0B,$0B,$00,$00,$00,$00,$0C,$0B,$0B,$0B,$0B,$0C,$0C,$0C,$0C,$0C,$0C,$08,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$00,$00
!byte $0B,$0B,$0B,$0B,$0B,$0B,$0B,$00,$00,$00,$0B,$0B,$0B,$0B,$0B,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$00,$00,$00,$00,$00,$00
