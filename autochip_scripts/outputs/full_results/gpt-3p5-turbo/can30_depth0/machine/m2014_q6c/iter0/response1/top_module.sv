module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);
    
    wire Y2_temp;
    wire Y4_temp;
    
    // generate Y2
    assign Y2_temp = ~(y[1] & w);
    assign Y2 = Y2_temp;
    
    // generate Y4
    assign Y4_temp = y[2] & y[3] & y[5] & y[6] & w;
    assign Y4 = Y4_temp;
    
endmodule
