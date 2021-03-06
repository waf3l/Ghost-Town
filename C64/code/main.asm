; ==============================================================================
;
;  ▄████  ██░ ██  ▒█████    ██████ ▄▄▄█████▓   ▄▄▄█████▓ ▒█████   █     █░███▄    █
; ██▒ ▀█▒▓██░ ██▒▒██▒  ██▒▒██    ▒ ▓  ██▒ ▓▒   ▓  ██▒ ▓▒▒██▒  ██▒▓█░ █ ░█░██ ▀█   █
;▒██░▄▄▄░▒██▀▀██░▒██░  ██▒░ ▓██▄   ▒ ▓██░ ▒░   ▒ ▓██░ ▒░▒██░  ██▒▒█░ █ ░█▓██  ▀█ ██▒
;░▓█  ██▓░▓█ ░██ ▒██   ██░  ▒   ██▒░ ▓██▓ ░    ░ ▓██▓ ░ ▒██   ██░░█░ █ ░█▓██▒  ▐▌██▒
;░▒▓███▀▒░▓█▒░██▓░ ████▓▒░▒██████▒▒  ▒██▒ ░      ▒██▒ ░ ░ ████▓▒░░░██▒██▓▒██░   ▓██░
; ░▒   ▒  ▒ ░░▒░▒░ ▒░▒░▒░ ▒ ▒▓▒ ▒ ░  ▒ ░░        ▒ ░░   ░ ▒░▒░▒░ ░ ▓░▒ ▒ ░ ▒░   ▒ ▒
;  ░   ░  ▒ ░▒░ ░  ░ ▒ ▒░ ░ ░▒  ░ ░    ░           ░      ░ ▒ ▒░   ▒ ░ ░ ░ ░░   ░ ▒░
;░ ░   ░  ░  ░░ ░░ ░ ░ ▒  ░  ░  ░    ░           ░      ░ ░ ░ ▒    ░   ░    ░   ░ ░
;      ░  ░  ░  ░    ░ ░        ░                           ░ ░      ░            ░
;
;
; Ghost Town, Commodore 64 Version
; Disassembled by awsm & spider j of Mayday in 2019
;
; ==============================================================================

; ==============================================================================
; languages
; ENGLISH, GERMAN and HUNGARIAN are available
; the languages EN, DE and HU are all included in the build
; and can be chosen from the intro screen
; therefore there is no compile setting for the language like for the 16k version
; ==============================================================================



; ==============================================================================
; thse settings change the appearance of the game
; EXTENDED = 0 -> original version
; EXTENDED = 1 -> altered version
; ==============================================================================

EXTENDED                = 1       ; 0 = original version, 1 = tweaks and cosmetics

!if EXTENDED = 0{
    COLOR_FOR_INVISIBLE_ROW_AND_COLUMN = $02 ; red
    MULTICOLOR_1        = $0a           ; face pink
    MULTICOLOR_2        = $09
    BORDER_COLOR_VALUE  = $02
    TITLE_KEY_MATRIX    = $fd           ; Original key to press on title screen: 1
    TITLE_KEY           = $01

}

!if EXTENDED = 1{
    COLOR_FOR_INVISIBLE_ROW_AND_COLUMN = $02 ; red
    MULTICOLOR_1        = $0a           ; face pink
    MULTICOLOR_2        = $09
    BORDER_COLOR_VALUE  = $02
    TITLE_KEY_MATRIX    = $fd           ; Original key to press on title screen: 1
    TITLE_KEY           = $01
}


; ==============================================================================
; CHEATS
;
;
; ==============================================================================

START_ROOM          = 0             ; default 0 
PLAYER_START_POS_X  = 3             ; default 3
PLAYER_START_POS_Y  = 6             ; default 6
SILENT_MODE         = 0

; ==============================================================================
; ITEMS
; not used in the code, but useful for testing, 
; e.g. "> ._sword df" to pickup the sword in VICE monitor
; ==============================================================================

_boots              = items + $84
_ladder             = items + $4d
_gloves             = items + $8
_key                = items + $10
_wirecutter         = items + $19
_light              = items + $74
_hammer             = items + $bb
_shovel             = items + $96
_poweroutlet        = items + $ac
_lightbulb          = items + $c8
_sword              = items + $1a7

; ==============================================================================
; ZEROPAGE

zp02                = $02
zp03                = $03               ; high byte of screen ram
zp04                = $04               ; low byte of screen ram
zp05                = $05               ; seems to always store the COLRAM information
zp08                = $08
zp09                = $09
zp0A                = $0A
zp10                = $10
zp11                = $11
zpA7                = $A7
zpA8                = $A8
zpA9                = $A9


; ==============================================================================

TAPE_BUFFER         = $033c             ; $0333
SCREENRAM           = $0400             ; $0C00             ; PLUS/4 default SCREEN
COLRAM              = $d800             ; $0800             ; PLUS/4 COLOR RAM
PRINT_KERNAL        = $ffd2             ; $c56b
BASIC_DA89          = $e8ea             ; $da89             ; scroll screen up by 1 line
FF07                = $d016             ; $FF07             ; FF07 scroll & multicolor
KEYBOARD_LATCH      = $FF08
INTERRUPT           = $FF09
FF0A                = $FF0A
VOICE1_FREQ_LOW     = $FF0E             ; Low byte of frequency for voice 1
VOICE2_FREQ_LOW     = $FF0F
VOICE2              = $FF10

VOICE1              = $FF12             ; Bit 0-1 : Voice #1 frequency, bits 8 & 9;  Bit 2    : TED data fetch ROM/RAM select; Bits 0-5 : Bit map base address
CHAR_BASE_ADDRESS   = $d018             ; $FF13
BG_COLOR            = $D021
COLOR_1             = $d022             ;$FF16
COLOR_2             = $d023             ; $FF17
COLOR_3             = $d024             ;$FF18
BORDER_COLOR        = $D020
FF1D                = $D012             ; $FF1D             ; FF1D raster line
SID_ADDRESS         = $5000
COLORS              = $6000
PETSCII_CHARS       = $8000
PETSCII_COLORS      = $8000 + 1000
BITMAP              = $c000
SCREEN              = $e000






















; ==============================================================================

                    !cpu 6510
                    *= $1000

; ==============================================================================
;
; display the hint messages
; ==============================================================================

display_hint_message_plus_clear:
                   
                    jsr clear               ;     jsr PRINT_KERNAL   
                         

display_hint_message:
                   
                    
                    lda #>hint_messages
                    sta zpA8
                    lda #<hint_messages
m1009:              cpy #$00
                    beq ++              
-                   clc
                    adc #$28
                    bcc +               
                    inc zpA8
+                   dey
                    bne -               
++                  sta zpA7
                    jsr set_charset_and_screen 
                    
                    ldy #$27
-                   lda (zpA7),y
                    sta SCREENRAM+$1B8,y 
                    lda #$05
                    sta COLRAM+$1B8,y 
                    dey
                    bne -  
                       
                    rts


; ==============================================================================
;
;
; ==============================================================================

prep_and_display_hint:
                    
                    jsr clear
                    jsr switch_charset           
                    cpy #$03                                ; is the display hint the one for the code number?
                    beq room_16_code_number_prep            ; yes -> +      ;bne m10B1 ; bne $10b1
                    jmp display_hint                        ; no, display the hint


room_16_code_number_prep:
                    
                    jsr clear
                    jsr display_hint_message                ; yes we are in room 3
                    jsr BASIC_DA89                          ; ?!? scroll screen down ?!?
                    jsr BASIC_DA89                          ; ?!? scroll screen down ?!?
                   
                    ldy #$01                                ; y = 1
                    jsr display_hint_message              
                    ldx #$00                                ; x = 0
                    ldy #$00                                ; y = 0
                    beq room_16_enter_code                  ; room 16 code? how?

room_16_cursor_blinking: 

                    lda SCREENRAM+$1B9,x                    ; load something from screen
                    clc                                     
                    adc #$80                                ; add $80 = 128 = inverted char
                    sta SCREENRAM+$1B9,x                    ; store in the same location
                    lda SCREENRAM+$188,y                    ; and the same for another position
                    clc
                    adc #$80
                    sta SCREENRAM+$188,y 
                    rts

; ==============================================================================
; ROOM 16
; ENTER CODE
; ==============================================================================

room_16_enter_code:

                    jsr room_16_cursor_blinking
                    sty zp02
                    stx zp04
                    jsr room_16_code_delay           
                    jsr room_16_cursor_blinking           
                    jsr room_16_code_delay

                    lda $dc00
                                                                ; Bit #0: 0 = Port 2 joystick up pressed.
                                                                ; Bit #1: 0 = Port 2 joystick down pressed.
                                                                ; Bit #2: 0 = Port 2 joystick left pressed.
                                                                ; Bit #3: 0 = Port 2 joystick right pressed.
                                                                ; Bit #4: 0 = Port 2 joystick fire pressed.
                    
                    lsr                                         ; we don't check for up       
                    lsr                                         ; we don't check for down
                    
                    lsr                                         ; now we have carry = 0 if LEFT PRESSED
                    bcs +                                       ; left not pressed ->
                    cpx #$00                                    ; x = 0?
                    beq +                                       ; yes ->
                    dex                                         ; no, x = x - 1 = move cursor left

+                   lsr                                         ; now we have carry = 0 if RIGHT PRESSED
                    bcs +                                       ; right not pressed ->
                    cpx #$25                                    ; right was pressed, but are we at the rightmost position already?
                    beq +                                       ; yes we are ->
                    inx                                         ; no, we can move one more, so x = x + 1

+                   lsr                                         ; now we have carry = 0 if FIRE PRESSED
                    bcs room_16_enter_code                      ; fire wasn't pressed, so start over
                    
                    lda SCREENRAM+$1B9,x                        ; fire WAS pressed, so get the current character
                    cmp #$bc                                    ; is it the "<" char for back?
                    bne ++                                      ; no ->
                    cpy #$00                                    ; yes, code submitted
                    beq +
                    dey
+                   jmp room_16_enter_code
++                  sta SCREENRAM+$188,y
                    iny
                    cpy #$05
                    bne room_16_enter_code
                    jmp check_code_number
; ==============================================================================
;
; DELAYS CURSOR MOVEMENT AND BLINKING
; ==============================================================================

room_16_code_delay:
                    ldy #$20                            ; wait a bit
                    jsr wait                        
                    ldy zp02                            ; and load x and y 
                    ldx zp04                            ; with shit from zp
                    rts

; ==============================================================================
; ROOM 16
; CHECK THE CODE NUMBER
; ==============================================================================

check_code_number:
                    ldx #$05                            ; x = 5
-                   lda SCREENRAM+$187,x                ; get one number from code
                    cmp code_number-1,x                 ; is it correct?
                    bne +                               ; no -> +
                    dex                                 ; yes, check next number
                    bne -                               
                    jmp ++                              ; all correct -> ++
+                   ldy #$05                            ; text for wrong code number
                    jsr display_hint_message            ; wrong code -> death
                    jmp m3EF9          

code_number:        !scr "06138"                        ; !byte $30, $36, $31, $33, $38

++                  jsr set_game_basics                 ; code correct, continue
                    jsr set_player_xy          
                    jsr draw_border          
                    jmp main_loop          

; ==============================================================================
;
; hint system (question marks)
; ==============================================================================


display_hint:
                    cpy #$00
                    bne m11A2           
                    jsr display_hint_message_plus_clear
                    ldx current_room + 1
                    cpx #$01
                    bne +               
                    lda #$28
+                   cpx #$05
                    bne +               
                    lda #$29
+                   cpx #$0a
                    bne +               
                    lda #$47                   
+                   cpx #$0c
                    bne +
                    lda #$49
+                   cpx #$0d
                    bne +
                    lda #$45
