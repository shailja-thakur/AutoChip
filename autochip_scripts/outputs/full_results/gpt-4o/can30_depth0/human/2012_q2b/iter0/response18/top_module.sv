module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

    // State encoding
    localparam A = 6'b000001;
    localparam B = 6'b000010;
    localparam C = 6'b000100;
    localparam D = 6'b001000;
    localparam E = 6'b010000;
    localparam F = 6'b100000;

    // Output logic for Y1 (input to state flip-flop y[1])
    // Y1 corresponds to state B (000010)
    assign Y1 = (y == A && w == 1) || (y == D && w == 0);

    // Output logic for Y3 (input to state flip-flop y[3])
    // Y3 corresponds to state D (001000)
    assign Y3 = (y == B && w == 0) || (y == C && w == 0) || (y == D && w == 0) || (y == F && w == 0);

endmodule
