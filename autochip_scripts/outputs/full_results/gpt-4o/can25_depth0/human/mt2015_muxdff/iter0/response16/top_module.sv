module mux_2to1(
    input wire sel,
    input wire a,
    input wire b,
    output wire y
);
    assign y = sel ? a : b;
endmodule
module d_ff(
    input wire clk,
    input wire d,
    output reg q
);
    always @(posedge clk) begin
        q <= d;
    end
endmodule
module top_module(
    input clk,
    input L,
    input [2:0] r,
    output [2:0] q
);
    wire [2:0] mux_out;
    wire [2:0] ff_out;

    // Instantiate three 2-1 multiplexers
    mux_2to1 mux0 (
        .sel(L),
        .a(r[0]),
        .b(ff_out[2] ^ ff_out[1]),
        .y(mux_out[0])
    );

    mux_2to1 mux1 (
        .sel(L),
        .a(r[1]),
        .b(ff_out[0]),
        .y(mux_out[1])
    );

    mux_2to1 mux2 (
        .sel(L),
        .a(r[2]),
        .b(ff_out[2]),
        .y(mux_out[2])
    );

    // Instantiate three D flip-flops
    d_ff dff0 (
        .clk(clk),
        .d(mux_out[0]),
        .q(ff_out[0])
    );

    d_ff dff1 (
        .clk(clk),
        .d(mux_out[1]),
        .q(ff_out[1])
    );

    d_ff dff2 (
        .clk(clk),
        .d(mux_out[2]),
        .q(ff_out[2])
    );

    assign q = ff_out;
endmodule
