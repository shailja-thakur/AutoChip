module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);
    // Y1 is the logical AND of the first bit of the input vector y and the single bit input w
    wire Y1;
    assign Y1 = y[0] & w;

    // Y3 is the logical AND of the logical OR of the second, third, fifth, and sixth bits of the input vector y
    // and the logical NOT of the single bit input w
    wire Y3;
    assign Y3 = (y[1] | y[2] | y[4] | y[5]) & ~w;

    // Outputs
    assign Y1 = Y1;
    assign Y3 = Y3;
    
endmodule
