module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    wire y1;
    wire [4:1] y4_temp;
    
    assign y1 = y[1] & ~w;
    assign y4_temp = {y[6], y[5], y[3], y[2]};
    assign Y2 = y1;
    assign Y4 = y4_temp & w;
    
endmodule
