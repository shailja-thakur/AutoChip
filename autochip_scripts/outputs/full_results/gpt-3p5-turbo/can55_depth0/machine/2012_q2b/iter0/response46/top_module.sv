module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);
    // Calculate Y1: logical AND of the first bit of y and w
    assign Y1 = y[0] & w;

    // Calculate Y3: logical OR of the second, third, fifth, and sixth bits of y 
    // and the logical NOT of w
    assign Y3 = (y[1] | y[2] | y[4] | y[5]) & ~w;
        
endmodule
