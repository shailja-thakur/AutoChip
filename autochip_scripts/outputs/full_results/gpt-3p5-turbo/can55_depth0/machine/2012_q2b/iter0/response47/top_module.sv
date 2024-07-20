module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

    // Y1 is true only if the first bit of 'y' is true and 'w' is true
    assign Y1 = (y[0] & w);

    // Y3 is true if at least one of the second, third, fifth, and sixth bits of 'y' is true
    // and 'w' is false
    assign Y3 = ((y[1] | y[2] | y[4] | y[5]) & ~w);

endmodule
