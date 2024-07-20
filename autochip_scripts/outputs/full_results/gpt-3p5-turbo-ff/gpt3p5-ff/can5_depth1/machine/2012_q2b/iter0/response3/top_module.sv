module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

    wire Y1_wire;
    wire Y3_wire;

    // Y1 is the logical AND of the first bit of y and the input w
    assign Y1_wire = y[0] & w;

    // Y3 is the logical AND of the logical OR of the second, third, fifth, and sixth bits of y
    // and the logical NOT of the input w
    assign Y3_wire = (y[1] | y[2] | y[4] | y[5]) & ~w;

    assign Y1 = Y1_wire;
    assign Y3 = Y3_wire;

endmodule
