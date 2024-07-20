module top_module (
	input [7:0] in,
	output parity
);

	// Intermediate wires for each data bit
	wire [7:0] data_wires;
	
	// Assign input to data wires
	assign data_wires = in;
	
	// Calculate parity bit using XOR gate
	assign parity = ^data_wires;

endmodule
