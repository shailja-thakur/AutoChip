module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);
    
    // Defining next-state signals Y2 and Y4 based on state transitions
    assign Y2 = (y[1] & ~w) |     // A --0--> B
                (y[2] & ~w) |     // B --0--> C
                (y[6] & ~w);      // F --0--> C
    
    assign Y4 = (y[2] & w) |      // B --1--> D
                (y[3] & w) |      // C --1--> D
                (y[4] & ~w) |     // D --0--> F
                (y[5] & w) |      // E --1--> D
                (y[6] & w);       // F --1--> D

endmodule
