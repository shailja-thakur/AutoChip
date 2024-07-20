module top_module (
	input [3:0] in,
	output out_and,
	output out_or,
	output out_xor
);

	wire and_out;
	wire or_out;
	wire xor_out;

	assign out_and = and_out;
	assign out_or = or_out;
	assign out_xor = xor_out;

	// 4-input AND gate
	and_gate_4x1 and_gate (
		.in1(in[0]),
		.in2(in[1]),
		.in3(in[2]),
		.in4(in[3]),
		.out(and_out)
	);

	// 4-input OR gate
	or_gate_4x1 or_gate (
		.in1(in[0]),
		.in2(in[1]),
		.in3(in[2]),
		.in4(in[3]),
		.out(or_out)
	);

	// 4-input XOR gate
	xor_gate_4x1 xor_gate (
		.in1(in[0]),
		.in2(in[1]),
		.in3(in[2]),
		.in4(in[3]),
		.out(xor_out)
	);

endmodule
module and_gate_4x1 (
	input in1,
	input in2,
	input in3,
	input in4,
	output out
);

	wire w1;
	wire w2;

	and_gate_2x1 u1 (
		.in1(in1),
		.in2(in2),
		.out(w1)
	);

	and_gate_2x1 u2 (
		.in1(in3),
		.in2(in4),
		.out(w2)
	);

	and_gate_2x1 u3 (
		.in1(w1),
		.in2(w2),
		.out(out)
	);

endmodule
module or_gate_4x1 (
	input in1,
	input in2,
	input in3,
	input in4,
	output out
);

	wire w1;
	wire w2;

	or_gate_2x1 u1 (
		.in1(in1),
		.in2(in2),
		.out(w1)
	);

	or_gate_2x1 u2 (
		.in1(in3),
		.in2(in4),
		.out(w2)
	);

	or_gate_2x1 u3 (
		.in1(w1),
		.in2(w2),
		.out(out)
	);

endmodule
module xor_gate_4x1 (
	input in1,
	input in2,
	input in3,
	input in4,
	output out
);

	wire w1;
	wire w2;
	wire w3;

	xor_gate_2x1 u1 (
		.in1(in1),
		.in2(in2),
		.out(w1)
	);

	xor_gate_2x1 u2 (
		.in1(in3),
		.in2(in4),
		.out(w2)
	);

	xor_gate_2x1 u3 (
		.in1(w1),
		.in2(w2),
		.out(w3)
	);

	not_gate_1x1 u4 (
		.in(w3),
		.out(out)
	);

endmodule
module and_gate_2x1 (
	input in1,
	input in2,
	output out
);

	assign out = in1 & in2;

endmodule
module or_gate_2x1 (
	input in1,
	input in2,
	output out
);

	assign out = in1 | in2;

endmodule
module xor_gate_2x1 (
	input in1,
	input in2,
	output out
);

	assign out = in1 ^ in2;

endmodule
module not_gate_1x1 (
	input in,
	output out
);

	assign out = ~in;

endmodule
