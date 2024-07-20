module xor_module (
	input a,
	input b,
	output out
);
	assign out = a ^ b;
endmodule
module d_ff_module (
	input clk,
	input d,
	output reg q
);
	always @(posedge clk)
		q <= d;
endmodule
module top_module (
	input clk,
	input in,
	output logic out
);
	wire xor_out;
	xor_module xor_inst (
		.a(in),
		.b(out),
		.out(xor_out)
	);
	
	d_ff_module d_ff_inst (
		.clk(clk),
		.d(xor_out),
		.q(out)
	);
endmodule
