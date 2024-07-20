module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

// Derive the logic equations for Y2 and Y4

// Y2 corresponds to the next-state signal for y[2] (state B)
assign Y2 = (y[1] & ~w) // A (0) --0--> B
         | (y[4] & ~w) // C (0) --0--> B
         | (y[5] & ~w); // D (0) --0--> B

// Y4 corresponds to the next-state signal for y[4] (state C)
assign Y4 = (y[2] & ~w) // B (0) --0--> C
         | (y[6] & w); // F (1) --1--> C

endmodule
