module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

	// Define state encoding
	typedef enum logic [1:0] {
		S_A = 2'b00, // State A
		S_B = 2'b01  // State B
	} state_t;

	state_t state, next_state;

	// State transition logic
	always @(*) begin
		case (state)
			S_A: begin
				if (in)
					next_state = S_A;
				else
					next_state = S_B;
			end
			S_B: begin
				if (in)
					next_state = S_B;
				else
					next_state = S_A;
			end
			default: next_state = S_B; // Default to state B
		endcase
	end

	// State flip-flops with asynchronous reset
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= S_B;
		else
			state <= next_state;
	end

	// Output logic
	always @(*) begin
		case (state)
			S_A: out = 1'b0;
			S_B: out = 1'b1;
			default: out = 1'b1; // Default to state B's output
		endcase
	end

endmodule
