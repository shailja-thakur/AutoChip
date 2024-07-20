module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

// Signal Y1 is the input to the state flip-flop y[1]
assign Y1 = (y == 6'b000010 && w) || (y == 6'b001000 && !w);

// Signal Y3 is the input to the state flip-flop y[3]
assign Y3 = (y == 6'b000100 && !w) || (y == 6'b001000 && w) || (y == 6'b100000 && !w);

endmodule
