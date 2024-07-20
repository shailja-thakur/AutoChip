module xor_gate (
	input a,
	input b,
	output y
);
	assign y = a ^ b;
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
module top_module (
	input clk,
	input in,
	output logic out
);
	wire xor_out;
	xor_gate u1 (
		.a(in),
		.b(out),
		.y(xor_out)
	);
	d_ff u2 (
		.clk(clk),
		.d(xor_out),
		.q(out)
	);
endmodule
