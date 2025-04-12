.global _main                    // make main global to compiler-linker also other files
.align 2                         // jump 4 bytes of MEMORY for every execution

_main:
  mov X0, #23                    // make 23 into 23
  adr X1, is_number              // get the address of our label
  bl get_length                  // branch but later return after function call
  bl change_main_data            
  cmp X0, #7                     // compare if value is changed to 7
  beq print                      // branch if to print equal to 7
  adr X1, not_number             // get the address of not_number
  bl get_length                  
  b print                        // branch, no return
print:
  mov X0, #1                     // load file descriptor STDOUT
  mov X1, X1                     // load the address given 
  mov X2, X3                     // load its length from get_length
  mov X16, #4                    // call write
  svc 0                          // syscall to kernel to do write
  mov X16, #1                    // exit
  svc 0                          // syscall to kernel to do exit
change_main_data:
  mov X0, #10                    // change X0 to 7
  ret                            // return to caller
get_length:
  mov X4, X1                     // load address X1(given to us) into X4
  mov X3, #0                     // init X3 to 0
loop:
  ldrb W5, [X4, X3]              // load byte into 32-bit register with X3 offset
  add X3, X3, #1                 // add 1 to X3(every iteration)
  cmp W5, #0                     // if 32-bit byte(char) is null terminator
  bne loop                       // not equal, do loop again
  ret                            // return values
  
not_number: .ascii "Not 7.\n\0"  // printed if X0 is 7
is_number: .ascii "Is 7.\n\0"    // printed if X0 not 7
