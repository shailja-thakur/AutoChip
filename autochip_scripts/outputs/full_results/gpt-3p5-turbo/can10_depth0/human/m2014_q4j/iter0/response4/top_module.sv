module top_module (
  input [3:0] x,
  input [3:0] y,
  output [4:0] sum
);

  // Declare internal wires
  wire [3:0] carry;
  
  // Instantiate full adders
  full_adder FA0(.a(x[0]), .b(y[0]), .cin(0), .sum(sum[0]), .cout(carry[0]));
  full_adder FA1(.a(x[1]), .b(y[1]), .cin(carry[0]), .sum(sum[1]), .cout(carry[1]));
  full_adder FA2(.a(x[2]), .b(y[2]), .cin(carry[1]), .sum(sum[2]), .cout(carry[2]));
  full_adder FA3(.a(x[3]), .b(y[3]), .cin(carry[2]), .sum(sum[3]), .cout(carry[3]));
  
  // Assign overflow bit
  assign sum[4] = carry[3];
  
endmodule
module full_adder (
  input a,
  input b,
  input cin,
  output sum,
  output cout
);
  
  assign {cout,sum} = a + b + cin;

endmodule
