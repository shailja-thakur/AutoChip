module top (
	input [2:0] in,
	output [1:0] out
);

	// Wire to store the result of the addition
	wire [2:0] sum;

	// Combinational logic to calculate the sum of the input bits
	assign sum = in[2:0] + 3'b0;

	// Assign the output bits to the least significant and most significant bits of the sum
	assign out[0] = sum[0];
	assign out[1] = sum[1];
endmodule
