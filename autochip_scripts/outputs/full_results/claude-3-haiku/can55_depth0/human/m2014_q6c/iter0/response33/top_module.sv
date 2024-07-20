module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

wire y1 = y[1]; // State A
wire y2 = y[2]; // State B
wire y3 = y[3]; // State C
wire y4 = y[4]; // State D
wire y5 = y[5]; // State E
wire y6 = y[6]; // State F

// Next-state logic for Y2 (y[2])
assign Y2 = (y1 & ~w) | (y2 & w);

// Next-state logic for Y4 (y[4])
assign Y4 = (y2 & ~w) | (y3 & ~w) | (y4 & w) | (y5 & w);

endmodule
