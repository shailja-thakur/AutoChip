module top_module (
	input clk,
	input in,
	output logic out
);

logic FF_out;
logic XOR_out;

D_FF flip_flop (
	.clk(clk),
	.D(XOR_out),
	.Q(FF_out)
);

XOR2 xor_gate (
	.A(in),
	.B(FF_out),
	.Z(XOR_out)
);

assign out = FF_out;

endmodule
module D_FF (
	input clk,
	input D,
	output logic Q
);

always_ff @(posedge clk) begin
	Q <= D;
end

endmodule
module XOR2 (
	input A,
	input B,
	output logic Z
);

assign Z = A ^ B;

endmodule
