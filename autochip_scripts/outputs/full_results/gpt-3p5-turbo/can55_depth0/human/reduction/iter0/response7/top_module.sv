module top_module (
	input [7:0] in,
	output parity
);
	// Parity Calculation
	wire [7:0] xor_result;
	assign xor_result = in ^ 8'b11111111;
	
	// Parity bit calculation
	assign parity = xor_result ^ in;
endmodule
