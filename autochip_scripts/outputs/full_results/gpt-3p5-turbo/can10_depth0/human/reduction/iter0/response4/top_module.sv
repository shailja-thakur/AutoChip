module top_module (
	input [7:0] in,
	output parity
);
	
	// Create 8 input wires for the 8 data bits
	wire [7:0] dataBits;
	
	// Connect the input to the data bits
	assign dataBits = in;
	
	// Calculate the parity bit using XOR operation
	assign parity = ^dataBits;
	
endmodule
