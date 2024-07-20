module top_module (
	input clk,
	input in,
	output logic out
);
	// Create signals for D flip-flop
	logic d_ff_out;
	logic d_ff_in;
	
	// Create a two-input XOR gate
	logic xor_out;
	
	// Instantiate the D flip-flop
	d_ff d_flip_flop(
		.clk(clk),
		.d(d_ff_in),
		.q(d_ff_out)
	);
	
	// Instantiate the XOR gate
	xor2 xor_gate(
		.a(in),
		.b(d_ff_out),
		.z(xor_out)
	);
	
	// Output of the XOR gate is connected to 'out' signal
	assign out = xor_out;
	
	// Input to the D flip-flop is connected to 'in' signal
	assign d_ff_in = in;
	
endmodule
module d_ff (
	input clk,
	input d,
	output reg q
);
	always @(posedge clk) begin
		q <= d;
	end
	
endmodule
module xor2 (
	input a,
	input b,
	output z
);
	assign z = a ^ b;
	
endmodule
