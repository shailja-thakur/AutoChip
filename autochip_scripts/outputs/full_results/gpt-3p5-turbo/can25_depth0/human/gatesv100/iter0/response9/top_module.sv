module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

	// Output for out_both
	assign out_both[0] = in[0] & in[99];

	// Output for out_any
	assign out_any[0] = in[0] | in[1];

	// Output for out_different
	assign out_different[0] = (in[99] != in[0]);

	// Loop to calculate outputs for bits 1 to 98
	genvar i;
	generate
		for (i = 1; i < 99; i=i+1) begin: CALCULATION
			assign out_both[i] = in[i] & in[i-1];
			assign out_any[i] = in[i] | in[i+1];
			assign out_different[i] = (in[i] != in[i-1]);
		end
	endgenerate

	// Output for out_any[99]
	assign out_any[99] = in[99] | in[98];

endmodule
