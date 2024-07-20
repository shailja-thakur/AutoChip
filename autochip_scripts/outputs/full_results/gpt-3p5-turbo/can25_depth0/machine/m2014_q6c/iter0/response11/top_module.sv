module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    wire Y2_temp;
    wire Y4_temp;
    
    assign Y2_temp = ~w & y[1];
    assign Y4_temp = w & (y[2] & y[3] & y[5] & y[6]);
    
    assign Y2 = Y2_temp;
    assign Y4 = Y4_temp;

endmodule
