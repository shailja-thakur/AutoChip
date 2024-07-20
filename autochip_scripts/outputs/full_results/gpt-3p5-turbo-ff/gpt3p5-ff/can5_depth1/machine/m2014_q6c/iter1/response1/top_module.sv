module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    wire [6:1] y_reversed;
    
    assign y_reversed = {y[1], y[2], y[3], y[4], y[5], y[6]};
    
    assign Y2 = y_reversed[1] & ~w;
    assign Y4 = y_reversed[6] & y_reversed[5] & y_reversed[3] & y_reversed[2] & w;

endmodule
