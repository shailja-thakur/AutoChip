module top_module(
  input x,
  input y,
  output z);

  wire a; // intermediate wire for a input of first and second gates
  wire b; // intermediate wire for b input of first and second gates
  
  // Declaration of logic gates
  and_gate and1(a, x, y);
  and_gate and2(b, y, x);
  or_gate or1(a, b, z);

endmodule
module and_gate(
  output wire out,
  input wire a,
  input wire b);

  assign out = a & b;
  
endmodule
module or_gate(
  output wire out,
  input wire a,
  input wire b);

  assign out = a | b;

endmodule
