module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    // Derive the next state logic for Y2
    // Y2 corresponds to state B
    // B (y[2]) transitions:
    // A --0--> B (w is 0 and y[1] is 1)
    
    assign Y2 = (~w & y[1]);

    // Derive the next state logic for Y4
    // Y4 corresponds to state D
    // D (y[4]) transitions:
    // B --1--> D (w is 1 and y[2] is 1)
    // C --1--> D (w is 1 and y[3] is 1)
    // E --1--> D (w is 1 and y[5] is 1)
    // F --1--> D (w is 1 and y[6] is 1)
    
    assign Y4 = (w & (y[2] | y[3] | y[5] | y[6]));

endmodule
