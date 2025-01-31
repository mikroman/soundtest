#import "os.asm"

* = $1900  "main" //build.asm at $1900
start:

  jsr sound_init

  // stop foreground code here (music will play from vblank event)
stop:
  jmp stop

  // back to os
  rts

sound_init:
{
  // define envelope
  lda #$08
  ldx #<envelope
  ldy #>envelope
  jsr osword

  // set up event handler 
  sei
  lda #<eventv_handler
  sta evntv
  lda #>eventv_handler
  sta evntv+1
  cli

  // enable start of vertical sync event
  lda #$0e
  ldx #$04
  jsr osbyte
  rts

envelope:
.byte 1   // envelope number
.byte 2   // length of each step (hundredths of a second) and auto repeat (top bit)
.byte 0   // change of pitch per step in section 1
.byte 0   // change of pitch per step in section 2
.byte 0   // change of pitch per step in section 3
.byte 1   // number of steps in section 1
.byte 2   // number of steps in section 2
.byte 3   // number of steps in section 3
.byte 100 // change of amplitude per step during attack phase
.byte 1   // change of amplitude per step during decay phase
.byte 255 // change of amplitude per step during sustain phase
.byte 254 // change of amplitude per step during release phase
.byte 126 // target level at end of attack phase
.byte 126 // target level at end of decay phase
}

eventv_handler:
{
  // return if counter not zero (i.e. only do something every 8th call)
  inc counter
  lda counter
  and #$07
  bne done

  inc progress

  // start with channel $11 (channel 1 with flush enabled)
  lda #$11
  sta soundparams

  // read melody data for each of the three channels
  ldx progress
  lda melody, x
  jsr sound_play_note
  ldx progress
  lda melody+$100, x
  jsr sound_play_note
  ldx progress
  lda melody+$200, x
  jsr sound_play_note

done:

  rts
}

sound_play_note:
{
  // skip when pitch is zero (it's a rest)
  beq done

  // set pitch lsb
  sta soundparams+4

  // set all msb to zero
  lda #$00
  sta soundparams+1
  sta soundparams+3
  sta soundparams+5
  sta soundparams+7

  // use envelope 1 for amplitude
  lda #$01
  sta soundparams+2
  // set duration of 1
  sta soundparams+6

  // set pointer to sound params in xy
  ldx #<soundparams
  ldy #>soundparams

  // action os sound function
  lda #$07
  jsr osword

  // go to next sound channel
  inc soundparams

done:
  rts
}

// skip counter
counter:
.byte $00

// progress through melody
progress:
.byte $00

// sound parameter block
soundparams:
.byte $00 // channel lsb
.byte $00 // channel msb
.byte $00 // amplitude lsb
.byte $00 // amplitude msb
.byte $00 // pitch lsb
.byte $00 // pitch msb
.byte $00 // duration lsb
.byte $00 // duration msb

.align $100

// melody data
melody:
.import binary "melody.beeb"
//end:

//save "sounds", start, end
