module mux2to1(
    input a,
    input b,
    input sel,
    output y
);
    assign y = sel ? b : a;
endmodule
module d_flipflop(
    input d,
    input clk,
    output reg q
);
    always @(posedge clk) begin
        q <= d;
    end
endmodule
module flipflop_mux(
    input clk,
    input L,
    input d,
    input q_out,
    output reg Q
);
    wire mux_out;

    mux2to1 u1 (
        .a(q_out),
        .b(d),
        .sel(L),
        .y(mux_out)
    );

    always @(posedge clk) begin
        Q <= mux_out;
    end
endmodule
module top_module(
    input clk,
    input L,
    input [2:0] r,
    output [2:0] q
);
    wire [2:0] q_internal;

    flipflop_mux ffm0 (
        .clk(clk),
        .L(L),
        .d(r[0]),
        .q_out({q_internal[1] ^ q_internal[2], q_internal[0], q_internal[2]}[0]),
        .Q(q_internal[0])
    );

    flipflop_mux ffm1 (
        .clk(clk),
        .L(L),
        .d(r[1]),
        .q_out({q_internal[1] ^ q_internal[2], q_internal[0], q_internal[2]}[1]),
        .Q(q_internal[1])
    );

    flipflop_mux ffm2 (
        .clk(clk),
        .L(L),
        .d(r[2]),
        .q_out({q_internal[1] ^ q_internal[2], q_internal[0], q_internal[2]}[2]),
        .Q(q_internal[2])
    );

    assign q = q_internal;
endmodule
