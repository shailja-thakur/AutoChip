module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);
    // State encoding based on one-hot code
    parameter A = 6'b000001;
    parameter B = 6'b000010;
    parameter C = 6'b000100;
    parameter D = 6'b001000;
    parameter E = 6'b010000;
    parameter F = 6'b100000;

    assign Y1 = (y == A & w == 1'b1) | (y == B & w == 1'b0);
    assign Y3 = (y == D & w == 1'b0) | (y == C & w == 1'b0) | (y == A & w == 1'b0) | (y == F & w == 1'b0) | (y == E & w == 1'b0);

endmodule
