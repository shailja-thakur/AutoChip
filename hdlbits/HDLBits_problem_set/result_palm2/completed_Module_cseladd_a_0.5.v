module top_module(
  input [31:0] a,
  input [31:0] b,
  output [31:0] sum
);

  carry_select_adder carry_select_adder (a, b, sum, cout);

endmodule