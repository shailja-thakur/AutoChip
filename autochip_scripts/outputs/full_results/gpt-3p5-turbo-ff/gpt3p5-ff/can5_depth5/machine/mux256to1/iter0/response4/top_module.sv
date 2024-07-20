module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);
	// wire declaration for the intermediate signals
	wire [7:0] index;
	wire selected_bit;
	
	// assign the index based on the selection vector
	assign index = sel;
	
	// assign the output bit based on the index and input vector
	assign selected_bit = in[index];
	assign out = selected_bit;
	
endmodule