+                   cpx #$0f
                    bne +               
                    lda #$45
                   
                    sta COLRAM + $26f       
                    lda #$0f
                    sta SCREENRAM + $26f       
+                   sta SCREENRAM + $21f       
                    lda #$48
                    sta COLRAM + $21f       
-                   lda $dc00                         ;lda #$fd
                                                      ;sta KEYBOARD_LATCH
                                                      ; lda KEYBOARD_LATCH
                    and #$10                          ; and #$80
                    bne -               
                    jsr set_game_basics
                    jsr m3A2D          
                    jmp main_loop         
m11A2:              cpy #$02
                    bne +             
m11A6:              jsr display_hint_message_plus_clear
                    jmp -             
+                   cpy #$04
                    bne +              
                    lda m3952 + 1    
                    clc
                    adc #$40                                        ; this is the helping letter
                    sta helping_letter         
                    bne m11A6          
+                   dey
                    dey
                    dey
                    dey
                    dey
                    lda #>item_pickup_message
                    sta zpA8
                    lda #<item_pickup_message
                    jsr m1009
                    jmp -

; ==============================================================================

switch_charset:
                    jsr set_charset_and_screen           
                    jmp clear       ; jmp PRINT_KERNAL           



























; ==============================================================================
;
; JUMP TO ROOM LOGIC
; This code is new. Previously, code execution jumped from room to room
; and in each room did the comparison with the room number.
; This is essentially the same, but bundled in one place.
; not calles in between room changes, only e.g. for question mark
; ==============================================================================

check_room:
                    ldy current_room + 1        ; load in the current room number
                    cpy #0
                    bne +
                    jmp room_00
+                   cpy #1
                    bne +
                    jmp room_01
+                   cpy #2
                    bne +
                    jmp room_02
+                   cpy #3
                    bne +
                    jmp room_03
+                   cpy #4
                    bne +
                    jmp room_04
+                   cpy #5
                    bne +
                    jmp room_05
+                   cpy #6
                    bne +
                    jmp room_06
+                   cpy #7
                    bne +
                    jmp room_07
+                   cpy #8
                    bne +
                    jmp room_08
+                   cpy #9
                    bne +
                    jmp room_09
+                   cpy #10
                    bne +
                    jmp room_10
+                   cpy #11
                    bne +
                    jmp room_11 
+                   cpy #12
                    bne +
                    jmp room_12
+                   cpy #13
                    bne +
                    jmp room_13
+                   cpy #14
                    bne +
                    jmp room_14
+                   cpy #15
                    bne +
                    jmp room_15
+                   cpy #16
                    bne +
                    jmp room_16
+                   cpy #17
                    bne +
                    jmp room_17
+                   jmp room_18



; ==============================================================================

check_death:
                    jsr update_items_display
                    jmp main_loop           

; ==============================================================================

m11E0:              
                    ldx #$00
-                   lda TAPE_BUFFER + $9,x              
                    cmp #$1e                            ; question mark
                    bcc check_next_char_under_player           
                    cmp #$df
                    beq check_next_char_under_player
                    jmp check_room              

; ==============================================================================

check_next_char_under_player:
                    inx
                    cpx #$09
                    bne -                              ; not done checking          
-                   jmp main_loop           


; ==============================================================================
;
;                                                             ###        ###
;          #####      ####      ####     #    #              #   #      #   #
;          #    #    #    #    #    #    ##  ##             #     #    #     #
;          #    #    #    #    #    #    # ## #             #     #    #     #
;          #####     #    #    #    #    #    #             #     #    #     #
;          #   #     #    #    #    #    #    #              #   #      #   #
;          #    #     ####      ####     #    #               ###        ###
;
; ==============================================================================


room_00:

                    cmp #$a9                                        ; has the player hit the gloves?
                    bne check_next_char_under_player                ; no
                    lda #$df                                        ; yes, load in char for "empty"
                    cmp items + $4d                                 ; position for 1st char of ladder ($b0) -> ladder already taken?
                    bne -                                           ; no
                    jsr pickup_gloves                               ; yes
                    bne check_death


pickup_gloves:
                    lda #$6b                                        ; load character for empty bush
                    sta items + $8                                  ; store 6b = gloves in inventory
                    lda #$3d                                        ; set the foreground color
                    sta items + $6                                  ; and store the color in the items table
                    rts






; ==============================================================================
;
;                                                             ###        #
;          #####      ####      ####     #    #              #   #      ##
;          #    #    #    #    #    #    ##  ##             #     #    # #
;          #    #    #    #    #    #    # ## #             #     #      #
;          #####     #    #    #    #    #    #             #     #      #
;          #   #     #    #    #    #    #    #              #   #       #
;          #    #     ####      ####     #    #               ###      #####
;
; ==============================================================================

room_01:

                    cmp #$e0                                    ; empty character in charset -> invisible key
                    beq +                                       ; yes, key is there -> +
                    cmp #$e1
                    bne ++
+                   lda #$aa                                    ; display the key, $AA = 1st part of key
                    sta items + $10                             ; store key in items list
                    jsr update_items_display                    ; update all items in the items list (we just made the key visible)
                    ldy #$f0                                    ; set waiting time
                    jsr wait                                    ; wait
                    lda #$df                                    ; set key to empty space
                    sta items + $10                             ; update items list
                    bne check_death
++                  cmp #$27                                    ; question mark (I don't know why 27)
                    bcs check_death_bush
                    ldy #$00
                    jmp prep_and_display_hint

check_death_bush:
                    cmp #$ad                                    ; wirecutters
                    bne check_next_char_under_player
                    lda items + $8                              ; inventory place for the gloves! 6b = gloves
                    cmp #$6b
                    beq +
                    ldy #$0f
                    jmp death                                   ; 0f You were wounded by the bush!

+                   lda #$f9                                    ; wirecutter picked up
                    sta items + $19
                    jmp check_death






; ==============================================================================
;
;                                                             ###       #####
;          #####      ####      ####     #    #              #   #     #     #
;          #    #    #    #    #    #    ##  ##             #     #          #
;          #    #    #    #    #    #    # ## #             #     #     #####
;          #####     #    #    #    #    #    #             #     #    #
;          #   #     #    #    #    #    #    #              #   #     #
;          #    #     ####      ####     #    #               ###      #######
;
; ==============================================================================

room_02:

                    cmp #$f5                                    ; did the player hit the fence? f5 = fence character
                    bne check_lock                              ; no, check for the lock
                    lda items + $19                             ; fence was hit, so check if wirecuter was picked up
                    cmp #$f9                                    ; where the wirecutters (f9) picked up?
                    beq remove_fence                            ; yes
                    ldy #$10                                    ; no, load the correct death message
                    jmp death                                   ; 10 You are trapped in wire-nettings!

remove_fence:
                    lda #$df                                    ; empty char
                    sta delete_fence + 1                        ; m3900 must be the draw routine to clear out stuff?
m1264:              jmp check_death


check_lock:
                    cmp #$a6                                    ; lock
                    bne +
                    lda items + $10
                    cmp #$df
                    bne m1264
                    lda #$df
                    sta items + $38
                    bne m1264
+                   cmp #$b1                                    ; ladder
                    bne +
                    lda #$df
                    sta items + $4d
                    sta items + $58
                    bne m1264
+                   cmp #$b9                                    ; bottle
                    beq +
                    jmp check_next_char_under_player
+                   lda items + $bb
                    cmp #$df                                    ; df = empty spot where the hammer was. = hammer taken
                    beq take_key_out_of_bottle                                   
                    ldy #$03
                    jmp death                                   ; 03 You drank from the poisend bottle

take_key_out_of_bottle:
                    lda #$01
                    sta key_in_bottle_storage
                    ldy #$05
                    jmp prep_and_display_hint

; ==============================================================================
; this is 1 if the key from the bottle was taken and 0 if not

key_in_bottle_storage:              !byte $00









; ==============================================================================
;
;                                                             ###       #####
;          #####      ####      ####     #    #              #   #     #     #
;          #    #    #    #    #    #    ##  ##             #     #          #
;          #    #    #    #    #    #    # ## #             #     #     #####
;          #####     #    #    #    #    #    #             #     #          #
;          #   #     #    #    #    #    #    #              #   #     #     #
;          #    #     ####      ####     #    #               ###       #####
;
; ==============================================================================

room_03:

                    cmp #$27                                    ; question mark (I don't know why 27)
                    bcc +
                    jmp main_loop
+                   ldy #$04
                    jmp prep_and_display_hint






; ==============================================================================
;
;                                                             ###      #
;          #####      ####      ####     #    #              #   #     #    #
;          #    #    #    #    #    #    ##  ##             #     #    #    #
;          #    #    #    #    #    #    # ## #             #     #    #    #
;          #####     #    #    #    #    #    #             #     #    #######
;          #   #     #    #    #    #    #    #              #   #          #
;          #    #     ####      ####     #    #               ###           #
;
; ==============================================================================

room_04:

                    cmp #$3b                                    ; you bumped into a zombie coffin?
                    beq +                                       ; yep
                    cmp #$42                                    ; HEY YOU! Did you bump into a zombie coffin?
                    bne ++                                      ; no, really, I didn't ( I swear! )-> ++
+                   ldy #$0d                                    ; thinking about it, there was a person inside that kinda...
                    jmp death                                   ; 0d You found a thirsty zombie....

++
                    cmp #$f7                                    ; Welcome those who didn't get eaten by a zombie.
                    beq +                                       ; seems you picked a coffin that contained something different...
                    cmp #$f8
                    beq +
                    jmp check_next_char_under_player            ; or you just didn't bump into anything yet (also well done in a way)
+                   lda #$00                                    ; 
                    sta m394A + 1                               ; some kind of prep for the door to be unlocked 
                    ldy #$06                                    ; display
                    jmp prep_and_display_hint






; ==============================================================================
;
;                                                             ###      #######
;          #####      ####      ####     #    #              #   #     #
;          #    #    #    #    #    #    ##  ##             #     #    #
;          #    #    #    #    #    #    # ## #             #     #    ######
;          #####     #    #    #    #    #    #             #     #          #
;          #   #     #    #    #    #    #    #              #   #     #     #
;          #    #     ####      ####     #    #               ###       #####
;
; ==============================================================================

room_05:

                    cmp #$27                                    ; question mark (I don't know why 27)
                    bcs +                                       ; no
                    ldy #$00                                    ; a = 0
                    jmp prep_and_display_hint

+                   cmp #$fd                                    ; stone with breathing tube hit?
                    beq +                                       ; yes -> +
                    jmp check_next_char_under_player            ; no

+                   lda #$00                                    ; a = 0                  
                    ldy items + $96                             ; do you have the shovel? 
                    cpy #$df
                    bne +                                       ; no I don't
                    sta breathing_tube_mod + 1                  ; yes, take the breathing tube
                    ldy #$07                                    ; and display the message
                    jmp prep_and_display_hint
+                   jmp main_loop

                    ;ldy #$07                                   ; same is happening above and I don't see this being called
                    ;jmp prep_and_display_hint






; ==============================================================================
;
;                                                             ###       #####
;          #####      ####      ####     #    #              #   #     #     #
;          #    #    #    #    #    #    ##  ##             #     #    #
;          #    #    #    #    #    #    # ## #             #     #    ######
;          #####     #    #    #    #    #    #             #     #    #     #
;          #   #     #    #    #    #    #    #              #   #     #     #
;          #    #     ####      ####     #    #               ###       #####
;
; ==============================================================================

room_06:

                    cmp #$f6                                    ; is it a trapped door?
                    beq +                                       ; OMG Yes the room is full of...
                    jmp check_next_char_under_player            ; please move on. nothing happened.
+                   ldy #$00
                    jmp death                                   ; 00 You fell into a snake pit






