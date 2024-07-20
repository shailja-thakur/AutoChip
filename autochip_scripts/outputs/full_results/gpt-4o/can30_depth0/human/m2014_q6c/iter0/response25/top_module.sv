module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

// Internal state signals
wire y1, y2, y3, y4, y5, y6;

assign {y6, y5, y4, y3, y2, y1} = y;

// Next state equations based on the state machine description
assign Y2 = (!w & y1) | (!w & y3) | (!w & y6);
assign Y4 = (w & y3) | (w & y4) | (w & y5) | (w & y6);

endmodule
