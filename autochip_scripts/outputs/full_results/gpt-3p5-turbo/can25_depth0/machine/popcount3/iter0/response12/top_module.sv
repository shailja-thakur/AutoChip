module top (
	input [2:0] in,
	output [1:0] out
);

	// Declare internal wires
	wire [2:0] sum;
	
	// Add the three input bits together
	assign sum = in[2:0];

	// Assign the most significant bit of the sum to out[1]
	assign out[1] = sum[2];
	
	// Assign the least significant bit of the sum to out[0]
	assign out[0] = sum[0];
	
endmodule