; ==============================================================================
;
;                                                             ###      #######
;          #####      ####      ####     #    #              #   #     #    #
;          #    #    #    #    #    #    ##  ##             #     #        #
;          #    #    #    #    #    #    # ## #             #     #       #
;          #####     #    #    #    #    #    #             #     #      #
;          #   #     #    #    #    #    #    #              #   #       #
;          #    #     ####      ####     #    #               ###        #
;
; ==============================================================================

room_07:
        
                    cmp #$e3                                    ; $e3 is the char for the invisible, I mean SACRED, column
                    bne +
                    ldy #$01                                    ; 01 You'd better watched out for the sacred column
                    jmp death                                   ; bne m1303 <- seems unneccessary

+                   cmp #$5f                                    ; seems to be the invisible char for the light
                    beq +                                       ; and it was hit -> +
                    jmp check_next_char_under_player            ; if not, continue checking

+                   lda #$bc                                    ; make light visible
                    sta items + $74                             ; but I dont understand how the whole light is shown
                    lda #$5f                                    ; color?
                    sta items + $72                             ; 
                    jsr update_items_display                    ; and redraw items
                    ldy #$ff
                    jsr wait                                    ; wait for some time so the player can actually see the light
                    jsr wait
                    jsr wait
                    jsr wait
                    lda #$df
                    sta items + $74                             ; and pick up the light/ remove it from the items list
                    lda #$00
                    sta items + $72                             ; also paint the char black
                    jmp check_death






; ==============================================================================
;
;                                                             ###       #####
;          #####      ####      ####     #    #              #   #     #     #
;          #    #    #    #    #    #    ##  ##             #     #    #     #
;          #    #    #    #    #    #    # ## #             #     #     #####
;          #####     #    #    #    #    #    #             #     #    #     #
;          #   #     #    #    #    #    #    #              #   #     #     #
;          #    #     ####      ####     #    #               ###       #####
;
; ==============================================================================

room_08:

                    ldy #$00                                    ; y = 0
                    sty zpA7                                    ; zpA7 = 0
                    cmp #$4b                                    ; water
                    bne check_item_water
                    ldy breathing_tube_mod + 1
                    bne +
                    jsr get_player_pos
                    lda #$18                                    ; move player on the other side of the river
--                  sta player_pos_x + 1
                    lda #$0c
                    sta player_pos_y + 1
-                   jmp main_loop


check_item_water:
                    cmp #$56                                    ; so you want to swim right?
                    bne check_item_shovel                       ; nah, not this time -> check_item_shovel
                    ldy breathing_tube_mod + 1                  ; well let's hope you got your breathing tube equipped     
+                   bne +
                    jsr get_player_pos                          ; tube equipped and ready to submerge
                    lda #$0c
                    bne --                                      ; see you on the other side!

+                   ldy #$02                                    ; breathing what?
                    jmp death                                   ; 02 You drowned in the deep river


check_item_shovel:
                    cmp #$c1                                    ; wanna have that shovel?
                    beq +                                       ; yup
                    cmp #$c3                                    ; I'n not asking thrice! (shovel 2nd char)
                    bne ++                                      ; nah still not interested -> ++
+                   lda #$df                                    ; alright cool,
                    sta items + $96                             ; shovel is yours now
--                  jmp check_death


++                  cmp #$ca                                    ; shoe box? (was #$cb before, but $ca seems a better char to compare to)
                    beq +                                       ; yup
                    jmp check_next_char_under_player
+                   lda items + $bb                             ; so did you get the hammer to crush it to pieces?
                    cmp #$df                                    ; (hammer picked up from items list and replaced with empty)
                    bne -                                       ; what hammer?
                    lda #$df
                    sta items + $84                             ; these fine boots are yours now, sir
                    bne --






; ==============================================================================
;
;                                                             ###       #####
;          #####      ####      ####     #    #              #   #     #     #
;          #    #    #    #    #    #    ##  ##             #     #    #     #
;          #    #    #    #    #    #    # ## #             #     #     ######
;          #####     #    #    #    #    #    #             #     #          #
;          #   #     #    #    #    #    #    #              #   #     #     #
;          #    #     ####      ####     #    #               ###       #####
;
; ==============================================================================

room_09:            

                    cmp #$27                                    ; question mark (I don't know why 27)
                    bcc +                                       ; yes -> +
                    jmp check_next_char_under_player            ; continue checking
+                   ldy #$02                                    ; display hint
                    jmp prep_and_display_hint






; ==============================================================================
;
;                                                             #        ###
;          #####      ####      ####     #    #              ##       #   #
;          #    #    #    #    #    #    ##  ##             # #      #     #
;          #    #    #    #    #    #    # ## #               #      #     #
;          #####     #    #    #    #    #    #               #      #     #
;          #   #     #    #    #    #    #    #               #       #   #
;          #    #     ####      ####     #    #             #####      ###
;
; ==============================================================================

room_10:

                    cmp #$27                                    ; question mark (I don't know why 27)
                    bcs +
                    ldy #$00                                    ; display hint
                    jmp prep_and_display_hint

+                   cmp #$cc                                    ; hit the power outlet?
                    beq +                                       ; yes -> +
                    cmp #$cf                                    ; hit the power outlet?
                    beq +                                       ; yes -> +
                    jmp check_next_char_under_player            ; no, continue
+                   lda #$df                                    
                    cmp items + $74                             ; light picked up?
                    bne +                                       ; no -> death
                    cmp items + $c8                             ; yes, lightbulb picked up?
                    bne +                                       ; no -> death
                    sta items + $ac                             ; yes, pick up power outlet
                    lda #$59                                    ; and make the foot traps visible
                    sta items + $12c                            ; color position for foot traps
                    jmp check_death

+                   ldy #$06
                    jmp death                                   ; 06 240 Volts! You got an electrical shock!






; ==============================================================================
;
;                                                             #        #
;          #####      ####      ####     #    #              ##       ##
;          #    #    #    #    #    #    ##  ##             # #      # #
;          #    #    #    #    #    #    # ## #               #        #
;          #####     #    #    #    #    #    #               #        #
;          #   #     #    #    #    #    #    #               #        #
;          #    #     ####      ####     #    #             #####    #####
;
; ==============================================================================

room_11:

                    cmp #$d1                                    ; picking up the hammer?
                    beq +                                       ; jep
                    jmp check_next_char_under_player            ; no, continue
+                   lda #$df                                    ; player takes the hammer
                    sta items + $bb                             ; hammer
                    jmp check_death






; ==============================================================================
;
;                                                             #       #####
;          #####      ####      ####     #    #              ##      #     #
;          #    #    #    #    #    #    ##  ##             # #            #
;          #    #    #    #    #    #    # ## #               #       #####
;          #####     #    #    #    #    #    #               #      #
;          #   #     #    #    #    #    #    #               #      #
;          #    #     ####      ####     #    #             #####    #######
;
; ==============================================================================

room_12:

                    cmp #$27                                    ; question mark (I don't know why 27)
                    bcs +                                       ; no
                    ldy #$00                                    
                    jmp prep_and_display_hint                   ; display hint

+                   cmp #$d2                                    ; light bulb hit?
                    beq +                                       ; yes
                    cmp #$d5                                    ; light bulb hit?
                    beq +                                       ; yes
                    jmp check_next_char_under_player            ; no, continue
+                   lda #$df                                    ; pick up light bulb
                    sta items + $c8
                    jmp check_death






; ==============================================================================
;
;                                                             #       #####
;          #####      ####      ####     #    #              ##      #     #
;          #    #    #    #    #    #    ##  ##             # #            #
;          #    #    #    #    #    #    # ## #               #       #####
;          #####     #    #    #    #    #    #               #            #
;          #   #     #    #    #    #    #    #               #      #     #
;          #    #     ####      ####     #    #             #####     #####
;
; ==============================================================================

room_13:           

                    cmp #$27                                    ; question mark (I don't know why 27)
                    bcs +
                    ldy #$00                                    ; message 0 to display
                    jmp prep_and_display_hint                   ; display hint

+                   cmp #$d6                                    ; argh!!! A nail!!! Who put these here!!!
                    beq +                                       ; OUCH!! -> +
                    jmp check_next_char_under_player            ; not stepped into a nail... yet.
+                   lda items + $84                             ; are the boots taken?
                    cmp #$df                                
                    beq +                                       ; yeah I'm cool these boots are made for nailin'. 
                    ldy #$07                                    ; death by a thousand nails.
                    jmp death                                   ; 07 You stepped on a nail!

+
                    lda #$e2                                    ; this is also a nail. 
                    sta items + $d5                             ; it replaces the deadly nails with boot-compatible ones
                    jmp check_death






; ==============================================================================
;
;                                                             #      #
;          #####      ####      ####     #    #              ##      #    #
;          #    #    #    #    #    #    ##  ##             # #      #    #
;          #    #    #    #    #    #    # ## #               #      #    #
;          #####     #    #    #    #    #    #               #      #######
;          #   #     #    #    #    #    #    #               #           #
;          #    #     ####      ####     #    #             #####         #
;
; ==============================================================================

room_14:

                    cmp #$d7                                    ; foot trap char
                    beq +                                       ; stepped into it?
                    jmp check_next_char_under_player            ; not... yet...
+                   ldy #$08                                    ; go die
                    jmp death                                   ; 08 A foot trap stopped you!






; ==============================================================================
;
;                                                             #      #######
;          #####      ####      ####     #    #              ##      #
;          #    #    #    #    #    #    ##  ##             # #      #
;          #    #    #    #    #    #    # ## #               #      ######
;          #####     #    #    #    #    #    #               #            #
;          #   #     #    #    #    #    #    #               #      #     #
;          #    #     ####      ####     #    #             #####     #####
;
; ==============================================================================

room_15:

                    cmp #$27                                    ; question mark (I don't know why 27)
                    bcs +
                    ldy #$00                                    ; display hint
                    jmp prep_and_display_hint

+                   jmp check_next_char_under_player            ; jmp m13B0 -> target just jumps again, so replacing with target jmp address






; ==============================================================================
;
;                                                             #       #####
;          #####      ####      ####     #    #              ##      #     #
;          #    #    #    #    #    #    ##  ##             # #      #
;          #    #    #    #    #    #    # ## #               #      ######
;          #####     #    #    #    #    #    #               #      #     #
;          #   #     #    #    #    #    #    #               #      #     #
;          #    #     ####      ####     #    #             #####     #####
;
; ==============================================================================

room_16:

                    cmp #$f4                                    ; did you hit the wall in the left cell?
                    bne +                                       ; I did not! -> +
                    ldy #$0a                                    ; yeah....
                    jmp death                                   ; 0a You were locked in and starved!

+                   cmp #$d9                                    ; so you must been hitting the other wall in the other cell then, right?
                    beq +                                       ; not that I know of...
                    cmp #$db                                    ; are you sure? take a look at this slightly different wall
                    bne ++                                      ; it doesn't look familiar... -> ++

+                   ldy #$09                                    ; 09 This room is doomed by the wizard Manilo!
                    jmp death

++                  cmp #$b9                                    ; then you've hit the bottle! that must be it! (was $b8 which was imnpossible to hit)
                    beq +                                       ; yes! -> +
                    cmp #$bb                                    ; here's another part of that bottle for reference
                    beq +                                       ; yes! -> +
                    jmp check_next_char_under_player            ; no, continue
+                   ldy #$03                                    ; display code enter screen
                    jmp prep_and_display_hint






; ==============================================================================
;
;                                                             #      #######
;          #####      ####      ####     #    #              ##      #    #
;          #    #    #    #    #    #    ##  ##             # #          #
;          #    #    #    #    #    #    # ## #               #         #
;          #####     #    #    #    #    #    #               #        #
;          #   #     #    #    #    #    #    #               #        #
;          #    #     ####      ####     #    #             #####      #
;
; ==============================================================================

