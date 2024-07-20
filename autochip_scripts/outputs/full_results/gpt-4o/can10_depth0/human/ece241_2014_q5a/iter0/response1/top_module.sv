module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	// State Encoding
	typedef enum logic [1:0] {
		S0 = 2'd0, // Initial State
		S1 = 2'd1, // First 1 detected, inverting phase
		S2 = 2'd2  // Continue inverting phase
	} state_t;

	state_t current_state, next_state;

	// Next state logic
	always @(*) begin
		case (current_state)
			S0: next_state = (x == 1'b1) ? S1 : S0;
			S1: next_state = S2;
			S2: next_state = S2;
			default: next_state = S0;
		endcase
	end

	// Output logic
	always @(*) begin
		case (current_state)
			S0: z = x;
			S1: z = ~x;
			S2: z = ~x;
			default: z = x;
		endcase
	end

	// State register
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			current_state <= S0;
		end else begin
			current_state <= next_state;
		end
	end

endmodule
