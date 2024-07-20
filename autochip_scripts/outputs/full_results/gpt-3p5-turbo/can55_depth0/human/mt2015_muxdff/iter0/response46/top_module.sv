module flipflop (
	input clk,
	input D,
	output reg Q
);

always @(posedge clk) begin
	Q <= D;
end

endmodule
module mux_2to1 (
    input a,
    input b,
    input sel,
    output reg y
);

always @(a or b or sel) begin
    if(sel)
        y <= b;
    else
        y <= a;
end

endmodule
module top_module(
	input clk,
	input L,
	input r_in [2:0],
	output reg Q
);

wire [2:0] q_out [2:0];

flipflop ff0 (
	.clk(clk),
	.D(r_in[0]),
	.Q(q_out[0])
);

flipflop ff1 (
	.clk(clk),
	.D(q_out[0]),
	.Q(q_out[1])
);

flop flop_inst (
	.L(L),
	.q_in(q_out[1]),
	.clk(clk),
	.r_in(r_in[2]),
	.Q(Q)
);

endmodule
module flop (
	input L,
	input r_in,
	input clk,
	output reg Q
);

mux_2to1 mux_0 (
	.a(Q),
	.b(r_in),
	.sel(L),
	.y(Q)
);

endmodule
