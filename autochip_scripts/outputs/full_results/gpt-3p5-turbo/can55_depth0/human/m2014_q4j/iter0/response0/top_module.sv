module top_module (
    input [3:0] x,
    input [3:0] y,
    output [4:0] sum
);

  wire [4:0] carry;
  wire [3:0] sum_temp;

  // Declare full adder instances
  full_adder fa0(.a(x[0]), .b(y[0]), .cin(1'b0), .sum(sum_temp[0]), .cout(carry[0]));
  full_adder fa1(.a(x[1]), .b(y[1]), .cin(carry[0]), .sum(sum_temp[1]), .cout(carry[1]));
  full_adder fa2(.a(x[2]), .b(y[2]), .cin(carry[1]), .sum(sum_temp[2]), .cout(carry[2]));
  full_adder fa3(.a(x[3]), .b(y[3]), .cin(carry[2]), .sum(sum_temp[3]), .cout(carry[3]));

  assign sum = {carry[3], sum_temp};

endmodule
module full_adder (
    input a,
    input b,
    input cin,
    output sum,
    output cout
);

  assign sum = a ^ b ^ cin;
  assign cout = (a & b) | (a & cin) | (b & cin);

endmodule
