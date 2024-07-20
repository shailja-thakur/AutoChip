module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);
    // State A
    assign Y2 = (y[6] && ~y[5] && w) || (y[6] && y[5] && y[1] && ~w);
    assign Y4 = (y[6] && y[3] && ~y[2] && ~y[1] && ~y[5] && w) || (y[6] && y[3] && y[2] && y[1] && ~w);
    
endmodule
