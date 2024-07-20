module flipflop_mux (
    input clk,
    input L,
    input d,
    input r,
    output reg q
);

always @(posedge clk) begin
    if (L)
        q <= r;
    else
        q <= d;
end

endmodule
module top_module(
	input clk,
	input L,
	input [2:0] r,
	output [2:0] q
);

wire [2:0] d;

assign d[0] = q[1] ^ q[2];
assign d[1] = q[0];
assign d[2] = q[2];

flipflop_mux flipflop0 (
    .clk(clk),
    .L(L),
    .d(d[0]),
    .r(r[0]),
    .q(q[0])
);

flipflop_mux flipflop1 (
    .clk(clk),
    .L(L),
    .d(d[1]),
    .r(r[1]),
    .q(q[1])
);

flipflop_mux flipflop2 (
    .clk(clk),
    .L(L),
    .d(d[2]),
    .r(r[2]),
    .q(q[2])
);

endmodule
