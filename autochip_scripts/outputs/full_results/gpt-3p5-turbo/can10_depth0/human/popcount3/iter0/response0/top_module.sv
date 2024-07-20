module top_module (
	input [2:0] in,
	output [1:0] out
);

	// Declare intermediate wire for each bit
	wire b0, b1, b2;
	
	// Assign intermediate wire values
	assign b0 = in[0];
	assign b1 = in[1];
	assign b2 = in[2];
	
	// Calculate population count
	assign out[0] = b0 + b1 + b2;
	assign out[1] = 0;
	
endmodule
