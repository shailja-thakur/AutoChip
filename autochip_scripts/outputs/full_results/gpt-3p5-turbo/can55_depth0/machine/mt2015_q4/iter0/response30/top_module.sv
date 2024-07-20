module top_module(
  input wire x,
  input wire y,
  output wire z);

  // Declare internal wires
  wire a;
  wire b;

  // Instantiate gates
  and_gate u1 (.a(x), .b(y), .z(a));
  and_gate u2 (.a(y), .b(x), .z(b));
  or_gate u3 (.a(a), .b(b), .z(z));

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
