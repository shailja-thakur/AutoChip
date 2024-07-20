module top_module (
  input [3:0] x,
  input [3:0] y,
  output [4:0] sum
);

  // Internal wire declarations
  wire [3:0] carry;
  
  // Full Adder instances
  full_adder fa0(.a(x[0]), .b(y[0]), .carry_in(1'b0), .sum(sum[0]), .carry_out(carry[0]));
  full_adder fa1(.a(x[1]), .b(y[1]), .carry_in(carry[0]), .sum(sum[1]), .carry_out(carry[1]));
  full_adder fa2(.a(x[2]), .b(y[2]), .carry_in(carry[1]), .sum(sum[2]), .carry_out(carry[2]));
  full_adder fa3(.a(x[3]), .b(y[3]), .carry_in(carry[2]), .sum(sum[3]), .carry_out(carry[3]));
  
  // Assign the overflow bit
  assign sum[4] = carry[3];
  
endmodule
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
