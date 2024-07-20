module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

  wire [3:0] carry;
  
  // First full adder
  full_adder fa1 (.a(x[0]), .b(y[0]), .cin(1'b0), .sum(sum[0]), .cout(carry[0]));
  
  // Second full adder
  full_adder fa2 (.a(x[1]), .b(y[1]), .cin(carry[0]), .sum(sum[1]), .cout(carry[1]));
  
  // Third full adder
  full_adder fa3 (.a(x[2]), .b(y[2]), .cin(carry[1]), .sum(sum[2]), .cout(carry[2]));
  
  // Fourth full adder
  full_adder fa4 (.a(x[3]), .b(y[3]), .cin(carry[2]), .sum(sum[3]), .cout(carry[3]));
  
  // Overflow bit
  assign sum[4] = carry[3];
  
endmodule
