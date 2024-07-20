module top_module (
	input [2:0] in,
	output [1:0] out
);
	// Declare signals
	wire [2:0] sum;
	
	// Logic to calculate the sum
	assign sum = in[2:0];
	
	// Connect outputs
	assign out[1] = sum[2];
	assign out[0] = sum[1];
	
endmodule
