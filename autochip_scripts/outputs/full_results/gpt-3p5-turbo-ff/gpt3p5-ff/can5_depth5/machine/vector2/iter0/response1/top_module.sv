module top_module (
	input [31:0] in,
	output [31:0] out
);
	// Declare internal wires for intermediate assignments
	wire [7:0] chunk1, chunk2, chunk3, chunk4;
	
	// Assign chunks of the input to intermediate wires
	assign chunk1 = in[7:0];
	assign chunk2 = in[15:8];
	assign chunk3 = in[23:16];
	assign chunk4 = in[31:24];
	
	// Assign the intermediate wires to the output
	assign out = {chunk4, chunk3, chunk2, chunk1};

endmodule
