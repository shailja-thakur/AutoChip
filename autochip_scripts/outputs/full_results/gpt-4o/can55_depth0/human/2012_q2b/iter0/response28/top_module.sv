module top_module (
	input [5:0] y,
	input w,
	output Y1,
	output Y3
);
    // State encoding:
    // A = 6'b000001
    // B = 6'b000010
    // C = 6'b000100
    // D = 6'b001000
    // E = 6'b010000
    // F = 6'b100000

    // Deriving Y1 and Y3 based on the state diagram and one-hot encoding
    assign Y1 = (y[0] & w);           // y[0] is state A, and transition to B occurs on w=1
    assign Y3 = (y[1] & ~w) |         // y[1] is state B, and transition to D occurs on w=0
                (y[2] & ~w) |         // y[2] is state C, and transition to D occurs on w=0
                (y[5] & ~w);          // y[5] is state F, and transition to D occurs on w=0

endmodule
