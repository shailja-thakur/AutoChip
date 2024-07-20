module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

    // State assignments for readability
    localparam STATE_A = 6'b000001;
    localparam STATE_B = 6'b000010;
    localparam STATE_C = 6'b000100;
    localparam STATE_D = 6'b001000;
    localparam STATE_E = 6'b010000;
    localparam STATE_F = 6'b100000;

    // Logic for Y1 (the input of state flip-flop y[1], corresponding to state B)
    assign Y1 = (y == STATE_A && w == 1) || (y == STATE_D && w == 0);

    // Logic for Y3 (the input of state flip-flop y[3], corresponding to state D)
    assign Y3 = (y == STATE_B && w == 0) || (y == STATE_C && w == 0) || (y == STATE_D && w == 0) || (y == STATE_F && w == 0);

endmodule
