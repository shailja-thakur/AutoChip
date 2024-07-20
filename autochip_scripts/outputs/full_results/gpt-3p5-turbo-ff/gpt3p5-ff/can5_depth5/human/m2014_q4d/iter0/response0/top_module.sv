module dff (
	input clk,
	input d,
	output reg q
);
	always @(posedge clk)
		q <= d;
endmodule
module xor_gate (
	input a,
	input b,
	output xor_out
);
	assign xor_out = a ^ b;
endmodule
module top_module (
	input clk,
	input in,
	output logic out
);
	wire xor_out;
	xor_gate xor_inst (.a(in), .b(out), .xor_out(xor_out));
	dff dff_inst (.clk(clk), .d(xor_out), .q(out));
endmodule
