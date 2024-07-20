module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

// Signal Y1, input of state flip-flop y[1]
assign Y1 = (y[0] & ~w) | // A (0) --0--> A
           (y[1] & w) | // B (0) --1--> C
           (y[3] & ~w); // D (0) --0--> A

// Signal Y3, input of state flip-flop y[3]
assign Y3 = (y[1] & ~w) | // B (0) --0--> D
           (y[2] & w) | // C (0) --1--> D
           (y[3] & w) | // D (0) --1--> F
           (y[4] & ~w); // E (1) --0--> D
endmodule
