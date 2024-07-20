module flipflop(
    input clk,
    input D,
    output reg Q
);

    always @(posedge clk) begin
        Q <= D;
    end

endmodule
module mux_2to1(
    input SEL,
    input D0,
    input D1,
    output reg Y
);

    always @*
    begin
        if (SEL)
            Y = D1;
        else
            Y = D0;
    end

endmodule
module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);

    wire q_intermediate;
    wire r_intermediate;

    flipflop FF1(
        .clk(clk),
        .D(q_in),
        .Q(q_intermediate)
    );

    flipflop FF2(
        .clk(clk),
        .D(q_intermediate),
        .Q(Q)
    );

    mux_2to1 M1(
        .SEL(L),
        .D0(Q),
        .D1(r_in),
        .Y(r_intermediate)
    );

    mux_2to1 M2(
        .SEL(L),
        .D0(r_intermediate),
        .D1(q_in),
        .Y(q_intermediate)
    );

endmodule
module full_module (
    input [2:0] r,
    input L,
    input clk,
    output reg [2:0] q
);

    wire q_intermediate;
    wire r_intermediate;

    top_module TM1(
        .clk(clk),
        .L(L),
        .q_in(q_intermediate),
        .r_in(r_intermediate),
        .Q(q)
    );

    top_module TM2(
        .clk(clk),
        .L(L),
        .q_in(r_intermediate),
        .r_in(r[1:0]),
        .Q(q_intermediate)
    );

    top_module TM3(
        .clk(clk),
        .L(L),
        .q_in(q),
        .r_in(r),
        .Q(r_intermediate)
    );

endmodule
