.global _main        // main global to CPU
.align 4             // align in MEM 8 bytes

_main:
  mov X4, #0         // make X0 == 0

loop: 
  cmp X4, #3        // cmp is X0 == 5
  bge end_loop      // 1 bge end_loop 0 none

  mov X0, #1        // make stdout fd -> 1
  adr X1, name      // prep MEM address -> name
  mov X2, #len_name // get length of MEM
  mov X16, #4       // write name
  svc 0             // syscall

  add X4, X4,#1     // increment X4 by 1

  b loop            // call loop again
  
end_loop:
  mov X16, #1       // exit 1 == success
  mov X0, #0        // return 0 -> success
  svc 0             // syscall

name:
  .ascii "ForLoop\n\0"
.equ len_name, . - name
