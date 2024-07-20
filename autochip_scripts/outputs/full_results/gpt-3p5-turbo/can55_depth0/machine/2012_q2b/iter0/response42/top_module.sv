module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

    wire y1_bit;
    wire y3_bit;
  
    assign y1_bit = y[0] & w;
    assign y3_bit = (y[1] | y[2] | y[4] | y[5]) & (~w);

    assign Y1 = y1_bit;
    assign Y3 = y3_bit;

endmodule
