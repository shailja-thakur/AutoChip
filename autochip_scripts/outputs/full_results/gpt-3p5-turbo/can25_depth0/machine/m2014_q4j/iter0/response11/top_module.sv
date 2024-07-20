module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

	// Declare carry bit
	wire carry;

	// Perform addition
	assign sum[0] = x[0] ^ y[0];
	assign carry = x[0] & y[0];
	
	assign sum[1] = x[1] ^ y[1] ^ carry;
	assign carry = (x[1] & y[1]) | (x[1] & carry) | (y[1] & carry);
	
	assign sum[2] = x[2] ^ y[2] ^ carry;
	assign carry = (x[2] & y[2]) | (x[2] & carry) | (y[2] & carry);

	assign sum[3] = x[3] ^ y[3] ^ carry;
	assign carry = (x[3] & y[3]) | (x[3] & carry) | (y[3] & carry);

	assign sum[4] = carry;

endmodule
