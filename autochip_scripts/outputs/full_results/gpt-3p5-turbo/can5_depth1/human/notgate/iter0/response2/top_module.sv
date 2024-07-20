module top_module(
  input in,
  output out
);
  
  not_gate not1(
    .in(in),
    .out(out)
  );
  
  // Define the not_gate module
  module not_gate(
    input in,
    output out
  );
    
    assign out = ~in;
    
  endmodule
