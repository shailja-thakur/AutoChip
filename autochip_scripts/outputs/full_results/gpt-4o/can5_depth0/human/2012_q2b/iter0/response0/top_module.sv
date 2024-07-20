module top_module(
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

    // State encoding
    parameter A = 6'b000001,
              B = 6'b000010,
              C = 6'b000100,
              D = 6'b001000,
              E = 6'b010000,
              F = 6'b100000;

    // Boolean expressions for next state
    assign Y1 = (y == A && w) || (y == D && ~w);
    assign Y3 = (y == B && ~w) || (y == C && ~w) || (y == F && ~w);

endmodule
