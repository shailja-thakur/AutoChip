module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	// State encoding
	typedef enum logic [1:0] {
		S0 = 2'b00, // initial state
		S1 = 2'b01, // state after detecting '1'
		S2 = 2'b10  // state after detecting '10'
	} state_t;

	state_t state, next_state;

	always_ff @(posedge clk or negedge aresetn) begin
		if (!aresetn)
			state <= S0; // reset to initial state
		else
			state <= next_state;
	end

	always_comb begin
		// default values
		next_state = state;
		z = 1'b0;

		case (state)
			S0: begin
				if (x)
					next_state = S1;
			end
			S1: begin
				if (!x)
					next_state = S2;
			end
			S2: begin
				if (x) begin
					next_state = S1; // overlap, move to S1
					z = 1'b1; // detected "101"
				end
				else
					next_state = S0;
			end
		endcase
	end

endmodule
