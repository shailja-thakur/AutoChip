module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

  wire [3:0] carry;
  
  full_adder fa0(.a(x[0]), .b(y[0]), .ci(1'b0), .sum(sum[0]), .co(carry[0]));
  full_adder fa1(.a(x[1]), .b(y[1]), .ci(carry[0]), .sum(sum[1]), .co(carry[1]));
  full_adder fa2(.a(x[2]), .b(y[2]), .ci(carry[1]), .sum(sum[2]), .co(carry[2]));
  full_adder fa3(.a(x[3]), .b(y[3]), .ci(carry[2]), .sum(sum[3]), .co(carry[3]));
  
  assign sum[4] = carry[3];
  
endmodule
