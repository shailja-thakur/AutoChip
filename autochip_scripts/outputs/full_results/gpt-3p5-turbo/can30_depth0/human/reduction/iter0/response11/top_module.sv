module top_module (
	input [7:0] in,
	output parity
);
	
	// Define internal wire to store intermediate results
	wire [7:0] xor_result;
	
	// XOR operation to compute the parity bit
	assign xor_result = ^in;
	
	// Compute the parity bit (just the XOR of all data bits)
	assign parity = xor_result;
	
endmodule
