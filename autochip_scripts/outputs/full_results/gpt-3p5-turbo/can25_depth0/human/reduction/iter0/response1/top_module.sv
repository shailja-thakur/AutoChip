module top_module (
	input [7:0] in,
	output parity
);

	// Define signals and variables
	reg [7:0] data;
	reg even_parity;
	
	// Assign input to data
	assign data = in;
	
	// Compute even parity using XOR gate
	assign parity = ^data;
	
endmodule
