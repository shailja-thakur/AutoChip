module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	// Define states using enum
	typedef enum logic [3:0] {S, S1, S10} state_t;
	state_t state, next_state;

	// State transition logic
	always_ff @(posedge clk or negedge aresetn) begin
		if (~aresetn) begin
			state <= S;
		end else begin
			state <= next_state;
		end
	end
	
	// Next state and output assignment based on input x and current state
	always_comb begin
		case ({x, state})
			2'b00_0: next_state = S;
			2'b01_0: next_state = S1;
			2'b00_1: next_state = S10;
			2'b01_1: next_state = S1;
			2'b10_0: next_state = S;
			2'b10_1: next_state = S1;
			2'b11_0, 2'b11_1: next_state = S10;
		endcase

		case (state)
			S: z = 1'b0;
			S1: z = 1'b0;
			S10: z = x;
			default: z = 1'b0;
		endcase
	end

endmodule
