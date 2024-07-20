module top_module (
	input clk,
	input in,
	output logic out
);
	
	logic flip_flop_out;
	
	xor_gate U1 (
		.in1(in),
		.in2(flip_flop_out),
		.out(out)
	);
	
	d_flip_flop U2 (
		.clk(clk),
		.d(out),
		.q(flip_flop_out)
	);
	
endmodule
module xor_gate (
	input logic in1,
	input logic in2,
	output logic out
);
	
	assign out = in1 ^ in2;
	
endmodule
module d_flip_flop (
	input logic clk,
	input logic d,
	output logic q
);
	
	always @(posedge clk)
		q <= d;
		
endmodule
