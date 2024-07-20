module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);
    // State encoding
    parameter A = 6'b000001,
              B = 6'b000010,
              C = 6'b000100,
              D = 6'b001000,
              E = 6'b010000,
              F = 6'b100000;

    // Next state logic for Y2 and Y4
    assign Y2 = (y == A && w == 0) || (y == B && w == 0) || (y == E && w == 1);
    assign Y4 = (y == B && w == 1) || (y == C && w == 1) || (y == D && w == 0) || (y == F && w == 1);

endmodule
