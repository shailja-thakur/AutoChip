module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);
	// out_both logic
	assign out_both[0] = in[0] & in[99];
	assign out_both[98:1] = in[98:1] & in[97:0];

	// out_any logic
	assign out_any[1:99] = in[0:98] | in[99] ;

	// out_different logic
	assign out_different[0] = in[0] != in[99];
	assign out_different[98:1] = in[98:1] != in[99:0];
endmodule
