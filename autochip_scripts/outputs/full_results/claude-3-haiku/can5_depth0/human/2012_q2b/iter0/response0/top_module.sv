module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

// Signal Y1 (input to state flip-flop y[1])
assign Y1 = (~y[0] & y[1]) | (y[1] & y[3]) | (y[1] & y[5]);

// Signal Y3 (input to state flip-flop y[3])
assign Y3 = (~y[0] & y[3]) | (y[1] & y[3]) | (y[3] & ~y[5]) | (y[5] & ~w);

endmodule
