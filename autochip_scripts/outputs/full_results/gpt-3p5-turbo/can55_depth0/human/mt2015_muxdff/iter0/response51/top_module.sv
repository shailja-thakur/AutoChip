module flipflop(
	input clk,
	input reset,
	input D,
	output Q
);

reg Q;

always @(posedge clk) begin
	if (reset)
		Q <= 0;
	else
		Q <= D;
end

endmodule
module mux_2to1(
	input a,
	input b,
	input sel,
	output out
);

assign out = (sel) ? b : a;

endmodule
module top_module(
	input clk,
	input L,
	input q_in,
	input r_in,
	output reg Q
);

wire [2:0] q_int;
wire [2:0] r_int;
wire L_int;

assign r_int = r_in;
assign q_int = q_in;

flipflop ff1 (
	.clk(clk),
	.reset(L_int),
	.D(q_int[0]),
	.Q(Q[0])
);

flipflop ff2 (
	.clk(clk),
	.reset(L_int),
	.D(q_int[1]),
	.Q(Q[1])
);

flipflop ff3 (
	.clk(clk),
	.reset(L_int),
	.D(q_int[2]),
	.Q(Q[2])
);

mux_2to1 mux (
	.a(r_int[0]),
	.b(r_int[1]),
	.sel(L_int),
	.out(q_int[0])
);

mux_2to1 mux2 (
	.a(q_int[1]),
	.b(q_int[2]),
	.sel(L_int),
	.out(q_int[1])
);

mux_2to1 mux3 (
	.a(q_int[2]),
	.b(q_int[0]),
	.sel(L_int),
	.out(q_int[2])
);

assign L_int = L;

endmodule
