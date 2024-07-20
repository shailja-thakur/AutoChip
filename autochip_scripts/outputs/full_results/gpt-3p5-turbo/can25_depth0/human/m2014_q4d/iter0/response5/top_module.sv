module top_module (
	input clk,
	input in,
	output logic out
);

logic xor_output;
logic d;

xor_gate xor1 (
	.a(in),
	.b(out),
	.y(xor_output)
);

d_ff flipflop (
	.clk(clk),
	.d(xor_output),
	.q(out)
);

endmodule
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
	output q
);

always_ff @(posedge clk) begin
	q <= d;
end

endmodule
