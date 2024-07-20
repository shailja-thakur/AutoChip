module top_module (
	input clk,
	input in,
	output logic out
);

reg FF_out;
reg XOR_out;
reg Q_delayed; // Added an additional signal to handle the delay

D_FF flip_flop (
	.clk(clk),
	.D(XOR_out),
	.Q(Q_delayed)
);

XOR2 xor_gate (
	.A(in),
	.B(FF_out),
	.Z(XOR_out)
);

always @(posedge clk) begin
	FF_out <= Q_delayed; // Assign FF_out with the delayed signal
end

assign out = FF_out;

endmodule
module D_FF (
	input clk,
	input D,
	output reg Q
);

always @(posedge clk) begin
	Q <= D;
end

endmodule
module XOR2 (
	input A,
	input B,
	output reg Z
);

assign Z = A ^ B;

endmodule
