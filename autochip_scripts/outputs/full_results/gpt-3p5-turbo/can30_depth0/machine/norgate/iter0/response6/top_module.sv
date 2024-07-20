module top_module(
  input a,
  input b,
  output out
);
  
  or_gate u_or_gate(
    .a(a),
    .b(b),
    .out(tmp)
  );
  
  not_gate u_not_gate(
    .in(tmp),
    .out(out)
  );
  
  wire tmp;
  
  // Define OR gate
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
