module top_module (
  input a,
  input b,
  output sum,
  output cout
);

// Creating a half adder using XOR and AND gates
assign sum = a ^ b;
assign cout = a & b;

endmodule
