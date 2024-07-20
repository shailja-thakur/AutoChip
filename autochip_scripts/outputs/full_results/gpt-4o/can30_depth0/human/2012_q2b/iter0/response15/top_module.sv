module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

    // States encoding
    localparam A = 6'b000001,
               B = 6'b000010,
               C = 6'b000100,
               D = 6'b001000,
               E = 6'b010000,
               F = 6'b100000;

    // Y1: Input of flip-flop y[1] (State B)
    assign Y1 = (y == A && w) || (y == F && w);

    // Y3: Input of flip-flop y[3] (State D)
    assign Y3 = (y == B && !w) || (y == C && !w) || (y == D && !w) || (y == E && !w) || (y == F && !w);

endmodule
