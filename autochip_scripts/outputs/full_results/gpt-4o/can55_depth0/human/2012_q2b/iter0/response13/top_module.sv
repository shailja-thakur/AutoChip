module top_module (
	input [5:0] y,
	input w,
	output Y1,
	output Y3
);

    // Assign Y1 = 1 if the next state should be B (y1) based on current state and input w.
    assign Y1 = (y[0] & w)       // A to B on w=1
              | (y[2] & ~w)      // C to B on w=0
              | (y[5] &  w);     // F to B on w=1

    // Assign Y3 = 1 if the next state should be D (y3) based on current state and input w.
    assign Y3 = (y[1] & ~w)      // B to D on w=0
              | (y[2] & ~w)      // C to D on w=0
              | (y[3] & ~w)      // D to D on w=0
              | (y[4] & ~w)      // E to D on w=0
              | (y[5] & ~w);     // F to D on w=0

endmodule
