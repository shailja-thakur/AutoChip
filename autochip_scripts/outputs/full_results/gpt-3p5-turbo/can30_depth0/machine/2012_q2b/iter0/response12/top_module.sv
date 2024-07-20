module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);
    // Declare internal wires
    wire y1_bit;
    wire y3_bit;
    
    // Assign y1_bit to the logical AND of the first bit of y and w
    assign y1_bit = y[0] & w;
    
    // Assign y3_bit to the logical AND of the logical OR of the second, third, fifth and sixth bits of y and the logical NOT of w
    assign y3_bit = (y[1] | y[2] | y[4] | y[5]) & ~w;
    
    // Assign Y1 and Y3 outputs
    assign Y1 = y1_bit;
    assign Y3 = y3_bit;
    
endmodule