room_17:

                    cmp #$dd                                    ; The AWESOMEZ MAGICAL SWORD!! YOU FOUND IT!! IT.... KILLS PEOPLE!!
                    beq +                                       ; yup
                    jmp check_next_char_under_player            ; nah not yet.
+                   lda #$df                                    ; pick up sword
                    sta items + $1a7                            ; store in items list
                    jmp check_death






; ==============================================================================
;
;                                                             #       #####
;          #####      ####      ####     #    #              ##      #     #
;          #    #    #    #    #    #    ##  ##             # #      #     #
;          #    #    #    #    #    #    # ## #               #       #####
;          #####     #    #    #    #    #    #               #      #     #
;          #   #     #    #    #    #    #    #               #      #     #
;          #    #     ####      ####     #    #             #####     #####
;
; ==============================================================================

room_18:
                    cmp #$81                                    ; did you hit any char $81 or higher? (chest and a lot of stuff not in the room)
                    bcs +                   
                    jmp check_death

+                   lda key_in_bottle_storage                   ; well my friend, you sure brought that key from the fucking 3rd room, right?
                    bne +                                       ; yes I actually did (flexes arms)
                    jmp main_loop                               ; nope
+                   jsr set_charset_and_screen                  ; You did it then! Let's roll the credits and get outta here
                    jmp print_endscreen                         ; (drops mic)









































; ==============================================================================
; 
; EVERYTHING ANIMATION RELATED STARTS HERE
; ANIMATIONS FOR
; LASER, BORIS, BELEGRO, STONE, MONSTER
; ==============================================================================

; TODO
; this gets called all the time, no checks 
; needs to be optimized


animation_entrypoint:
                    
                    ; code below is used to check if the foot traps should be visible
                    ; it checked for this every single fucking frame
                    ; moved the foot traps coloring where it belongs (when picking up power outlet)
                    ;lda items + $ac                         ; $cc (power outlet)
                    ;cmp #$df                                ; taken?
                    ;bne +                                   ; no -> +
                    ;lda #$59                                ; yes, $59 (part of water, wtf), likely color
                    ;sta items + $12c                        ; originally $0

+                   ldy current_room + 1                    ; load room number

                    cpy #$11                                ; is it room #17? (Belegro)
                    bne room_14_prep                         ; no -> m162A
                    
                    
                    lda m14CC + 1                           ; yes, get value from m14CD
                    bne m15FC                               ; 0? -> m15FC
                    lda player_pos_y + 1                    ; not 0, get player pos Y
                    cmp #$06                                ; is it 6?
                    bne m15FC                               ; no -> m15FC
                    lda player_pos_x + 1                    ; yes, get player pos X
                    cmp #$18                                ; is player x position $18?
                    bne m15FC                               ; no -> m15FC
                    lda #$00                                ; yes, load 0
                    sta m15FC + 1                           ; store 0 in m15FC+1
m15FC:              lda #$01                                ; load A (0 if player xy = $6/$18)
                    bne +                                   ; is it 0? -> +
                    ldy #$06                                ; y = $6
m1602:              ldx #$1e                                ; x = $1e
                    lda #$00                                ; a = $0
                    sta zpA7                                ; zpA7 = 0
                    jsr draw_player                         ; TODO
                    ldx m1602 + 1                           ; get x again (was destroyed by previous JSR)
                    cpx #$03                                ; is X = $3?
                    beq ++                                  ; yes -> ++
                    dex                                     ; x = x -1
++                  stx m1602 + 1                           ; store x in m1602+1
+                   lda #$78                                ; a = $78
                    sta zpA8                                ; zpA8 = $78
                    lda #$49                                ; a = $49
                    sta zp0A                                ; zp0A = $49
                    ldy #$06                                ; y = $06
                    lda #$01                                ; a = $01
                    sta zpA7                                ; zpA7 = $01
                    ldx m1602 + 1                           ; get stored x value (should still be the same?)
                    jsr draw_player                         ; TODO


room_14_prep:              
                    ldy current_room + 1                    ; load room number
                    cpy #14                                 ; is it #14?
                    bne room_15_prep                        ; no -> m148A
                    ldy #$20                                ; yes, wait a bit, slowing down the character when moving through foot traps
                    jsr wait                                ; was jmp wait before

; ==============================================================================
; ROOM 15 ANIMATION
; MOVEMENT OF THE MONSTER
; ==============================================================================

room_15_prep:              
                    cpy #15                                 ; room 15?
                    bne room_17_prep                        ; no -> m14C8
                    lda #$00                                ; 
                    sta zpA7
                    ldy #$0c                                ; x/y pos of the monster
m1494:              ldx #$06
                    jsr draw_player
                    lda #$eb                                ; the monster (try 9c for Belegro)
                    sta zpA8
                    lda #$39                                ; color of the monster's cape
                    sta zp0A
                    ldx m1494 + 1                           ; self mod the x position of the monster
m14A4:              lda #$01
                    bne m14B2               
                    cpx #$06                                ; moved 6 steps?
                    bne +                                   ; no, keep moving
                    lda #$01
+                   dex
                    jmp +                                   ; change direction

m14B2:              
                    cpx #$0b
                    bne ++
                    lda #$00
++                  inx
+                   stx m1494 + 1
                    sta m14A4 + 1
                    lda #$01
                    sta zpA7
                    ldy #$0c
                    jmp draw_player
                   
; ==============================================================================
; ROOM 17 ANIMATION
;
; ==============================================================================

room_17_prep:              
                    cpy #17                             ; room number 17?
                    bne +                               ; no -> +
m14CC:              lda #$01                            ; selfmod
                    beq ++                              
                                                       
                    ; was moved here
                    ; as it was called only from this place
                    ; jmp m15C1  
m15C1:              lda #$00                            ; a = 0 (selfmod)
                    cmp #$00                            ; is a = 0?
                    bne skipper                         ; not 0 -> 15CB
                    inc m15C1 + 1                       ; inc m15C1
                    rts
             
skipper:            dec m15C1 + 1                       ; dec $15c2
                    jmp belegro_animation

+                   lda #$0f                            ; a = $0f
                    sta m3624 + 1                       ; selfmod
                    sta m3626 + 1                       ; selfmod


                    cpy #10                             ; room number 10?
                    bne check_if_room_09                ; no -> m1523
                    dec speed_byte                      ; yes, reduce speed
                    beq laser_beam_animation            ; if positive -> laser_beam_animation            
++                  rts

; ==============================================================================
; ROOM 10
; LASER BEAM ANIMATION
; ==============================================================================

laser_beam_animation:
                   
                    ldy #$08                            ; speed of the laser flashing
                    sty speed_byte                      ; store     
                    lda #$d9
                    sta zp05                            ; affects the colram of the laser
                    lda #$05                            ; but not understood yet
                    sta zp03
                    lda #$7b                            ; position of the laser
                    sta zp02
                    sta zp04
                    lda #$df                            ; laser beam off
                    cmp m1506 + 1                       
                    bne +                               
                    lda #$d8                            ; laser beam character
+                   sta m1506 + 1                       
                    ldx #$06                            ; 6 laser beam characters
m1506:              lda #$df
                    ldy #$00
                    sta (zp02),y
                    lda #$ee
                    sta (zp04),y
                    lda zp02
                    clc
                    adc #$28                            ; draws the laser beam
                    sta zp02
                    sta zp04
                    bcc +                               
                    inc zp03
                    inc zp05
+                   dex
                    bne m1506                           
-                   rts

; ==============================================================================

check_if_room_09:              
                    cpy #09                         ; room number 09?
                    beq room_09_counter                           ; yes -> +
                    rts                             ; no

room_09_counter:
                    ldx #$01                                ; x = 1 (selfmod)
                    cpx #$01                                ; is x = 1?
                    beq +                                   ; yes -> +
                    jmp boris_the_spider_animation          ; no, jump boris animation
+                   dec room_09_counter + 1                 ; decrease initial x
                    rts

; ==============================================================================
;
; I moved this out of the main loop and call it once when changing rooms
; TODO: call it only when room 4 is entered
; ==============================================================================

room_04_prep_door:
                    
                    lda current_room + 1                            ; get current room
                    cmp #04                                         ; is it 4? (coffins)
                    bne ++                                          ; nope
                    lda #$03                                        ; OMG YES! How did you know?? (and get door char)
                    ldy m394A + 1                                   ; 
                    beq +
                    lda #$f6                                        ; put fake door char in place (making it closed)
+                   sta SCREENRAM + $f9 
++                  rts

; ==============================================================================
; ROOM 09
; BORIS THE SPIDER ANIMATION
; ==============================================================================

boris_the_spider_animation:

                    inc room_09_counter + 1                           
                    lda #>COLRAM + 1                               ; affects the color ram position for boris the spider
                    sta zp05
                    lda #>SCREENRAM
                    sta zp03
                    lda #$0f
                    sta zp02
                    sta zp04
m1535:              ldx #$06
m1537:              lda #$00
                    bne +
                    dex
                    cpx #$02
                    bne ++
                    lda #$01
                    bne ++
+                   inx
                    cpx #$07
                    bne ++
                    lda #$00
++                  sta m1537 + 1
                    stx m1535 + 1
-                   ldy #$00
                    lda #$df
                    sta (zp02),y
                    iny
                    iny
                    sta (zp02),y
                    dey
                    lda #$ea
                    sta (zp02),y
                    sta (zp04),y
                    jsr move_boris                       
                    dex
                    bne -
                    lda #$e4
                    sta zpA8
                    ldx #$02
--                  ldy #$00
-                   lda zpA8
                    sta (zp02),y
                    lda #$da
                    sta (zp04),y
                    inc zpA8
                    iny
                    cpy #$03
                    bne -
                    jsr move_boris                       
                    dex
                    bne --
                    ldy #$00
                    lda #$e7
                    sta zpA8
-                   lda (zp02),y
                    cmp zpA8
                    bne +
                    lda #$df
                    sta (zp02),y
+                   inc zpA8
                    iny
                    cpy #$03
                    bne -
                    rts

; ==============================================================================

move_boris:
                    lda zp02
                    clc
                    adc #$28
                    sta zp02
                    sta zp04
                    bcc +                                   
                    inc zp03
                    inc zp05
+                   rts




















; ==============================================================================

prep_player_pos:

                    ldx #$09
-                   lda TAPE_BUFFER + $8,x                  ; cassette tape buffer
                    sta TAPE_BUFFER + $18,x                 ; the tape buffer stores the chars UNDER the player (9 in total)
                    dex
                    bne -                                   ; so this seems to create a copy of the area under the player

                    lda #$02                                ; a = 2
                    sta zpA7
                    ldx player_pos_x + 1                    ; x = player x
                    ldy player_pos_y + 1                    ; y = player y
                    jsr draw_player                         ; draw player
                    rts





















; ==============================================================================
; OBJECT ANIMATION COLLISION ROUTINE
; CHECKS FOR INTERACTION BY ANIMATION (NOT BY PLAYER MOVEMENT)
; LASER, BELEGRO, MOVING STONE, BORIS, THE MONSTER
; ==============================================================================

object_collision:

                    ldx #$09                                ; x = 9

check_loop:              

                    lda TAPE_BUFFER + $8,x                  ; the tape buffer stores the chars UNDER the player (9 in total)
                    cmp #$d8                                ; check for laser beam
                    bne +                  

m164E:              ldy #$05
jmp_death:          jmp death                               ; 05 Didn't you see the laser beam?

+                   ldy current_room + 1                    ; get room number
                    cpy #17                                 ; is it $11 = #17 (Belegro)?
                    bne +                                   ; nope -> +
                    cmp #$78                                ; hit by the stone?
                    beq ++                                  ; yep -> ++
                    cmp #$7b                                ; or another part of the stone?
                    beq ++                                  ; yes -> ++
                    cmp #$7e                                ; or another part of the stone?
                    bne +                                   ; nah, -> +
