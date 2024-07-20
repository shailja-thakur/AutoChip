module flipflop (
    input clk,
    input r,
    output reg q
);

    always @(posedge clk)
        q <= r;

endmodule
module mux_2to1 (
    input a,
    input b,
    input sel,
    output reg y
);

    always @*
    begin
        if (sel)
            y = b;
        else
            y = a;
    end

endmodule
module top_module(
    input clk,
    input L,
    input r_in,
    input q_in,
    output reg Q);

    wire r1, q1, r2, q2, r3, q3;

    flipflop FF1 (
        .clk(clk),
        .r(r1),
        .q(q1)
    );

    flipflop FF2 (
        .clk(clk),
        .r(r2),
        .q(q2)
    );

    flipflop FF3 (
        .clk(clk),
        .r(r3),
        .q(q3)
    );

    mux_2to1 MUX1 (
        .a(q1),
        .b(q3),
        .sel(L),
        .y(Q)
    );

    mux_2to1 MUX2 (
        .a(q2),
        .b(Q),
        .sel(L),
        .y(q3)
    );

    mux_2to1 MUX3 (
        .a(q3),
        .b(q1),
        .sel(L),
        .y(q2)
    );

    assign r1 = r_in;
    assign r2 = r1;
    assign r3 = r2;

    assign q1 = q_in;
    assign q2 = q3;
    assign q3 = q2;

endmodule
