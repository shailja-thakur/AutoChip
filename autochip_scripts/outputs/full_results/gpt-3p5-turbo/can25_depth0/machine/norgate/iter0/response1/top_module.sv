module top_module(
  input a, 
  input b,
  output out
);
  
  wire or_output;
  
  or_gate U1 (
    .a(a),
    .b(b),
    .out(or_output)
  );
  
  not_gate U2 (
    .in(or_output),
    .out(out)
  );
  
endmodule
module or_gate(
  input a,
  input b,
  output out
);
  
  assign out = a | b;
  
endmodule
module not_gate(
  input in,
  output out
);
  
  assign out = ~in;
  
endmodule
