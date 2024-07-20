module top_module (
	input [2:0] in,
	output [1:0] out
);
	// Declare internal wire to hold the sum
	wire [2:0] sum;
	
	// Assign the sum of the inputs to the output bits
	assign sum = in + 3'b000;
	assign out = sum[2:1];
endmodule
