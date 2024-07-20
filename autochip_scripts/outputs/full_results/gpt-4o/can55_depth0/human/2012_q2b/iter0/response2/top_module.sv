module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

    // State assignment
    parameter A = 6'b000001;
    parameter B = 6'b000010;
    parameter C = 6'b000100;
    parameter D = 6'b001000;
    parameter E = 6'b010000;
    parameter F = 6'b100000;

    // Y1 logic
    // Y1 is true when transitioning to state B, which happens from state A with w==1
    assign Y1 = (y == A) & w;

    // Y3 logic
    // Y3 is true when transitioning to state D, which happens from state B with w==0, 
    // from state C with w==0, from state D with w==0, from state E with w==0, 
    // and from state F with w==0.
    assign Y3 = ((y == B) & ~w) | 
                ((y == C) & ~w) | 
                ((y == D) & ~w) | 
                ((y == E) & ~w) | 
                ((y == F) & ~w);

endmodule
