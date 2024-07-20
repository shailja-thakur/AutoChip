module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

	// Calculate out_both: Check if both the bit and its left neighbour are 1
	genvar i;
	generate
		for (i = 0; i < 99; i = i + 1) begin : gen_both
			assign out_both[i] = in[i] & in[i+1];
		end
	endgenerate

	// Calculate out_any: Check if either the bit or its right neighbour are 1
	generate
		for (i = 1; i < 100; i = i + 1) begin : gen_any
			assign out_any[i] = in[i] | in[i-1];
		end
	endgenerate

	// Calculate out_different: Check if the bit is different from its left neighbour (wrapping around)
	assign out_different[0] = in[0] ^ in[99];
	generate
		for (i = 1; i < 100; i = i + 1) begin : gen_different
			assign out_different[i] = in[i] ^ in[i-1];
		end
	endgenerate

endmodule
