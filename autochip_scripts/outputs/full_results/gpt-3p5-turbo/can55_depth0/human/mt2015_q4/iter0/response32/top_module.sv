module top_module(
  input x,
  input y,
  output z);

  // Instantiate the A submodules
  A a1(x, y, output_a1);
  A a2(x, y, output_a2);

  // Instantiate the B submodules
  B b1(x, y, output_b1);
  B b2(x, y, output_b2);

  // Instantiate the OR gate
  or_gate or1(output_a1, output_b1, or_output);

  // Instantiate the AND gate
  and_gate and1(output_a2, output_b2, and_output);

  // Instantiate the XOR gate
  xor_gate xor1(or_output, and_output, z);

endmodule
module A(
  input x,
  input y,
  output z);

  // Implement the boolean function z = (x^y) & x
  wire temp;
  
  XOR_gate xor1(x, y, temp);
  AND_gate and1(temp, x, z);

endmodule
module B(
  input x,
  input y,
  output z);

  // Implement the given simulation waveform
  always @(x, y)
  begin
    case ({x, y})
      2'b00: z = 1'b1;
      2'b01: z = 1'b0;
      2'b10: z = 1'b0;
      2'b11: z = 1'b1;
    endcase
  end

endmodule
module or_gate(
  input a,
  input b,
  output z);

  assign z = a | b;

endmodule
module and_gate(
  input a,
  input b,
  output z);

  assign z = a & b;

endmodule
module xor_gate(
  input a,
  input b,
  output z);

  assign z = a ^ b;

endmodule
