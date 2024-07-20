module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);

    // Decode states from y input 
    wire state_A = y[1];
    wire state_B = y[2];
    wire state_C = y[3];
    wire state_D = y[4];
    wire state_E = y[5];
    wire state_F = y[6];

    // Calculate next state signals Y2, Y4
    assign Y2 = state_A & ~w | state_B & ~w; // B if state_A with ~w or B with ~w
    assign Y4 = state_B & w | state_C & w | state_D & ~w; // D if state_B with w, or state_C with w, or state_D with ~w
    
endmodule
