module top_module (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);

	assign out_and = &in;
	assign out_or = |in;
	
	// XOR gate (for 2 inputs)
	generate
		genvar i;
		for(i=0; i<100; i=i+1) begin : xor_gate
			xor_gate xor(
				.in1(in[i]),
				.in2(in[i+1]),
				.out(out_xor[i])
			);
		end
	endgenerate

endmodule
