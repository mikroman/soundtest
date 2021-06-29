// os function vectors

.label userv = $0200
.label brkv = $0202
.label irq1v = $0204
.label irq2v = $0206
.label cliv = $0208
.label bytev = $020a
.label wordv = $020c
.label wrchv = $020e
.label rdchv = $0210
.label filev = $0212
.label argsv = $0214
.label bgetv = $0216
.label bputv = $0218
.label gbpbv = $021a
.label findv = $021c
.label fscv = $021e
.label evntv = $0220
.label uptv = $0222
.label netv = $0224
.label vduv = $0226
.label keyv = $0228
.label insbv = $022a
.label remvb = $022c
.label cnpv = $022e
.label ind1v = $0230
.label ind2v = $0232
.label ind3v = $0234

// os function call locations

.label osfsc  = $f1b1 // filing system control (entry via fscv)

.label oswrsc = $ffb3 // write byte to screen
.label osrdsc = $ffb9 // read byte from screen

.label osnull = $ffa6 // blank function handler (just an rts)

.label vduchr = $ffbc // vdu character output
.label oseven = $ffbf // generate an event
.label gsinit = $ffc2 // initialise os string
.label gsread = $ffc5 // read character from input stream
.label nvrdch = $ffc8 // non vectored osrdch
.label nvwrch = $ffcb // non vectored oswrch
.label osfind = $ffce // open or close a file
.label osgbpb = $ffd1 // transfer block to or from a file (get block / put block)
.label osbput = $ffd4 // save a byte to file
.label osbget = $ffd7 // get a byte from file
.label osargs = $ffda // read or write file attributes
.label osfile = $ffdd // read or write a complete file
.label osrdch = $ffe0 // get a byte from current input stream
.label osasci = $ffe3 // output a byte to vdu stream expanding cr ($0d) to lf/cr ($0a,$0d)
.label osnewl = $ffe7 // output a lf/cr to vdu stream
.label oswrch = $ffee // output a character to the vdu stream
.label osword = $fff1 // perform operation using parameter table
.label osbyte = $fff4 // perform operation on single byte
.label oscli  = $fff7 // pass string to command line interpreter

// system hardware

.label fredbase = $fc00 // memory mapped hardware

.label jimbase = $fd00 // 64k paged memory

.label sheilabase = $fe00 // system peripherals
// 6845 crtc
.label crtc00 = sheilabase+$00 // address register (5 bit)
.label crtc01 = sheilabase+$01 // data register
// 6850 acia
.label acia08 = sheilabase+$08
.label acia09 = sheilabase+$09
.label acia0a = sheilabase+$0a
.label acia0b = sheilabase+$0b
.label acia0c = sheilabase+$0c
.label acia0d = sheilabase+$0d
.label acia0e = sheilabase+$0e
.label acia0f = sheilabase+$0f
// serial ula
// video ula
.label ula_vid20 = sheilabase+$20 // video control register
.label ula_vid21 = sheilabase+$21 // colour palette
// paged rom selector
.label pagerom = sheilabase+$30 // paged rom select (4 bit)
// 6522 system via
// 6522 user/printer via
// 8271 fdc
.label fdc_status = sheilabase+$80
.label fdc_result = sheilabase+$81
.label fdc_command = sheilabase+$80
.label fdc_param = sheilabase+$81
.label fdc_reset = sheilabase+$82
.label fdc_data = sheilabase+$84
// 68b54 econet
// upd7002 adc
// tube ula

// other constants

.label mode0base = $3000
.label mode1base = $3000
.label mode2base = $3000
.label mode3base = $4000
.label mode4base = $5800
.label mode5base = $5800
.label mode6base = $6000
.label mode7base = $7c00
.label romsbase = $8000

// zero page availibility
// $00 to $6f - available to machine code programs not using basic
// $70 to $8f - reserved by basic for the user

// colours in mode 1
//
// default logical colours :
//
// 0 black (0)
// 1 red (1)
// 2 yellow (3)
// 3 white (7)
//
// actual colours :
//
// 0 black
// 1 red
// 2 green
// 3 yellow
// 4 blue
// 5 magenta
// 6 cyan
// 7 white