module top_module (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);
	// Intermediate logic wires
	wire [99:0] and_result, or_result;
	wire xor_result;

	// Generate AND result for each bit in the vector
	assign and_result[0] = in[0];
	assign or_result[0] = in[0];
	assign xor_result = in[0];
	
	genvar i;
	generate
		for (i = 1; i < 100; i = i + 1) begin : gen_and_or_xor
			assign and_result[i] = and_result[i-1] & in[i];
			assign or_result[i] = or_result[i-1] | in[i];
			assign xor_result = xor_result ^ in[i];
		end
	endgenerate

	// Assign final outputs
	assign out_and = and_result[99];
	assign out_or = or_result[99];
	assign out_xor = xor_result;
endmodule