++                  ldy #$0b                                ; 0b You were hit by a big rock and died!
                    bne jmp_death
+                   cmp #$9c                                ; so Belegro hit you?
                    bcc m1676
                    cmp #$a5
                    bcs m1676
                    jmp m16A7

m1676:              cmp #$e4                                ; hit by Boris the spider?
                    bcc +                           
                    cmp #$eb
                    bcs ++                          
-                   ldy #$04                                ; 04 Boris the spider got you and killed you
                    bne jmp_death                       
++                  cmp #$f4
                    bcs +                           
                    ldy #$0e                                ; 0e The monster grabbed you you. You are dead!
                    bne jmp_death                       
+                   dex
                    bne check_loop   



                    ldx #$09
--                  lda TAPE_BUFFER + $18, x                ; lda $034b,x
                    sta TAPE_BUFFER + $8,x                  ; the tape buffer stores the chars UNDER the player (9 in total)
                    cmp #$d8
                    beq m164E                       
                    cmp #$e4
                    bcc +                           
                    cmp #$ea
                    bcc -                           
+                   dex
                    bne --                          
                    jmp m11E0                     

m16A7:
                    ldy items + $1a7                        ; do you have the sword?
                    cpy #$df
                    beq +                                   ; yes -> +                        
                    ldy #$0c                                ; 0c Belegro killed you!
                    bne jmp_death                       
+                   ldy #$00
                    sty m14CC + 1                   
                    jmp m1676                       





































; ==============================================================================
; this might be the inventory/ world reset
; puts all items into the level data again
; maybe not. not all characters for e.g. the wirecutter is put back
; addresses are mostly within items.asm address space ( $368a )
; contains color information of the chars
; ==============================================================================

reset_items:
                    lda #$a5                        ; $a5 = lock of the shed
                    sta items + $38

                    lda #$a9                        ;
                    sta items + $8                  ; gloves
                    lda #$79
                    sta items + $6                  ; gloves color

                    lda #$e0                        ; empty char
                    sta items + $10                 ; invisible key

                    lda #$ac                        ; wirecutter
                    sta items + $19

                    lda #$b8                        ; bottle
                    sta items + $29

                    lda #$b0                        ; ladder
                    sta items + $4d
                    lda #$b5                        ; more ladder
                    sta items + $58

                    lda #$5e                        ; seems to be water?
                    sta items + $74

                    lda #$c6                        ; boots in the whatever box
                    sta items + $84

                    lda #$c0                        ; shovel
                    sta items + $96

                    lda #$cc                        ; power outlet
                    sta items + $ac

                    lda #$d0                        ; hammer
                    sta items + $bb

                    lda #$d2                        ; light bulb
                    sta items + $c8

                    lda #$d6                        ; nails
                    sta items + $d5

                    lda #$00                        ; door
                    sta items + $12c

                    lda #$dd                        ; sword
                    sta items + $1a7

                    lda #$01                        ; -> wrong write, produced selfmod at the wrong place
                    sta m394A + 1                   ; sta items + $2c1

                    lda #$01                        ; 
                    sta breathing_tube_mod + 1      ; sta items + $30a

                    lda #$f5                        ; fence
                    sta delete_fence + 1            ; sta items + $277

                    lda #$00                        ; key in the bottle
                    sta key_in_bottle_storage

                    lda #$01                        ; door
                    sta m15FC + 1

                    lda #$1e
                    sta m1602 + 1

                    lda #$01
                    sta m14CC + 1

m1732:              ldx #$05
                    cpx #$07
                    bne +
                    ldx #$ff
+                   inx
                    stx m1732 + 1                   ; stx $1733
                    lda m1747,x                     ; lda $1747,x
                    sta m3952 + 1                   ; sta $3953
                    jmp print_title                 ; jmp $310d
                    
; ==============================================================================

m1747:
                    !byte $02, $07, $04, $06, $08, $01, $05, $03


m174F:
                    cpx #$0c
                    bne +
                    lda #$49
+                   cpx #$0d
                    bne +
                    lda #$45
+                   rts



screen_win_src:

!bin "includes/screen-win-en.scr"

screen_win_src_end:


; ==============================================================================
;
; PRINT WIN SCREEN
; ==============================================================================

print_endscreen:
                    lda #>SCREENRAM
                    sta zp03
                    lda #>COLRAM
                    sta zp05
                    lda #<SCREENRAM
                    sta zp02
                    sta zp04
                    ldx #$04
                    lda #>screen_win_src
                    sta zpA8
                    lda #<screen_win_src
                    sta zpA7
                    ldy #$00
-                   lda (zpA7),y        ; copy from $175c + y
                    sta (zp02),y        ; to SCREEN
                    lda #$00            ; color = BLACK
                    sta (zp04),y        ; to COLRAM
                    iny
                    bne -
                    inc zp03
                    inc zp05
                    inc zpA8
                    dex
                    bne -
                    lda #$07                  ; yellow
                    sta BG_COLOR              ; background
                    sta BORDER_COLOR          ; und border
-                   lda $cb                   ; lda #$fd
                                              ; sta KEYBOARD_LATCH
                                              ; lda KEYBOARD_LATCH
                                              ; and #$80           ; WAITKEY?
                    
                    cmp #$3c                  ; check for space key on C64
                    bne -
                    jsr print_title
                    jsr print_title
                    jmp init


; ==============================================================================
;
; INTRO TEXT SCREEN
; ==============================================================================

intro_text:

; instructions screen
; languages data is copied from the intro
; "Search the treasure..."

!scr "Search the treasure of Ghost Town and   "
!scr "open it ! Kill Belegro, the wizard, and "
!scr "dodge all other dangers. Don't forget to"
!scr "use all the items you'll find during    "
!scr "your journey through 19 amazing hires-  "
!scr "graphics-rooms! Enjoy the quest and play"
!scr "it again and again and again ...        "
!scr "                                        "
!scr "         Press fire to start !          "


; ==============================================================================
;
; DISPLAY INTRO TEXT
; ==============================================================================

display_intro_text:

                    ; i think this part displays the introduction text

                    lda #>SCREENRAM       ; lda #$0c
                    sta zp03
                    lda #>COLRAM        ; lda #$08
                    sta zp05
                    lda #$a0
                    sta zp02
                    sta zp04
                    lda #>intro_text
                    sta zpA8
                    lda #<intro_text
                    sta zpA7
                    ldx #$09
--                  ldy #$00
-                   lda (zpA7),y
                    sta (zp02),y
                    lda #$68
                    sta (zp04),y
                    iny
                    cpy #$28
                    bne -
                    lda zpA7
                    clc
                    adc #$28
                    sta zpA7
                    bcc +
                    inc zpA8
+                   lda zp02
                    clc
                    adc #$50
                    sta zp02
                    sta zp04
                    bcc +
                    inc zp03
                    inc zp05
+                   dex
                    bne --
                    lda #$00
                    sta BG_COLOR
                    rts

; ==============================================================================
;
; DISPLAY INTRO TEXT AND WAIT FOR INPUT (SHIFT & JOY)
; DECREASES MUSIC VOLUME
; ==============================================================================

start_intro:        ;sta KEYBOARD_LATCH
                    jsr clear                                   ; jsr PRINT_KERNAL
                    jsr display_intro_text
                    jsr check_shift_key
                    
                    lda #$6
                    jsr SID_ADDRESS + 6                      ; sound volume
                    rts
































; ==============================================================================
; irq init
; ==============================================================================
                   
irq_init0:          
                    
                    lda #$0
                    jsr SID_ADDRESS

                    sei               ; set interrupt disable flag

                    ldy #$7f    ; $7f = %01111111
			        sty $dc0d   ; Turn off CIAs Timer interrupts ($7f = %01111111)
			        sty $dd0d   ; Turn off CIAs Timer interrupts ($7f = %01111111)
			        lda $dc0d   ; by reading $dc0d and $dd0d we cancel all CIA-IRQs in queue/unprocessed
			        lda $dd0d   ; by reading $dc0d and $dd0d we cancel all CIA-IRQs in queue/unprocessed

                    lda #$01    ; Set Interrupt Request Mask...
                    sta $d01a   ; ...we want IRQ by Rasterbeam (%00000001)

                    lda #<irq0 
                    ldx #>irq0        
                    sta $0314                            
                    stx $0315  

                    lda #$0    ; trigger interrupt at row zero
                    sta $d012

                    cli
                    rts


; ==============================================================================
;
; INTERRUPT routine for music
; ==============================================================================

    
irq0:
                    
                    pha
                    txa
                    pha
                    tya
                    pha

                    lsr $d019         ; acknowledge IRQ / clear register for next interrupt
                    jsr SID_ADDRESS + 3
                    
                    pla
                    tay 
                    pla
                    tax 
                    pla

                    jmp $ea31      ; return to Kernel routine

; ==============================================================================
; intro text
; wait for shift or joy2 fire press
; ==============================================================================

check_shift_key:

-                   lda $dc00
                    lsr
                    lsr
                    lsr
                    lsr
                    lsr
                    bcs -
                    rts

; ==============================================================================
;
; tileset definition
; these are the first characters in the charset of each tile.
; example: rocks start at $0c and span 9 characters in total
; ==============================================================================

tileset_definition:
tiles_chars:        ;     $00, $01, $02, $03, $04, $05, $06, $07
                    !byte $df, $0c, $15, $1e, $27, $30, $39, $42        ; empty, rock, brick, ?mark, bush, grave, coffin, coffin
                    ;     $08, $09, $0A, $0B, $0C, $0D, $0E, $0F
                    !byte $4b, $54, $5d, $66, $6f, $78, $81, $8a        ; water, water, water, tree, tree, boulder, treasure, treasure
                    ;     $10
                    !byte $03                                           ; door

!if EXTENDED = 0{
tiles_colors:       ;     $00, $01, $02, $03, $04, $05, $06, $07
                    !byte $00, $0a, $0a, $0e, $3d, $7f, $2a, $2a
                    ;     $08, $09, $0A, $0B, $0C, $0D, $0E, $0F
                    !byte $1e, $1e, $1e, $3d, $3d, $0d, $2f, $2f
                    ;     $10
                    !byte $0a
}

!if EXTENDED = 1{
tiles_colors:       ;     $00, $01, $02, $03, $04, $05, $06, $07
                    !byte $00, $0a, $0a, $0e, $3d, $7f, $2a, $2a
                    ;     $08, $09, $0A, $0B, $0C, $0D, $0E, $0F
                    !byte $1e, $1e, $1e, $3d, $3d, $0d, $2f, $2f
                    ;     $10
                    !byte $0a  
}





                    ; 222222222222222         000000000          000000000          000000000
                    ;2:::::::::::::::22     00:::::::::00      00:::::::::00      00:::::::::00
                    ;2::::::222222:::::2  00:::::::::::::00  00:::::::::::::00  00:::::::::::::00
                    ;2222222     2:::::2 0:::::::000:::::::00:::::::000:::::::00:::::::000:::::::0
                    ;            2:::::2 0::::::0   0::::::00::::::0   0::::::00::::::0   0::::::0
                    ;            2:::::2 0:::::0     0:::::00:::::0     0:::::00:::::0     0:::::0
                    ;         2222::::2  0:::::0     0:::::00:::::0     0:::::00:::::0     0:::::0
                    ;    22222::::::22   0:::::0 000 0:::::00:::::0 000 0:::::00:::::0 000 0:::::0
                    ;  22::::::::222     0:::::0 000 0:::::00:::::0 000 0:::::00:::::0 000 0:::::0
                    ; 2:::::22222        0:::::0     0:::::00:::::0     0:::::00:::::0     0:::::0
                    ;2:::::2             0:::::0     0:::::00:::::0     0:::::00:::::0     0:::::0
                    ;2:::::2             0::::::0   0::::::00::::::0   0::::::00::::::0   0::::::0
                    ;2:::::2       2222220:::::::000:::::::00:::::::000:::::::00:::::::000:::::::0
                    ;2::::::2222222:::::2 00:::::::::::::00  00:::::::::::::00  00:::::::::::::00
                    ;2::::::::::::::::::2   00:::::::::00      00:::::::::00      00:::::::::00
                    ;22222222222222222222     000000000          000000000          000000000

