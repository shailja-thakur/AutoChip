module top_module (
	input [255:0] in,
	input [7:0] sel,
	output out
);
	// Use a continuous assignment statement to assign the output 'out'
	// as the bit in 'in' vector selected by 'sel'
	assign out = in[sel];
endmodule
