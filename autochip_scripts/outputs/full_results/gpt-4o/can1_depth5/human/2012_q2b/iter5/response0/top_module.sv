module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

    // The next state logic for Y1 (state B): Only active from state A when w is 1
    assign Y1 = y[0] & w;

    // The next state logic for Y3 (state D): 
    // - From state B when w is 0;
    // - From state C when w is 0;
    // - From state A when w is 0 (Added this condition which was missing)
    assign Y3 = y[1] & ~w | y[2] & ~w | y[0] & ~w;
    
endmodule