; ==============================================================================
; CHARSET
; $2000 - $2800
; ==============================================================================


charset_start:
                    *= $2000
                    !if EXTENDED {
                        !bin "includes/charset-extended.bin"
                    }else{
                        !bin "includes/charset.bin" ; !bin "includes/charset.bin"
                    }
charset_end:    ; $2800


                    ; 222222222222222         888888888          000000000           000000000
                    ;2:::::::::::::::22     88:::::::::88      00:::::::::00       00:::::::::00
                    ;2::::::222222:::::2  88:::::::::::::88  00:::::::::::::00   00:::::::::::::00
                    ;2222222     2:::::2 8::::::88888::::::8 0:::::::000:::::::0 0:::::::000:::::::0
                    ;            2:::::2 8:::::8     8:::::8 0::::::0   0::::::0 0::::::0   0::::::0
                    ;            2:::::2 8:::::8     8:::::8 0:::::0     0:::::0 0:::::0     0:::::0
                    ;         2222::::2   8:::::88888:::::8  0:::::0     0:::::0 0:::::0     0:::::0
                    ;    22222::::::22     8:::::::::::::8   0:::::0 000 0:::::0 0:::::0 000 0:::::0
                    ;  22::::::::222      8:::::88888:::::8  0:::::0 000 0:::::0 0:::::0 000 0:::::0
                    ; 2:::::22222        8:::::8     8:::::8 0:::::0     0:::::0 0:::::0     0:::::0
                    ;2:::::2             8:::::8     8:::::8 0:::::0     0:::::0 0:::::0     0:::::0
                    ;2:::::2             8:::::8     8:::::8 0::::::0   0::::::0 0::::::0   0::::::0
                    ;2:::::2       2222228::::::88888::::::8 0:::::::000:::::::0 0:::::::000:::::::0
                    ;2::::::2222222:::::2 88:::::::::::::88   00:::::::::::::00   00:::::::::::::00
                    ;2::::::::::::::::::2   88:::::::::88       00:::::::::00       00:::::::::00
                    ;22222222222222222222     888888888           000000000           000000000



; ==============================================================================
; LEVEL DATA
; Based on tiles
;                     !IMPORTANT!
;                     has to be page aligned or
;                     display_room routine will fail
; ==============================================================================

                    *= $2800
level_data:
                    !source "includes/levels.asm"
level_data_end:


;$2fbf
speed_byte:
!byte $01





; ==============================================================================
;
;
; ==============================================================================
        

rasterpoll_and_other_stuff:

                    jsr poll_raster
                    jsr check_door 
                    jmp animation_entrypoint          





; ==============================================================================
;
; displays a room based on tiles
; ==============================================================================

display_room:       
                    jsr draw_border
                    lda #$00
                    sta zp02
                    ldx #>COLRAM        ; HiByte of COLRAM
                    stx zp05
                    ldx #>SCREENRAM     ; HiByte of SCREENRAM
                    stx zp03
                    ldx #>level_data    ; HiByte of level_data
                    stx zp0A            ; in zp0A
current_room:       ldx #$01            ; current_room in X
                    beq ++              ; if 0 -> skip
-                   clc                 ; else
                    adc #$68            ; add $68 [= 104 = 13*8 (size of a room]
                    bcc +               ; to zp09/zp0A
                    inc zp0A            ;
+                   dex                 ; X times
                    bne -               ; => current_room_data = ( level_data + ( $68 * current_room ) )
++                  sta zp09            ; LoByte from above
                    ldy #$00
                    sty zpA8
                    sty zpA7
m3066:              lda (zp09),y        ; get Tilenumber
                    tax                 ; in X
                    lda tiles_colors,x  ; get Tilecolor
                    sta zp10            ; => zp10
                    lda tiles_chars,x   ; get Tilechar
                    sta zp11            ; => zp11
                    ldx #$03            ; (3 rows)
--                  ldy #$00
-                   lda zp02            ; LoByte of SCREENRAM pointer
                    sta zp04            ; LoByte of COLRAM pointer
                    lda zp11            ; Load Tilechar
                    sta (zp02),y        ; to SCREENRAM + Y
                    lda zp10            ; Load Tilecolor
                    sta (zp04),y        ; to COLRAM + Y
                    lda zp11            ; Load Tilechar again
                    cmp #$df            ; if empty tile
                    beq +               ; -> skip
                    inc zp11            ; else: Tilechar + 1
+                   iny                 ; Y = Y + 1
                    cpy #$03            ; Y = 3 ? (Tilecolumns)
                    bne -               ; no -> next Char
                    lda zp02            ; yes:
                    clc
                    adc #$28            ; next SCREEN row
                    sta zp02
                    bcc +
                    inc zp03
                    inc zp05            ; and COLRAM row
+                   dex                 ; X = X - 1
                    bne --              ; X != 0 -> next Char
                    inc zpA8            ; else: zpA8 = zpA8 + 1
                    inc zpA7            ; zpA7 = zpA7 + 1
                    lda #$75            ; for m30B8 + 1
                    ldx zpA8
                    cpx #$0d            ; zpA8 < $0d ? (same Tilerow)
                    bcc +               ; yes: -> skip (-$75 for next Tile)
                    ldx zpA7            ; else:
                    cpx #$66            ; zpA7 >= $66
                    bcs display_door    ; yes: display_door
                    lda #$00            ; else:
                    sta zpA8            ; clear zpA8
                    lda #$24            ; for m30B8 + 1
+                   sta m30B8 + 1       ;
                    lda zp02
                    sec
m30B8:              sbc #$75            ; -$75 (next Tile in row) or -$24 (next row )
                    sta zp02
                    bcs +
                    dec zp03
                    dec zp05
+                   ldy zpA7
                    jmp m3066
                    rts                 ; will this ever be used?

display_door:       lda #>SCREENRAM
                    sta zp03
                    lda #>COLRAM
                    sta zp05
                    lda #$00
                    sta zp02
                    sta zp04
-                   ldy #$28
                    lda (zp02),y        ; read from SCREENRAM
                    cmp #$06            ; $06 (part from Door?)
                    bcs +               ; >= $06 -> skip
                    sec                 ; else:
                    sbc #$03            ; subtract $03
                    ldy #$00            ; set Y = $00
                    sta (zp02),y        ; and copy to one row above
                    lda #$0a            ; lda #$39 ; color brown - luminance $3  -> color of the top of a door
                    sta (zp04),y
+                   lda zp02
                    clc
                    adc #$01            ; add 1 to SCREENRAM pointer low
                    bcc +
                    inc zp03            ; inc pointer HiBytes if necessary
                    inc zp05
+                   sta zp02
                    sta zp04
                    cmp #$98            ; SCREENRAM pointer low = $98
                    bne -               ; no -> loop
                    lda zp03            ; else:
                    cmp #>(SCREENRAM+$300)
                    bne -               ; no -> loop
                    rts                 ; else: finally ready with room display

; ==============================================================================

print_title:        lda #>SCREENRAM
                    sta zp03
                    lda #>COLRAM
                    sta zp05
                    lda #<SCREENRAM
                    sta zp02
                    sta zp04
                    lda #>screen_start_src
                    sta zpA8
                    lda #<screen_start_src
                    sta zpA7
                    ldx #$04
--                  ldy #$00
-                   lda (zpA7),y        ; $313C + Y ( Titelbild )
                    sta (zp02),y        ; nach SCREEN
                    lda #$00           ; BLACK
                    sta (zp04),y        ; nach COLRAM
                    iny
                    bne -
                    inc zp03
                    inc zp05
                    inc zpA8
                    dex
                    bne --
                    rts

; ==============================================================================
; TITLE SCREEN DATA
;
; ==============================================================================

screen_start_src:

                    !if EXTENDED {
                        !bin "includes/title-extended.scr"
                    }else{
                        !bin "includes/title.scr"
                    }

screen_start_src_end:


; ==============================================================================
; i think this might be the draw routine for the player sprite
;
; ==============================================================================


draw_player:
                    stx m3548 + 1                       ; store x pos of player
                    lda #>COLRAM                        ; store colram high in zp05
                    sta zp05
                    lda #>SCREENRAM                     ; store screenram high in zp03
                    sta zp03
                    lda #$00
                    sta zp02
                    sta zp04                            ; 00 for zp02 and zp04 (colram low and screenram low)
                    cpy #$00                            ; Y is probably the player Y position
                    beq +                               ; Y is 0 -> +
-                   clc                                 ; Y not 0
                    adc #$28                            ; add $28 (=#40 = one line) to A (which is now $28)
                    bcc ++                              ; <256? -> ++
                    inc zp03
                    inc zp05
++                  dey                                 ; Y = Y - 1
                    bne -                               ; Y = 0 ? -> -
+                   clc                                 ;
m3548:              adc #$16                            ; add $15 (#21) why? -> selfmod address
                    sta zp02
                    sta zp04
                    bcc +
                    inc zp03
                    inc zp05
+                   ldx #$03                            ; draw 3 rows for the player "sprite"
                    lda #$00
                    sta zp09
--                  ldy #$00
-                   lda zpA7
                    bne +
                    lda #$df                            ; empty char, but not sure why
                    sta (zp02),y
                    bne ++
+                   cmp #$01
                    bne +
                    lda zpA8
                    sta (zp02),y
                    lda zp0A
                    sta (zp04),y
                    bne ++
+                   lda (zp02),y
                    stx zp10
                    ldx zp09
                    sta TAPE_BUFFER + $9,x              ; the tape buffer stores the chars UNDER the player (9 in total)
                    inc zp09
                    ldx zp10
++                  inc zpA8
                    iny
                    cpy #$03                            ; width of the player sprite in characters (3)
                    bne -
                    lda zp02
                    clc
                    adc #$28                            ; $28 = #40, draws one row of the player under each other
                    sta zp02
                    sta zp04
                    bcc +
                    inc zp03
                    inc zp05
+                   dex
                    bne --
                    rts


; ==============================================================================
; $359b
; JOYSTICK CONTROLS
; ==============================================================================

check_joystick:

                    ;lda #$fd
                    ;sta KEYBOARD_LATCH
                    ;lda KEYBOARD_LATCH
                    lda $dc00
player_pos_y:       ldy #$09
player_pos_x:       ldx #$15
                    lsr
                    bcs +
                    cpy #$00
                    beq +
                    dey                                           ; JOYSTICK UP
+                   lsr
                    bcs +
                    cpy #$15
                    bcs +
                    iny                                           ; JOYSTICK DOWN
+                   lsr
                    bcs +
                    cpx #$00
                    beq +
                    dex                                           ; JOYSTICK LEFT
+                   lsr
                    bcs +
                    cpx #$24
                    bcs +
                    inx                                           ; JOYSTICK RIGHT
+                   sty m35E7 + 1
                    stx m35EC + 1
                    lda #$02
                    sta zpA7
                    jsr draw_player
                    ldx #$09
-                   lda TAPE_BUFFER + $8,x
                    cmp #$df
                    beq +
                    cmp #$e2
                    bne ++
+                   dex
                    bne -
m35E7:              lda #$0a
                    sta player_pos_y + 1
m35EC:              lda #$15
                    sta player_pos_x + 1
++                  ;lda #$ff
                    ;sta KEYBOARD_LATCH
                    lda #$01
                    sta zpA7
                    lda #$93                ; first character of the player graphic
                    sta zpA8
                    lda #$3d
                    sta zp0A
