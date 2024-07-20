module top_module (
	input [5:0] y,
	input w,
	output reg Y1,
	output reg Y3
);

	always @(*) begin
		// Y1 is the input to state flip-flop y[1] (state B)
		// Transitions to state B:  y[0] --1--> y[1] (A to B)
		Y1 = y[0] & w;

		// Y3 is the input to state flip-flop y[3] (state D)
		// Transitions to state D:  y[1] --0--> y[3] (B to D)
		//                         y[2] --0--> y[3] (C to D)
		//                         y[5] --0--> y[3] (F to D)
		Y3 = (y[1] & ~w) | (y[2] & ~w) | (y[5] & ~w);
	end

endmodule
