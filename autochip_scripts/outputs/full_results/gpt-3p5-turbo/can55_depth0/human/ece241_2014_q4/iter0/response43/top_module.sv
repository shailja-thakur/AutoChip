module top_module (
	input clk,
	input x,
	output z
);

	reg [2:0] flip_flops;
	wire flip_flop_out_1, flip_flop_out_2, flip_flop_out_3;

	// Flip-flop 1
	d_ff dff1 (
		.clk(clk),
		.d(x ^ flip_flop_out_1),  // XOR with flip-flop output
		.q(flip_flop_out_1)
	);

	// Flip-flop 2
	d_ff dff2 (
		.clk(clk),
		.d(~flip_flop_out_2),  // Complement of flip-flop output
		.q(flip_flop_out_2)
	);

	// Flip-flop 3
	d_ff dff3 (
		.clk(clk),
		.d(~flip_flop_out_3),  // Complement of flip-flop output
		.q(flip_flop_out_3)
	);

	// XNOR gate
	xnor xnor_gate (
		.a(flip_flop_out_1),
		.b(flip_flop_out_2),
		.c(flip_flop_out_3),
		.z(z)
	);

endmodule
module d_ff (
	input clk,
	input d,
	output q
);

	reg q;

	always @(posedge clk) begin
		q <= d;
	end

endmodule
module xnor (
	input a,
	input b,
	input c,
	output z
);

	xor x1 (
		.a(a),
		.b(b),
		.o(temp)
	);

	xor x2 (
		.a(temp),
		.b(c),
		.o(z)
	);

endmodule
module xor (
	input a,
	input b,
	output o
);

	assign o = a ^ b;

endmodule