get_player_pos:     ldy player_pos_y + 1
                    ldx player_pos_x + 1
              
                    jmp draw_player

; ==============================================================================
;
; POLL RASTER
; ==============================================================================

poll_raster:
                    sei                     ; disable interrupt
                    lda #$f0                ; lda #$c0  ;A = $c0
-                   cmp FF1D                ; vertical line bits 0-7
                    
                    bne -                   ; loop until we hit line c0
                    lda #$00                ; A = 0
                    sta zpA7                ; zpA7 = 0
                    
                    jsr get_player_pos
                    
                    jsr check_joystick
                    cli
                    rts


; ==============================================================================
; ROOM 16
; BELEGRO ANIMATION
; ==============================================================================

belegro_animation:

                    lda #$00
                    sta zpA7
m3624:              ldx #$0f
m3626:              ldy #$0f
                    jsr draw_player
                    ldx m3624 + 1
                    ldy m3626 + 1
                    cpx player_pos_x + 1
                    bcs +
                    inx
                    inx
+                   cpx player_pos_x + 1
                    beq +
                    dex
+                   cpy player_pos_y + 1
                    bcs +
                    iny
                    iny
+                   cpy player_pos_y + 1
                    beq +
                    dey
+                   stx m3668 + 1
                    sty m366D + 1
                    lda #$02
                    sta zpA7
                    jsr draw_player
                    ldx #$09
-                   lda TAPE_BUFFER + $8,x
                    cmp #$92
                    bcc +
                    dex
                    bne -
m3668:              ldx #$10
                    stx m3624 + 1
m366D:              ldy #$0e
                    sty m3626 + 1
+                   lda #$9c                                ; belegro chars
                    sta zpA8
                    lda #$3e
                    sta zp0A
                    ldy m3626 + 1
                    ldx m3624 + 1                    
                    lda #$01
                    sta zpA7
                    jmp draw_player


; ==============================================================================
; items
; This area seems to be responsible for items placement
;
; ==============================================================================

items:
                    !source "includes/items.asm"
items_end:

next_item:
                    lda zpA7
                    clc
                    adc #$01
                    sta zpA7
                    bcc +                       ; bcc $3845
                    inc zpA8
+                   rts

; ==============================================================================
; TODO
; no clue yet. level data has already been drawn when this is called
; probably placing the items on the screen
; ==============================================================================

update_items_display:
                    lda #>items                 ; load address for items into zeropage
                    sta zpA8
                    lda #<items
                    sta zpA7
                    ldy #$00                    ; y = 0
--                  lda (zpA7),y                ; load first value
                    cmp #$ff                    ; is it $ff?
                    beq +                       ; yes -> +
-                   jsr next_item               ; no -> set zero page to next value
                    jmp --                      ; and loop
+                   jsr next_item               ; value was $ff, now get the next value in the list
                    lda (zpA7),y
                    cmp #$ff                    ; is the next value $ff again?
                    bne +
                    jmp prepare_rooms           ; yes -> m38DF
+                   cmp current_room + 1        ; is the number the current room number?
                    bne -                       ; no -> loop
                    lda #>COLRAM                ; yes the number is the current room number
                    sta zp05                    ; store COLRAM and SCREENRAM in zeropage
                    lda #>SCREENRAM
                    sta zp03
                    lda #$00                    ; A = 0
                    sta zp02                    ; zp02 = 0, zp04 = 0
                    sta zp04
                    jsr next_item               ; move to next value
                    lda (zpA7),y                ; get next value in the list
-                   cmp #$fe                    ; is it $FE?
                    beq +                       ; yes -> +
                    cmp #$f9                    ; no, is it $f9?
                    bne +++                     ; no -> +++
                    lda zp02                    ; value is $f9
                    jsr m38D7                   ; add 1 to zp02 and zp04
                    bcc ++                      ; if neither zp02 nor zp04 have become 0 -> ++
+                   inc zp03                    ; value is $fe
                    inc zp05                    ; increase zp03 and zp05
++                  lda (zpA7),y                ; get value from list
+++                 cmp #$fb                    ; it wasn't $f9, so is it $fb?
                    bne +                       ; no -> +
                    jsr next_item               ; yes it's $fb, get the next value
                    lda (zpA7),y                ; get value from list
                    sta zp09                    ; store value in zp09
                    bne ++                      ; if value was 0 -> ++
+                   cmp #$f8
                    beq +
                    cmp #$fc
                    bne +++
                    lda zp0A
                                                ; jmp m399F

                    cmp #$df                    ; this part was moved here as it wasn't called anywhere else
                    beq skip                    ; and I think it was just outsourced for branching length issues
                    inc zp0A           
skip:               lda (zpA7),y        
                    jmp m38B7

+++                 cmp #$fa
                    bne ++
                    jsr next_item
                    lda (zpA7),y
                    sta zp0A
m38B7:
+                   lda zp09
                    sta (zp04),y
                    lda zp0A
                    sta (zp02),y
++                  cmp #$fd
                    bne +
                    jsr next_item
                    lda (zpA7),y
                    sta zp02
                    sta zp04
+                   jsr next_item
                    lda (zpA7),y
                    cmp #$ff
                    bne -
                    beq prepare_rooms
m38D7:              clc
                    adc #$01
                    sta zp02
                    sta zp04
                    rts




























; ==============================================================================
; ROOM PREPARATION CHECK
; WAS INITIALLY SCATTERED THROUGH THE LEVEL COMPARISONS
; ==============================================================================

prepare_rooms:
            
                    lda current_room + 1
                    
                    cmp #$02                                ; is the current room 02?
                    beq room_02_prep

                    cmp #$07
                    beq room_07_make_sacred_column
                    
                    cmp #$06          
                    beq room_06_make_deadly_doors

                    cmp #$04
                    beq room_04_prep

                    cmp #$05
                    beq room_05_prep

                    rts



; ==============================================================================
; ROOM 05
; HIDE THE BREATHING TUBE UNDER THE STONE
; ==============================================================================

room_05_prep:                  
                               
                    lda #$fd                                    ; yes
breathing_tube_mod: ldx #$01
                    bne +                                       ; based on self mod, put the normal
                    lda #$7a                                    ; stone char back again
+                   sta SCREENRAM + $2d2   
                    rts



; ==============================================================================
; ROOM 02 PREP
; 
; ==============================================================================

room_02_prep:
                    lda #$0d                                ; yes room is 02, a = $0d #13
                    sta zp02                                ; zp02 = $0d
                    sta zp04                                ; zp04 = $0d
                    lda #>COLRAM                            ; set colram zp
                    sta zp05
                    lda #>SCREENRAM                         ; set screenram zp      
                    sta zp03
                    ldx #$18                                ; x = $18 #24
-                   lda (zp02),y                            ; y must have been set earlier
                    cmp #$df                                ; $df = empty space likely
                    beq delete_fence                        ; yes, empty -> m3900
                    cmp #$f5                                ; no, but maybe a $f5? (fence!)
                    bne +                                   ; nope -> ++

delete_fence:
                    lda #$f5                                ; A is either $df or $f5 -> selfmod here
                    sta (zp02),y                            ; store that value
                    sta (zp04),y                            ; in zp02 and zo04
+                   lda zp02                                ; and load it in again, jeez
                    clc
                    adc #$28                                ; smells like we're going to draw a fence
                    sta zp02
                    sta zp04
                    bcc +             
                    inc zp03
                    inc zp05
+                   dex
                    bne -              
                    rts

; ==============================================================================
; ROOM 07 PREP
;
; ==============================================================================

room_07_make_sacred_column:

                    
                    ldx #$17                                    ; yes
-                   lda SCREENRAM + $168,x     
                    cmp #$df
                    bne +                       
                    lda #$e3
                    sta SCREENRAM + $168,x    
+                   dex
                    bne -                      
                    rts


; ==============================================================================
; ROOM 06
; PREPARE THE DEADLY DOORS
; ==============================================================================

room_06_make_deadly_doors:

                    
                    lda #$f6                                    ; char for wrong door
                    sta SCREENRAM + $9c                         ; make three doors DEADLY!!!11
                    sta SCREENRAM + $27c
                    sta SCREENRAM + $36c       
                    rts

; ==============================================================================
; ROOM 04
; PUT SOME REALLY DEADLY ZOMBIES INSIDE THE COFFINS
; ==============================================================================

room_04_prep: 


                    
                    lda current_room + 1                            ; get current room
                    cmp #04                                         ; is it 4? (coffins)
                    bne ++                                          ; nope
                    lda #$03                                        ; OMG YES! How did you know?? (and get door char)
                    ldy m394A + 1                                   ; 
                    beq +
                    lda #$f6                                        ; put fake door char in place (making it closed)
+                   sta SCREENRAM + $f9 
                
++                  ldx #$f7                                    ; yes room 04
                    ldy #$f8
m394A:              lda #$01
                    bne m3952           
                    ldx #$3b
                    ldy #$42
m3952:              lda #$01                                    ; some self mod here
                    cmp #$01
                    bne +           
                    stx SCREENRAM+ $7a 
+                   cmp #$02
                    bne +           
                    stx SCREENRAM + $16a   
+                   cmp #$03
                    bne +           
                    stx SCREENRAM + $25a       
+                   cmp #$04
                    bne +           
                    stx SCREENRAM + $34a   
+                   cmp #$05
                    bne +           
                    sty SCREENRAM + $9c    
+                   cmp #$06
                    bne +           
                    sty SCREENRAM + $18c   
+                   cmp #$07
                    bne +           
                    sty SCREENRAM + $27c 
+                   cmp #$08
                    bne +           
                    sty SCREENRAM + $36c   
+                   rts




















; ==============================================================================
; PLAYER POSITION TABLE FOR EACH ROOM
; FORMAT: Y left door, X left door, Y right door, X right door
; ==============================================================================

player_xy_pos_table:

!byte $06, $03, $12, $21                                        ; room 00
!byte $03, $03, $12, $21                                        ; room 01
!byte $03, $03, $15, $21                                        ; room 02
!byte $03, $03, $0f, $21                                        ; room 03
!byte $15, $1e, $06, $06                                        ; room 04
!byte $06, $03, $12, $21                                        ; room 05
!byte $03, $03, $09, $21                                        ; room 06
!byte $03, $03, $12, $21                                        ; room 07
!byte $03, $03, $0c, $21                                        ; room 08
!byte $03, $03, $12, $21                                        ; room 09
!byte $0c, $03, $0c, $20                                        ; room 10
!byte $0c, $03, $0c, $21                                        ; room 11
!byte $0c, $03, $09, $15                                        ; room 12
!byte $03, $03, $06, $21                                        ; room 13
!byte $03, $03, $03, $21                                        ; room 14
!byte $06, $03, $12, $21                                        ; room 15
!byte $03, $03, $03, $1d                                        ; room 16
!byte $03, $03, $06, $21                                        ; room 17
!byte $03, $03                                                  ; room 18 (only one door)



; ==============================================================================
; $3a33
; Apparently some lookup table, e.g. to get the 
; ==============================================================================

room_player_pos_lookup:

!byte $02 ,$06 ,$0a ,$0e ,$12 ,$16 ,$1a ,$1e ,$22 ,$26 ,$2a ,$2e ,$32 ,$36 ,$3a ,$3e
!byte $42 ,$46 ,$4a ,$4e ,$52 ,$56 ,$5a ,$5e ,$04 ,$08 ,$0c ,$10 ,$14 ,$18 ,$1c ,$20
!byte $24 ,$28 ,$2c ,$30 ,$34 ,$38 ,$3c ,$40 ,$44 ,$48 ,$4c ,$50 ,$54 ,$58 ,$5c ,$60
!byte $00











; ==============================================================================
;
;
; ==============================================================================

check_door:

                    ldx #$09                                    ; set loop to 9
