module top_module (
	input clk,
	input in,
	output logic out
);
	
	logic q;
	
	xor2 #(2) xor_gate (
		.in1(clk),
		.in2(out),
		.out(q)
	);
	
	d_ff #(1) flip_flop (
		.clk(clk),
		.d(q),
		.q(out)
	);
	
endmodule
