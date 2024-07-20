module top_module (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);
	assign out_and = in[0];
	assign out_or = in[0];
	assign out_xor = in[0];

	genvar i;
	generate
		for(i=1; i<100; i=i+1) begin : GEN
			assign out_and = out_and & in[i];
			assign out_or = out_or | in[i];
			assign out_xor = out_xor ^ in[i];
		end
	endgenerate

endmodule
