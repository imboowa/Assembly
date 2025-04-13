.global _main        // main global to CPU
.align 4             // align in MEM 8 bytes

_main:
  adr X3, name       // one argument needed for get_length
  bl get_length      // call get_length
  adr X5, name       // give the arguments needed by printf
  mov X6, X0        
  bl printf          // call our sweet printf(legends in C)
  mov X4, #0         // make X0 == 0
start: 
  cmp X4, #3         // cmp is X0 == 5
  bge end_loop       // 1 bge end_loop 0 none
  adr X3, greet      
  bl get_length
  adr X5, greet
  mov X6, X0
  bl printf 
  add X4, X4, #1     // add 1 to X4(counter)
  b start            // branch to start
get_length: 
  mov X0, #0         // initialize counter to 0
  mov X1, X3         // get arguments into parameter
loop:
  ldrb W7, [X3, X0]  // load the lower byte(char) -> reset of space, zeroed out(memory friendly)
  cmp W7, #0         // check if value in W7 is null terminator(0) at some point
  add X0, X0, #1     // increment offset(index)/(counter)
  bne loop           // if not equal to counter, loop again
  ret                // else, return
printf:
  mov X0, #1         // make stdout fd -> 1
  mov X1, X5         // prep MEM address -> name
  mov X2, X6         // get length of MEM
  mov X16, #4        // write name
  svc 0              // syscall
  ret
end_loop:
  mov X16, #1        // exit 1 == success
  mov X0, #0         // return 0 -> success
  svc 0              // syscall

name:
  .ascii "for loop\n\0"
greet:
  .ascii "Hello, World!\n\0"
