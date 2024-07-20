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
module submodule(
    input clk,
    input L,
    input d,
    input r,
    output q
);
    wire mux_out;
    
    mux2to1 mux_inst (
        .a(d),
        .b(r),
        .sel(L),
        .y(mux_out)
    );

    d_flipflop dff_inst (
        .d(mux_out),
        .clk(clk),
        .q(q)
    );
endmodule
module top_module(
    input clk,
    input L,
    input [2:0] r,
    output [2:0] q
);
    wire [2:0] inter_q;

    submodule inst0 (
        .clk(clk),
        .L(L),
        .d(q[1] ^ q[2]),
        .r(r[0]),
        .q(inter_q[0])
    );

    submodule inst1 (
        .clk(clk),
        .L(L),
        .d(q[0]),
        .r(r[1]),
        .q(inter_q[1])
    );

    submodule inst2 (
        .clk(clk),
        .L(L),
        .d(q[2]),
        .r(r[2]),
        .q(inter_q[2])
    );

    assign q = inter_q;
endmodule
