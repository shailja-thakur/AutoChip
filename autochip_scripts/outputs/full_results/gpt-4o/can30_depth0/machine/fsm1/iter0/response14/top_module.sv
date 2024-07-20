module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

	// State encoding
	typedef enum logic {A, B} state_t;
	state_t state, next_state;

	// State register
	always_ff @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= B; // Reset to state B
		end else begin
			state <= next_state;
		end
	end

	// Next state logic
	always_comb begin
		case (state)
			A: if (in) next_state = A;
			   else next_state = B;
			B: if (in) next_state = B;
			   else next_state = A;
		endcase
	end

	// Output logic
	always_ff @(state) begin
		case (state)
			A: out = 0;
			B: out = 1;
		endcase
	end

endmodule
