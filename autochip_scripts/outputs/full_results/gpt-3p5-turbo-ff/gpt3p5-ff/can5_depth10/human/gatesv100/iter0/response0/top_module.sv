module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

	// Output both
	assign out_both[0] = in[0] & in[99]; // handle boundary case separately
	// for all other bits
	generate
		for (int i = 1; i < 99; i = i+1) begin : out_both_gen
			assign out_both[i] = in[i] & in[i - 1];
		end
	endgenerate
	
	// Output any
	assign out_any[99] = in[99] | in[98]; // handle boundary case separately
	// for all other bits
	generate
		for (int i = 0; i < 99; i = i+1) begin : out_any_gen
			assign out_any[i] = in[i] | in[i + 1];
		end
	endgenerate
	
	// Output different
	assign out_different[99] = in[99] != in[0]; // handle boundary case separately
	// for all other bits
	generate
		for (int i = 0; i < 99; i = i+1) begin : out_different_gen
			assign out_different[i] = in[i] != in[i + 1];
		end
	endgenerate
	
endmodule
