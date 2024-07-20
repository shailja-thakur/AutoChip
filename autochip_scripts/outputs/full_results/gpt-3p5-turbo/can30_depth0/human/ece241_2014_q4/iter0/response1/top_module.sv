module top_module (
	input clk,
	input x,
	output z
);
	reg d_ff1, d_ff2, d_ff3;
	wire xor_input, and_input, or_input;

	// Implementing the XOR gate
	xor_gate xor1(
		.in1(x),
		.in2(d_ff1),
		.out(xor_input)
	);

	// Implementing the AND gate
	and_gate and1(
		.in1(x),
		.in2(~d_ff2),
		.out(and_input)
	);

	// Implementing the OR gate
	or_gate or1(
		.in1(x),
		.in2(~d_ff3),
		.out(or_input)
	);

	// Implementing the D flip-flops
	d_flip_flop dff1(
		.clk(clk),
		.d(xor_input),
		.rst(1'b0),
		.q(d_ff1)
	);

	d_flip_flop dff2(
		.clk(clk),
		.d(and_input),
		.rst(1'b0),
		.q(d_ff2)
	);

	d_flip_flop dff3(
		.clk(clk),
		.d(or_input),
		.rst(1'b0),
		.q(d_ff3)
	);

	// Implementing the XNOR gate
	xnor_gate xnor1(
		.in1(d_ff1),
		.in2(d_ff2),
		.in3(d_ff3),
		.out(z)
	);

endmodule
module xor_gate (
	input in1,
	input in2,
	output out
);
	assign out = in1 ^ in2;
endmodule
module and_gate (
	input in1,
	input in2,
	output out
);
	assign out = in1 & in2;
endmodule
module or_gate (
	input in1,
	input in2,
	output out
);
	assign out = in1 | in2;
endmodule
module d_flip_flop (
	input clk,
	input d,
	input rst,
	output reg q
);
	always @(posedge clk)
	begin
		if (rst)
			q <= 1'b0;
		else
			q <= d;
	end
endmodule
module xnor_gate (
	input in1,
	input in2,
	input in3,
	output out
);
	wire wire1;
	wire wire2;

	assign wire1 = in1 ^ in2;
	assign wire2 = wire1 & in3;
	assign out = ~wire2;
endmodule
