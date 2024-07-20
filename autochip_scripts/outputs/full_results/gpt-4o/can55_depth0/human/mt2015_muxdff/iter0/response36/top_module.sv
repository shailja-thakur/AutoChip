module mux2to1(
    input wire a,
    input wire b,
    input wire sel,
    output wire y
);
    assign y = sel ? b : a;
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
    input wire q1_in,
    input wire q2_in,
    output wire q_out
);
    wire mux_out, flipflop_out, xor_out;

    assign xor_out = q1_in ^ q2_in;
    mux2to1 mux_inst (
        .a(xor_out),
        .b(r_in),
        .sel(L),
        .y(mux_out)
    );
    d_flipflop dff_inst (
        .clk(clk),
        .d(mux_out),
        .q(flipflop_out)
    );

    assign q_out = flipflop_out;
endmodule
module top_module(
    input clk,
    input L,
    input [2:0] r_in,
    output [2:0] Q
);
    wire [2:0] q_temp;

    submodule sub0 (
        .clk(clk),
        .L(L),
        .r_in(r_in[0]),
        .q1_in(Q[1]),
        .q2_in(Q[2]),
        .q_out(q_temp[0])
    );

    submodule sub1 (
        .clk(clk),
        .L(L),
        .r_in(r_in[1]),
        .q1_in(Q[0]),
        .q2_in(Q[2]),
        .q_out(q_temp[1])
    );

    submodule sub2 (
        .clk(clk),
        .L(L),
        .r_in(r_in[2]),
        .q1_in(Q[0]),
        .q2_in(Q[1]),
        .q_out(q_temp[2])
    );

    assign Q = q_temp;
endmodule
