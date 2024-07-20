module top_module (
	input in,
	input [3:0] state,
	output reg [3:0] next_state,
	output out
);

	always @(*) begin
		// Assign statements for next_state[A]
		if (in == 0)
			next_state[0] = state[0] | state[2];
		else
			next_state[0] = 0;
		
		// Assign statements for next_state[B]
        if (in == 0)
			next_state[1] = 0;
		else
			next_state[1] = state[0] | state[1] | state[3];
		
		// Assign statements for next_state[C]
		if (in == 0)
			next_state[2] = state[1] | state[3];
		else
			next_state[2] = 0;
		
		// Assign statements for next_state[D]
		if (in == 0)
			next_state[3] = 0;
		else
			next_state[3] = state[2];
		
		// Assign statement for out
		out = state[3];
	end

endmodule
