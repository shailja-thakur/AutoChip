module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);
	
	// Internal wire declarations
	wire [3:0] in;
	wire out;
	
	// Assign input bits to internal wire
	assign in = {a, b, c, d};
	
	// XOR operation on input bits
	xor_gate xor1(
		.in(in),
		.out(out)
	);
	
	// Inverting the output
	not_gate not1(
		.in(out),
		.out(q)
	);
	
	// XOR gate definition
	module xor_gate(
		input [3:0] in,
		output out
	);
		assign out = in[0] ^ in[1] ^ in[2] ^ in[3];
	endmodule
module not_gate(
		input in,
		output out
	);
		assign out = ~in;
	endmodule
