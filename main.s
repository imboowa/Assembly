.global _main                      // declare main global to CPU
.align 4                           // declare 16 byte increments in MEMORY

_main:                             // _main label
  bl _printf                        // branch to _printf label
  b _terminate                     // branch to _terminate label
_printf:                           // _printf label
  sub sp, sp, #16
  str X29, [sp]
  str X30, [sp, #8]
  mov X29, sp 			   // The function starts here -> sp set to start here
  mov X0, #1                       // put 1 -> (stdout) into X0
  adr X1, word                     // address of word into X1
  mov X2, #len                     // len into X2
  mov X16, #4                      // call SUPERVISOR for write -> 4
  svc 0			           // syscall kernel
  ldr X29, [sp]			   // load our old stack pointer -> function ended
  ldr X30, [sp, #8]                // load our return address -> link register
  ret 
_terminate:                        // _terminate label
  mov X16, #1                      // call SUPERVISOR for exit -> 1
  mov X0, #0
  svc 0                            // syscall kernel

word: .ascii "Hello, World!\n\0"   // label word to stor ascii for strings
                                   // asciz for auto terminate
.equ len, . - word                 // CONST len (.[current MEMORY address] - word address)
                                   // Gets word length instead of manually counting it 
