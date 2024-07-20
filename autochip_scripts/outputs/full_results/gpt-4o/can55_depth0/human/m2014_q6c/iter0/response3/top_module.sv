module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    // One-hot state assignments
    parameter A = 6'b000001; 
    parameter B = 6'b000010; 
    parameter C = 6'b000100; 
    parameter D = 6'b001000; 
    parameter E = 6'b010000; 
    parameter F = 6'b100000; 

    // Next-state logic for Y2 (state B)
    // B --0--> C [y[2] & ~w]
    // B --1--> D [y[2] & w]
    // State B is represented by y = 6'b000010, so y[2] is high.
    assign Y2 = (y == B) & ~w; 

    // Next-state logic for Y4 (state D)
    // D --0--> F [y[4] & ~w]
    // D --1--> A [y[4] & w]
    // State D is represented by y = 6'b001000, so y[4] is high.
    assign Y4 = ((y == B) & w) | ((y == C) & w) | ((y == D) & w);

endmodule
