module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    // State Encoding
    parameter A = 6'b000001;
    parameter B = 6'b000010;
    parameter C = 6'b000100;
    parameter D = 6'b001000;
    parameter E = 6'b010000;
    parameter F = 6'b100000;

    assign Y2 = (y == A && w == 0) || (y == C && w == 0) || (y == F && w == 0);
    assign Y4 = (y == B && w == 1) || (y == C && w == 1) || (y == F && w == 1);

endmodule
