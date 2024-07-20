module flipflop (
	input D,
	input clk,
	input reset,
	output reg Q
);

always @(posedge clk or posedge reset) begin
	if (reset)
		Q <= 0;
	else
		Q <= D;
end

endmodule
module mux21 (
	input [1:0] A,
	input sel,
	output reg Y
);

always @(A or sel) begin
	case (sel)
		0: Y <= A[0];
		1: Y <= A[1];
	endcase
end

endmodule
module top_module(
	input clk,
	input L,
	input q_in,
	input r_in,
	output reg Q);

wire [2:0] r_int;
wire [2:0] q_int;

flipflop flipflop1(
	.D(q_in),
	.clk(clk),
	.reset(1'b0),
	.Q(q_int[0])
);

flipflop flipflop2(
	.D(q_in),
	.clk(clk),
	.reset(1'b0),
	.Q(q_int[1])
);

flipflop flipflop3(
	.D(q_in),
	.clk(clk),
	.reset(1'b0),
	.Q(q_int[2])
);

mux21 mux (
	.A({q_int[1], q_int[2]}),
	.sel(L),
	.Y(Q)
);

endmodule
