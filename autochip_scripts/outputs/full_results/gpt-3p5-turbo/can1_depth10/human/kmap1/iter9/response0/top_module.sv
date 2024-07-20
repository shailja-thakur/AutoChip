module top_module(
   input a, 
   input b,
   input c,
   output out
);

   // Implement the circuit described by the Karnaugh map below.
   //        a
   // bc   0 1 
   //  00 | 0 | 1 |
   //  01 | 1 | 1 | 
   //  11 | 1 | 1 | 
   //  10 | 1 | 1 | 
   
   assign out = (a & b) | (a & c) | (b & c);
   
endmodule