-                   lda TAPE_BUFFER + $8,x                      ; get value from tape buffer
                    cmp #$05                                    ; is it a 05? -> right side of the door, meaning LEFT DOOR
                    beq +                                       ; yes -> +
                    cmp #$03                                    ; is it a 03? -> left side of the door, meaning RIGHT DOOR
                    beq set_player_xy                           ; yes -> m3A17
                    dex                                         ; decrease loop
                    bne -                                       ; loop
-                   rts

+                   ldx current_room + 1
                    beq -               
                    dex
                    stx current_room + 1                        ; update room number                         
                    ldy room_player_pos_lookup,x                ; load        
                    jmp update_player_pos           

set_player_xy:
                    ldx current_room + 1                            ; x = room number
                    inx                                             ; room number ++
                    stx current_room + 1                            ; update room number
                    ldy room_player_pos_lookup + $17, x             ; y = ( $08 for room 2 ) -> get table pos for room

update_player_pos:              
                    lda player_xy_pos_table,y                       ; a = pos y ( $03 for room 2 )
                    sta player_pos_y + 1                            ; player y pos = a
                    lda player_xy_pos_table + 1,y                   ; y +1 = player x pos
                    sta player_pos_x + 1

m3A2D:              jsr display_room                                ; done  
                    jsr room_04_prep_door                           ; was in main loop before, might find a better place
                    jmp update_items_display



; ==============================================================================
;
; wait routine
; usually called with Y set before
; ==============================================================================

wait:
                    dex
                    bne wait
                    dey
                    bne wait
fake:               rts


; ==============================================================================
; sets the game screen
; multicolor, charset, main colors
; ==============================================================================

set_game_basics:
                    lda VOICE1                                  ; 0-1 TED Voice, 2 TED data fetch rom/ram select, Bits 0-5 : Bit map base address
                    and #$fb                                    ; clear bit 2
                    sta VOICE1                                  ; => get data from RAM
                    lda #$18            ;lda #$21
                    sta CHAR_BASE_ADDRESS                       ; bit 0 : Status of Clock   ( 1 )
                    
                                                                ; bit 1 : Single clock set  ( 0 )
                                                                ; b.2-7 : character data base address
                                                                ; %00100$x ($2000)
                    lda FF07
                    ora #$90                                    ; multicolor ON - reverse OFF
                    sta FF07

                                                                ; set the main colors for the game

                    lda #MULTICOLOR_1                           ; original: #$db
                    sta COLOR_1                                 ; char color 1
                    lda #MULTICOLOR_2                           ; original: #$29
                    sta COLOR_2                                 ; char color 2
                    
                    rts

; ==============================================================================
; set font and screen setup (40 columns and hires)
; $3a9d
; ==============================================================================

set_charset_and_screen:                               ; set text screen
                   
                    lda VOICE1
                    ora #$04                                    ; set bit 2
                    sta VOICE1                                  ; => get data from ROM
                    lda #$17                                    ; lda #$d5                                    ; ROM FONT
                    sta CHAR_BASE_ADDRESS                       ; set
                    lda FF07
                    lda #$08                                    ; 40 columns and Multicolor OFF
                    sta FF07
                    rts


; ==============================================================================
; init
; start of game (original $3ab3)
; ==============================================================================

code_start:
                
                    jsr irq_init0
                    
init:
                    lda #$d
                    jsr SID_ADDRESS + 6                         ; sound volume

                    lda #$17                                    ; set lower case charset
                    sta $d018                                   ; wasn't on Plus/4 for some reason
                    
                    lda #$0b
                    sta BG_COLOR                                ; background color
                    sta BORDER_COLOR                            ; border color
                    jsr reset_items                             ; might be a level data reset, and print the title screen

                    ldy #$20
                    jsr wait
                    
                    ; waiting for key press on title screen

-                   lda $cb                                     ; zp position of currently pressed key
                    cmp #$3c                                    ; is it the space key?
                    bne -

                                                                ; lda #$ff
                    jsr start_intro                             ; displays intro text, waits for shift/fire and decreases the volume
                    

                    ; TODO: unclear what the code below does
                    ; i think it fills the level data with "DF", which is a blank character
                    lda #>SCREENRAM
                    sta zp03
                    lda #$00
                    sta zp02
                    ldx #$04
                    ldy #$00
                    lda #$df
-                   sta (zp02),y
                    iny
                    bne -
                    inc zp03
                    dex
                    bne -
                    
                    jsr set_game_basics           ; jsr $3a7d -> multicolor, charset and main char colors

                    ; set background color
                    lda #$00
                    sta BG_COLOR

                    ; border color. default is a dark red
                    lda #BORDER_COLOR_VALUE
                    sta BORDER_COLOR
                    
                    jsr draw_border
                    
                    jmp set_start_screen

; ==============================================================================
;
; draws the extended "border"
; ==============================================================================

draw_border:        
                    lda #$27
                    sta zp02
                    sta zp04
                    lda #>COLRAM
                    sta zp05
                    lda #>SCREENRAM
                    sta zp03
                    ldx #$18
                    ldy #$00
-                   lda #$5d
                    sta (zp02),y
                    lda #COLOR_FOR_INVISIBLE_ROW_AND_COLUMN
                    sta (zp04),y
                    tya
                    clc
                    adc #$28
                    tay
                    bcc +
                    inc zp03
                    inc zp05
+                   dex
                    bne -
-                   lda #$5d
                    sta SCREENRAM + $3c0,x
                    lda #COLOR_FOR_INVISIBLE_ROW_AND_COLUMN
                    sta COLRAM + $3c0,x
                    inx
                    cpx #$28
                    bne -
                    rts

; ==============================================================================
; SETUP FIRST ROOM
; player xy position and room number
; ==============================================================================

set_start_screen:
                    lda #PLAYER_START_POS_Y
                    sta player_pos_y + 1                    ; Y player start position (0 = top)
                    lda #PLAYER_START_POS_X
                    sta player_pos_x + 1                    ; X player start position (0 = left)
                    lda #START_ROOM                         ; room number (start screen) ($3b45)
                    sta current_room + 1
                    jsr m3A2D
                    

main_loop:
                    
                    jsr rasterpoll_and_other_stuff
                    ldy #$1b                                ; ldy #$30    ; wait a bit -> in each frame! slows down movement
                    jsr wait
                                                            ;jsr room_04_prep_door
                    jsr prep_player_pos
                    jmp object_collision

; ==============================================================================
;
; Display the death message
; End of game and return to start screen
; ==============================================================================

death:
                   
                    lda #>death_messages
                    sta zpA8
                    lda #<death_messages
                    sta zpA7
                    cpy #$00
                    beq ++
-                   clc
                    adc #$32
                    sta zpA7
                    bcc +
                    inc zpA8
+                   dey
                    bne -
++                  lda #$0c
                    sta zp03
                    sty zp02
                    ldx #$04
                    lda #$20
-                   sta (zp02),y
                    iny
                    bne -
                    inc zp03
                    dex
                    bne -
                    jsr set_charset_and_screen
                    jsr clear
-                   lda (zpA7),y
                    sta SCREENRAM + $1c0,x   ; sta $0dc0,x         ; position of the death message
                    lda #$00                                    ; color of the death message
                    sta COLRAM + $1c0,x     ; sta $09c0,x
                    inx
                    iny
                    cpx #$19
                    bne +
                    ldx #$50
+                   cpy #$32
                    bne -
                    lda #$03
                    sta BG_COLOR
                    sta BORDER_COLOR
                   
m3EF9:
                    lda #$08
-                   ldy #$ff
                    jsr wait
                    sec
                    sbc #$01
                    bne -
                    
                    jmp init

; ==============================================================================
;
; clear the sceen (replacing kernal call on plus/4)
; 
; ==============================================================================

clear               lda #$20                    ; #$20 is the spacebar Screen Code
                    sta $0400,x                 ; fill four areas with 256 spacebar characters
                    sta $0500,x 
                    sta $0600,x 
                    sta $06e8,x 
                    lda #$00                    ; set foreground to black in Color Ram 
                    sta $d800,x  
                    sta $d900,x
                    sta $da00,x
                    sta $dae8,x
                    inx                         ; increment X
                    bne clear                   ; did X turn to zero yet?
                                                ; if not, continue with the loop
                    rts                         ; return from this subroutine
; ==============================================================================
;
; DEATH MESSAGES
; ==============================================================================

death_messages:

; death messages
; like "You fell into a snake pit"
; other languages are copied over from the intro.asm

; scr conversion

; 00 You fell into a snake pit
; 01 You'd better watched out for the sacred column
; 02 You drowned in the deep river
; 03 You drank from the poisend bottle
; 04 Boris the spider got you and killed you
; 05 Didn't you see the laser beam?
; 06 240 Volts! You got an electrical shock!
; 07 You stepped on a nail!
; 08 A foot trap stopped you!
; 09 This room is doomed by the wizard Manilo!
; 0a You were locked in and starved!
; 0b You were hit by a big rock and died!
; 0c Belegro killed you!
; 0d You found a thirsty zombie....
; 0e The monster grabbed you you. You are dead!
; 0f You were wounded by the bush!
; 10 You are trapped in wire-nettings!


!scr "You fell into a          snake pit !              "
!scr "You'd better watched out for the sacred column!   "
!scr "You drowned in the deep  river !                  "
!scr "You drank from the       poisoned bottle ........ "
!scr "Boris, the spider, got   you and killed you !     "
!scr "Didn't you see the       laser beam ?!?           "
!scr "240 Volts ! You got an   electrical shock !       " ; original: !scr "240 Volts ! You got an electrical shock !         "
!scr "You stepped on a nail !                           "
!scr "A foot trap stopped you !                         "
!scr "This room is doomed      by the wizard Manilo !   "
!scr "You were locked in and   starved !                " ; original: !scr "You were locked in and starved !                  "
!scr "You were hit by a big    rock and died !          "
!scr "Belegro killed           you !                    "
!scr "You found a thirsty      zombie .......           "
!scr "The monster grabbed       you. You are dead !     "
!scr "You were wounded by      the bush !               "
!scr "You are trapped in       wire-nettings !          "








; ==============================================================================
; screen messages
; and the code entry text
; ==============================================================================

hint_messages:
!scr " A part of the code number is :         "
!scr " ABCDEFGHIJKLMNOPQRSTUVWXYZ 0123456789",$bc," "
!scr " You need: bulb, bulb holder, socket !  "
!scr " Tell me the Code number ?     ",$22,"     ",$22,"  "
!scr " *****   A helping letter :   "
helping_letter: !scr "C   ***** "
!scr " Wrong code number ! DEATH PENALTY !!!  " ; original: !scr " Sorry, bad code number! Better luck next time! "



; ==============================================================================
;
; ITEM PICKUP MESSAGES
; ==============================================================================


item_pickup_message:              ; item pickup messages

!scr " There is a key in the bottle !         "
!scr "   There is a key in the coffin !       "
!scr " There is a breathing tube !            "

item_pickup_message_end:




; ==============================================================================
;
; CODE ADDITION AREA
; ==============================================================================

; intro_start
!source "includes/intro.asm"


*= SID_ADDRESS ; $5000
!bin "../music/industrialtown.sid",, $7c+2  ; remove header from sid and cut off original loading address 

*= COLORS ; $6000
!bin "../gfx/gt-colors.bin"
; save "/Users/ingohinterding/Desktop/gt-colors.bin" 0 d800 dbe7

*= PETSCII_CHARS ; $8000
!source "includes/petscii-intro.asm"

*= BITMAP ; $c000
!bin "../gfx/gt-bitmap.bin"
; save "/Users/ingohinterding/Desktop/gt-bitmap.bin" 0 2000 3f3f

*= SCREEN ; $e000
!bin "../gfx/gt-screen.bin"
; save "/Users/ingohinterding/Desktop/gt-screen.bin" 0 0400 07e7

