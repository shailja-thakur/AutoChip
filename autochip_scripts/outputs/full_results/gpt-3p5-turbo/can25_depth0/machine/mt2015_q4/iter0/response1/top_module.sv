module top_module(
  input wire x,
  input wire y,
  output wire z);

  wire a, b;

  // defining the gates
  and_gate and1(.a(x), .b(y), .z(a));
  and_gate and2(.a(y), .b(x), .z(b));
  or_gate or1(.a(a), .b(b), .z(z));

endmodule
module and_gate(
  input wire a,
  input wire b,
  output wire z);

  assign z = a & b;

endmodule
module or_gate(
  input wire a,
  input wire b,
  output wire z);

  assign z = a | b;

endmodule
