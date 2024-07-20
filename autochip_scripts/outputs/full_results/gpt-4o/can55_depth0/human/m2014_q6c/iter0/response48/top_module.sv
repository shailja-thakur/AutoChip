module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    // State definitions
    parameter A = 6'b000001;
    parameter B = 6'b000010;
    parameter C = 6'b000100;
    parameter D = 6'b001000;
    parameter E = 6'b010000;
    parameter F = 6'b100000;

    // Y2 corresponds to state C
    assign Y2 = (y == B & ~w) | (y == F & ~w);

    // Y4 corresponds to state E
    assign Y4 = (y == C & ~w) | (y == E & ~w);

endmodule
