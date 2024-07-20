module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

// Derive the Verilog expressions for Y1 and Y3 based on the state machine diagram and one-hot encoding

// Y1 is the input to the flip-flop for state bit 1
assign Y1 = (y[0] & w) | // A -> B
           (y[1] & ~w) | // B -> D
           (y[3] & w) | // D -> F
           (y[4] & ~w); // E -> D

// Y3 is the input to the flip-flop for state bit 3   
assign Y3 = (y[1] & w) | // B -> C
           (y[2] & ~w) | // C -> D
           (y[3] & w) | // D -> A
           (y[5] & w); // F -> C

endmodule
