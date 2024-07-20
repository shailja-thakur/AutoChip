module top_module(
	input x,
	input y,
	output z);

  // Instantiate module A
  wire a_out_1;
  A_module A_1(.x(x), .y(y), .z(a_out_1));

  wire a_out_2;
  A_module A_2(.x(x), .y(y), .z(a_out_2));

  // Instantiate module B
  wire b_out_1;
  B_module B_1(.x(x), .y(y), .z(b_out_1));

  wire b_out_2;
  B_module B_2(.x(x), .y(y), .z(b_out_2));

  // Instantiate gates
  wire or_out;
  or_gate or1(.x1(a_out_1), .x2(b_out_1), .z(or_out));

  wire and_out;
  and_gate and1(.x1(a_out_2), .x2(b_out_2), .z(and_out));

  // Instantiate XOR gate
  xor_gate xor1(.x1(or_out), .x2(and_out), .z(z));

endmodule
module A_module(
  input x,
  input y,
  output z);

  assign z = (x ^ y) & x;

endmodule
module B_module(
  input x,
  input y,
  output z);

  // Use a 2-input OR for a constant high output
  assign z = x | y;

endmodule
module or_gate(
  input x1,
  input x2,
  output z);

  assign z = x1 | x2;

endmodule
module and_gate(
  input x1,
  input x2,
  output z);

  assign z = x1 & x2;

endmodule
module xor_gate(
  input x1,
  input x2,
  output z);

  assign z = x1 ^ x2;

endmodule
