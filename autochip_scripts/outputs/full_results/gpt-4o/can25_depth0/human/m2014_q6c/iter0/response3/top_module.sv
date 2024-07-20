module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);

    // Define state bits for easier reference
    wire state_A = y[1];  // State A is 000001
    wire state_B = y[2];  // State B is 000010
    wire state_C = y[3];  // State C is 000100
    wire state_D = y[4];  // State D is 001000
    wire state_E = y[5];  // State E is 010000
    wire state_F = y[6];  // State F is 100000

    // Next-state logic for Y2 (State B)
    assign Y2 = (state_A && ~w) ||
                (state_C && ~w);

    // Next-state logic for Y4 (State D)
    assign Y4 = (state_B && w)  ||
                (state_C && w)  ||
                (state_D && w)  ||
                (state_E && w)  ||
                (state_F && w);

endmodule
