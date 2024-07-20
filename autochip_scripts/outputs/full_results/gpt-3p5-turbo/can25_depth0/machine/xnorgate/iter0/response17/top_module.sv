module top_module(
   input a, 
   input b,
   output reg out
);

  assign out = ~(a ^ b);

endmodule
