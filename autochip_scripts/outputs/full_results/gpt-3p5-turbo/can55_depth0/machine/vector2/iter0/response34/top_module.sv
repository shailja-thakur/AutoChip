module top_module (
	input [31:0] in,
	output [31:0] out
);

	// Internal wire declarations 
	wire [7:0] chunks [3:0];

	// Assigning chunks of input to output
	assign chunks[0] = in[7:0];
	assign chunks[1] = in[15:8];
	assign chunks[2] = in[23:16];
	assign chunks[3] = in[31:24];
	
	// Concatenating chunks to form output
	assign out = {chunks[3], chunks[2], chunks[1], chunks[0]};
	
endmodule
