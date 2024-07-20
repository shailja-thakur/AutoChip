module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

    wire y1_bit1;
    wire y3_bit23;
    wire y3_bit56;

    // Logical AND of the first bit of the input vector y and the single bit input w
    assign y1_bit1 = y[0] & w;

    // Logical OR of the second, third, fifth and sixth bits of the input vector y
    assign y3_bit23 = y[1] | y[2];
    assign y3_bit56 = y[4] | y[5];
    
    // Logical AND of the logical OR of the second, third, fifth and sixth bits of the input vector y and the logical NOT of the single bit input w
    assign Y3 = (y3_bit23 | y3_bit56) & (~w);

    // Assign outputs
    assign Y1 = y1_bit1;

endmodule
