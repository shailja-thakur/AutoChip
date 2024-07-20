module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

    // Define state variables for clarity
    wire A = y[0];
    wire B = y[1];
    wire C = y[2];
    wire D = y[3];
    wire E = y[4];
    wire F = y[5];
    
    // Determine Y1 (state B)
    assign Y1 = (A & w);
    
    // Determine Y3 (state D)
    assign Y3 = (B & ~w) | (C & ~w) | (D & ~w) | (E & ~w) | (F & ~w);
    
endmodule
