module top_module (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);
	
	wire [99:0] and_wire;
	wire [99:0] or_wire;
	wire [99:0] xor_wire;

	and_gate #(100) and_inst (
		.in(in),
		.out(and_wire)
	);

	or_gate #(100) or_inst (
		.in(in),
		.out(or_wire)
	);

	xor_gate #(100) xor_inst (
		.in(in),
		.out(xor_wire)
	);

	assign out_and = and_wire[99];
	assign out_or = or_wire[99];
	assign out_xor = xor_wire[99];

endmodule
module and_gate #(parameter N) (
	input [N-1:0] in,
	output out
);

	genvar i;

	assign out = 1'b1;

	generate
		for (i = 0; i < N; i = i + 1) begin : AND_GEN
			assign out = out & in[i];
		end
	endgenerate

endmodule
module or_gate #(parameter N) (
	input [N-1:0] in,
	output out
);

	genvar i;

	assign out = 1'b0;

	generate
		for (i = 0; i < N; i = i + 1) begin : OR_GEN
			assign out = out | in[i];
		end
	endgenerate

endmodule
module xor_gate #(parameter N) (
	input [N-1:0] in,
	output out
);

	genvar i;

	assign out = in[0];

	generate
		for (i = 1; i < N; i = i + 1) begin : XOR_GEN
			assign out = out ^ in[i];
		end
	endgenerate

endmodule
