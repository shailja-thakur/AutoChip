module top_module (
  input a,
  input b,
  input sel,
  output out
);
   // Define the logic for the multiplexer
   assign out = sel ? b : a;

endmodule
