module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

    // State Encoding
    parameter A = 6'b000001;
    parameter B = 6'b000010;
    parameter C = 6'b000100;
    parameter D = 6'b001000;
    parameter E = 6'b010000;
    parameter F = 6'b100000;

    assign Y1 = (y == A & w) | (y == B & ~w); // Transitions to state B: A --1--> B and B --0--> D (D[0])
    assign Y3 = (y == B & ~w) | (y == C & ~w) | (y == D & ~w) | (y == E & ~w) | (y == F & ~w); // Transitions to state D: B --0--> D, C --0--> D, D --0--> A, E --0--> D, F --0--> D

endmodule
