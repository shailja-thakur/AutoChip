module mux2to1 (
    input sel,
    input d0,
    input d1,
    output y
);
    assign y = sel ? d1 : d0;
endmodule
module d_flipflop (
    input clk,
    input d,
    output reg q
);
    always @(posedge clk) begin
        q <= d;
    end
endmodule
module sub_module(
    input clk,
    input L,
    input d1,
    input d0,
    input r,
    output q
);
    wire mux_out;
    mux2to1 mux_inst(
        .sel(L),
        .d0(d0),
        .d1(r),
        .y(mux_out)
    );
    d_flipflop dff_inst(
        .clk(clk),
        .d(mux_out),
        .q(q)
    );
endmodule
module top_module(
    input clk,
    input L,
    input [2:0] r_in,
    output [2:0] Q
);
    wire q0, q1, q2;

    sub_module sm0(
        .clk(clk),
        .L(L),
        .d1(q1 ^ q2),
        .d0(q1),
        .r(r_in[0]),
        .q(q0)
    );

    sub_module sm1(
        .clk(clk),
        .L(L),
        .d1(q0 ^ q2),
        .d0(q0),
        .r(r_in[1]),
        .q(q1)
    );

    sub_module sm2(
        .clk(clk),
        .L(L),
        .d1(q0 ^ q1),
        .d0(q0),
        .r(r_in[2]),
        .q(q2)
    );

    assign Q = {q2, q1, q0};
endmodule
