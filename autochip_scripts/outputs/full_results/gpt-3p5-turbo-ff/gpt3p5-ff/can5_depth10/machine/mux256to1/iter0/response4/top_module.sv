module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);
	
	// Wire to select the output bit from the input vector
	wire [7:0] sel_wire;
	assign sel_wire = in[sel];
	
	// Output bit
	assign out = sel_wire[0];
	
endmodule
