module top_module (
	input in,
	input [3:0] state,
	output reg [3:0] next_state,
	output out
);

	always @(state or in) begin
		if (in == 0)
			next_state[0] = state[0] | state[2];
		else
			next_state[0] = 0;
			
		if (in == 1)
			next_state[1] = state[0] | state[1] | state[3];
		else
			next_state[1] = 0;
			
		if (in == 0)
			next_state[2] = state[1] | state[3];
		else
			next_state[2] = 0;
		
		if (in == 1)
			next_state[3] = state[2];
		else
			next_state[3] = 0;
		
		out = state[3];
	end

endmodule
