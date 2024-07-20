module top_module(
  input a,
  input b,
  output out
);

  // Logic for producing out signal
  wire or_out;   // Intermediate wire for OR gate output
  
  or_gate or1(.a(a), .b(b), .out(or_out));  // Instantiating OR gate module
  
  inverter inv1(.in(or_out), .out(out));   // Instantiating inverter module

endmodule
module or_gate(
  input a,
  input b,
  output out
);
  assign out = a | b;   // OR gate logic
endmodule
module inverter(
  input in,
  output out
);
  assign out = ~in;   // Inverter logic
endmodule
