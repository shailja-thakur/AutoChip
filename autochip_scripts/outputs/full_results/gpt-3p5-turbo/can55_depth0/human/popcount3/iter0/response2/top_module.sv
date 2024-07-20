module top_module (
	input [2:0] in,
	output [1:0] out
);
	// Create intermediate wire connections
	wire[2:0] intermediate;	
	
	// Implement population count logic
	assign intermediate = in[2] + in[1] + in[0];
	assign out = intermediate[1:0];
	
endmodule
