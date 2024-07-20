module flipflop (
    input clk,
    input D,
    input reset,
    output reg Q
);

always @(posedge clk, posedge reset)
begin
    if (reset)
        Q <= 1'b0;
    else
        Q <= D;
end

endmodule
module mux_2to1 (
    input a,
    input b,
    input sel,
    output reg y
);

always @(a, b, sel)
begin
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

wire mux1_out, mux2_out, mux3_out;
reg flipflop1_out, flipflop2_out, flipflop3_out;

mux_2to1 mux1(
    .a(flipflop1_out),
    .b(flipflop2_out),
    .sel(L),
    .y(mux1_out)
);

mux_2to1 mux2(
    .a(flipflop2_out),
    .b(flipflop3_out),
    .sel(L),
    .y(mux2_out)
);

mux_2to1 mux3(
    .a(flipflop3_out),
    .b(flipflop1_out),
    .sel(L),
    .y(mux3_out)
);

flipflop flipflop1(
    .clk(clk),
    .D(q_in),
    .reset(r_in),
    .Q(flipflop1_out)
);

flipflop flipflop2(
    .clk(clk),
    .D(mux1_out),
    .reset(r_in),
    .Q(flipflop2_out)
);

flipflop flipflop3(
    .clk(clk),
    .D(mux2_out),
    .reset(r_in),
    .Q(flipflop3_out)
);

assign Q = mux3_out;

endmodule
