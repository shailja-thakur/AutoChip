module top_module (
  input a,
  input b,
  input c,
  input d,
  output out_sop,
  output out_pos
);

  // Declare internal wires
  wire pos0, pos1;

  // Assign out_sop
  assign out_sop = (c & d) | ((~a & ~b & c));

  // Assign pos0
  assign pos0 = (c & (~b | d) | (~a & b));

  // Assign pos1
  assign pos1 = (c & (~a | d));

  // Assign out_pos using ternary expression
  assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
