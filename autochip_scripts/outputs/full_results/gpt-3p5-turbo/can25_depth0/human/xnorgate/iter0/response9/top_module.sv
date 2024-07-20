module top_module(
 input a,
 input b,
 output out
);

 // Implementation of XNOR gate
 assign out = ~(a ^ b);

endmodule
