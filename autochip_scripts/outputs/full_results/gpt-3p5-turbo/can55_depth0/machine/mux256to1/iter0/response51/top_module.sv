module top_module (
	input [255:0] in,
	input [7:0] sel,
	output out
);

	// Internal wire declaration
	wire [7:0] index;
	
	// Indexing module to select the correct bit
	indexing_module im (
		.in(in),
		.sel(sel),
		.index(index)
	);
	
	// Output assignment
	assign out = in[index];

endmodule
module indexing_module (
	input [255:0] in,
	input [7:0] sel,
	output [7:0] index
);
	
	// Index calculation
	assign index = sel;
	
endmodule
