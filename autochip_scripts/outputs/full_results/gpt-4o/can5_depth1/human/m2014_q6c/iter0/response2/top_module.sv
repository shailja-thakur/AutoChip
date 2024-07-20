module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);
    // State encoding
    parameter A = 6'b000001;
    parameter B = 6'b000010;
    parameter C = 6'b000100;
    parameter D = 6'b001000;
    parameter E = 6'b010000;
    parameter F = 6'b100000;

    // Y2 corresponds to state B
    assign Y2 = (y == A & w == 0) | (y == B & w == 0);

    // Y4 corresponds to state D
    assign Y4 = (y == B & w == 1) | (y == C & w == 1) | (y == D & w == 0) | (y == E & w == 1) | (y == F & w == 1);

endmodule
