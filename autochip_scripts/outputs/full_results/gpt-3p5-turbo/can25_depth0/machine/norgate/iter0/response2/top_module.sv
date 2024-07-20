module top_module(
    input a,
    input b,
    output out
);
  
  // Declare intermediate signals
  wire OR_out;
  
  // Instantiate OR gate
  OR_gate or1(
    .a(a),
    .b(b),
    .out(OR_out)
  );
  
  // Instantiate inverter
  inverter inv1(
    .in(OR_out),
    .out(out)
  );
  
endmodule
module OR_gate(
    input a,
    input b,
    output out
);
  
  assign out = a | b;
  
endmodule
module inverter(
    input in,
    output out
);
  
  assign out = ~in;
  
endmodule
