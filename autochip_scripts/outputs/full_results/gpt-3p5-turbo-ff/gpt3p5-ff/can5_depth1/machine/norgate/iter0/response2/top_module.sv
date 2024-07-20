module top_module(
  input a,
  input b,
  output out
);
  // instantiate OR gate
  wire or_output;
  or_gate or1(.a(a), .b(b), .out(or_output));
  
  // instantiate inverter
  wire inv_output;
  inv_gate inv1(.a(or_output), .out(inv_output));
  
  // assign output
  assign out = inv_output;
  
  // OR gate module
  module or_gate(
    input a,
    input b,
    output out
  );
    assign out = a | b;
  endmodule
module inv_gate(
    input a,
    output out
  );
    assign out = ~a;
  endmodule
