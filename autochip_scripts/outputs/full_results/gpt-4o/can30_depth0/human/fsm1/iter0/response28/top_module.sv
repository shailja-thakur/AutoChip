module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

	// Define state encoding
	typedef enum reg [1:0] {STATE_B = 2'b01, STATE_A = 2'b10} state_t;
	state_t state, next_state;

	// State transition logic
	always @(*) begin
		case (state)
			STATE_B: next_state = in ? STATE_B : STATE_A;
			STATE_A: next_state = in ? STATE_A : STATE_B;
			default: next_state = STATE_B; // Default to state B for safety
		endcase
	end

	// State update logic
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= STATE_B;
		else
			state <= next_state;
	end

	// Output logic
	always @(*) begin
		case (state)
			STATE_B: out = 1;
			STATE_A: out = 0;
			default: out = 1; // Default to output corresponding to state B for safety
		endcase
	end

endmodule
