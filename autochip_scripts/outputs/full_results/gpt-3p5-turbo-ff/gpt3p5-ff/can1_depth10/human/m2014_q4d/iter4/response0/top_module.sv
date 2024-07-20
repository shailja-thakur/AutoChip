module top_module (
	input clk,
	input in,
	output logic out
);

reg FF_out;
reg XOR_out;
reg Q_prev; // Added an additional signal to store previous value of Q

D_FF flip_flop (
	.clk(clk),
	.D(XOR_out),
	.Q(Q_prev)
);

XOR2 xor_gate (
	.A(in),
	.B(Q_prev),
	.Z(XOR_out)
);

always @(posedge clk) begin
	FF_out <= XOR_out; // Assign FF_out with XOR_out
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
