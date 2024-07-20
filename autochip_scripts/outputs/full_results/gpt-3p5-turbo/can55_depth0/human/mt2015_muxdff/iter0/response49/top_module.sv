module flipflop(
    input clk,
    input reset,
    input d,
    output reg q
);

always @(posedge clk or posedge reset) begin
    if (reset)
        q <= 0;
    else
        q <= d;
end

endmodule
module mux_2to1(
    input sel,
    input a,
    input b,
    output reg y
);

always @(sel, a, b) begin
    if (sel)
        y <= b;
    else
        y <= a;
end

endmodule
module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);

wire [2:0] r1;
wire [2:0] r2;
wire [2:0] r3;

flipflop ff1(
    .clk(clk),
    .reset(L),
    .d(r_in),
    .q(r1[0])
);

flipflop ff2(
    .clk(clk),
    .reset(L),
    .d(q_in),
    .q(r1[1])
);

mux_2to1 mux1(
    .sel(L),
    .a(r1[0]),
    .b(r1[1]),
    .y(r1[2])
);

flipflop ff3(
    .clk(clk),
    .reset(L),
    .d(r1[2]),
    .q(r2[0])
);

flipflop ff4(
    .clk(clk),
    .reset(L),
    .d(r2[0]),
    .q(r2[1])
);

mux_2to1 mux2(
    .sel(L),
    .a(r2[0]),
    .b(r2[1]),
    .y(r2[2])
);

flipflop ff5(
    .clk(clk),
    .reset(L),
    .d(r2[2]),
    .q(r3[0])
);

flipflop ff6(
    .clk(clk),
    .reset(L),
    .d(r3[0]),
    .q(r3[1])
);

mux_2to1 mux3(
    .sel(L),
    .a(r3[0]),
    .b(r3[1]),
    .y(Q)
);

endmodule
