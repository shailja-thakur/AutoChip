module top_module (
  input [3:0] x,
  input [3:0] y,
  output [4:0] sum
);

  // Full Adder module
  module full_adder (
    input a,
    input b,
    input carry_in,
    output sum,
    output carry_out
  );
    assign sum = a ^ b ^ carry_in;
    assign carry_out = (a & b) | (carry_in & (a ^ b));
  endmodule
