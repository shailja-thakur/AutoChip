module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    // Y2 is '1' when transitioning to state B.
    // State B (y[2]) can be reached from State A (y[1], if ~w) 
    // or from State F (y[6], if ~w)
    assign Y2 = (y[1] & ~w) | (y[6] & ~w);

    // Y4 is '1' when transitioning to state D.
    // State D (y[4]) can be reached from State B (y[2], if w) 
    // or from State C (y[3], if w)
    // or from State E (y[5], if w)
    // or from State F (y[6], if w)
    assign Y4 = (y[2] & w) | (y[3] & w) | (y[5] & w) | (y[6] & w);

endmodule
