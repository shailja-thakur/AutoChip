module top_module(
   input a,
   input b,
   output out
);

   // Implement the XNOR gate using the assign statement
   assign out = !(a ^ b);

endmodule
