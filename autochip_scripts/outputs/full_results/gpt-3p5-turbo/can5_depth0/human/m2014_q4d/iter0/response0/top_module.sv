module top_module (
	input clk,
	input in,
	output logic out
);
	
	logic xor_output;
	logic flip_flop_output;
	
	xor_gate xor1(.a(in), .b(out), .z(xor_output));
	flip_flop dff1(.clk(clk), .d(xor_output), .q(flip_flop_output));
	
	assign out = flip_flop_output;
	
endmodule
