module top_module (
  input in,
  output out
);
  
  // Internal wire
  wire not_out;
  
  // NOT gate implementation
  not_gate not1 (.in(in), .out(not_out));
  
  // Output connection
  assign out = not_out;

endmodule
module not_gate (
  input in,
  output out
);
  
  // NOT gate implementation
  assign out = ~in;

endmodule
