module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

	assign out_both[0] = 0;
	assign out_any[0] = in[1];
	assign out_different[0] = (in[0] != in[99]);

	generate
		genvar i;
		for (i = 1; i <= 98; i = i + 1) begin : loop
			assign out_both[i] = (in[i] & in[i-1]);
			assign out_any[i] = (in[i] | in[i-1]);
			assign out_different[i] = (in[i] != in[i-1]);
		end
	endgenerate

	assign out_any[99] = in[98];
	assign out_different[99] = (in[99] != in[0]);

endmodule
