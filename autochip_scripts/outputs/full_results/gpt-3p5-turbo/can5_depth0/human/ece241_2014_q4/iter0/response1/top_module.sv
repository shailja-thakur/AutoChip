module top_module (
	input clk,
	input x,
	output z
);

	// Declare internal signals
	reg flip_flop_1;
	reg flip_flop_2;
	reg flip_flop_3;

	// Input connections to gates
	wire a_xor;
	wire a_and;
	wire a_or;
	
	// Output connection to XNOR gate
	wire a_xnor;

	// D flip-flop connections
	d_ff d_ff_1 (
		.clk(clk),
		.d(x ^ flip_flop_1),
		.q(flip_flop_1)
	);

	d_ff d_ff_2 (
		.clk(clk),
		.d(~flip_flop_2),
		.q(flip_flop_2)
	);

	d_ff d_ff_3 (
		.clk(clk),
		.d(~flip_flop_3),
		.q(flip_flop_3)
	);

	// XOR gate
	xor gate_xor (
		.a(x),
		.b(flip_flop_1),
		.z(a_xor)
	);

	// AND gate
	and gate_and (
		.a(x),
		.b(~flip_flop_2),
		.z(a_and)
	);

	// OR gate
	or gate_or (
		.a(x),
		.b(~flip_flop_3),
		.z(a_or)
	);

	// XNOR gate
	xnor gate_xnor (
		.a(a_xor),
		.b(a_and),
		.c(a_or),
		.z(z)
	);

endmodule
module d_ff (
	input clk,
	input d,
	output q
);
	
	// Declare internal signals
	reg q_temp;
	
	// Positive edge-triggered flip-flop
	always @(posedge clk) begin
		q_temp <= d;
	end
	
	// Output assignment
	assign q = q_temp;
	
endmodule
module xor (
	input a,
	input b,
	output z
);
	
	// XOR gate
	assign z = a ^ b;
	
endmodule
module and (
	input a,
	input b,
	output z
);

	// AND gate
	assign z = a & b;
	
endmodule
module or (
	input a,
	input b,
	output z
);

	// OR gate
	assign z = a | b;
	
endmodule
module xnor (
	input a,
	input b,
	input c,
	output z
);
	
	// Three-input XNOR gate
	assign z = ~(a ^ b ^ c);
	
endmodule
