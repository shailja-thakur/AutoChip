module mux_2to1(
    input wire sel,
    input wire d0,
    input wire d1,
    output wire y
);
    assign y = sel ? d1 : d0;
endmodule
module d_flipflop(
    input wire clk,
    input wire d,
    output reg q
);
    always @(posedge clk) begin
        q <= d;
    end
endmodule
module submodule(
    input wire clk,
    input wire L,
    input wire r_in,
    input wire q_in,
    output wire Q
);
    wire mux_out;
    mux_2to1 mux(
        .sel(L),
        .d0({q_in[1] ^ q_in[2], q_in[0], q_in[2]}),
        .d1(r_in),
        .y(mux_out)
    );
    d_flipflop flipflop(
        .clk(clk),
        .d(mux_out),
        .q(Q)
    );
endmodule
module top_module(
    input clk,
    input L,
    input [2:0] q_in,
    input [2:0] r_in,
    output [2:0] Q
);
    submodule sub0 (
        .clk(clk),
        .L(L),
        .r_in(r_in[0]),
        .q_in(q_in),
        .Q(Q[0])
    );

    submodule sub1 (
        .clk(clk),
        .L(L),
        .r_in(r_in[1]),
        .q_in(q_in),
        .Q(Q[1])
    );

    submodule sub2 (
        .clk(clk),
        .L(L),
        .r_in(r_in[2]),
        .q_in(q_in),
        .Q(Q[2])
    );
endmodule
