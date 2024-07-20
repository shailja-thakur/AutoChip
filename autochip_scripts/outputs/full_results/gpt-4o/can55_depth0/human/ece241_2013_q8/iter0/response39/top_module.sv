module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	// State encoding
	typedef enum logic [1:0] {
		IDLE = 2'b00,
		S1   = 2'b01,
		S10  = 2'b10
	} state_t;

	state_t state, next_state;

	// Mealy FSM
	always_ff @(posedge clk or negedge aresetn) begin
		if (!aresetn)
			state <= IDLE;
		else
			state <= next_state;
	end

	// Next state logic
	always_comb begin
		next_state = state; // Default to hold state
		z = 1'b0;           // Default output

		case (state)
			IDLE: begin
				if (x)
					next_state = S1;
			end

			S1: begin
				if (!x)
					next_state = S10;
				else
					next_state = S1;
			end

			S10: begin
				if (x) begin
					next_state = S1;
					z = 1'b1; // Sequence "101" is recognized
				end else
					next_state = IDLE;
			end
		endcase
	end
endmodule
