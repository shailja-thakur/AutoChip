module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

	// State Encoding
	typedef enum reg [2:0] {
		S0, // Initial state
		S1, // State after '1'
		S2, // State after '11'
		S3, // State after '110'
		S4  // State after '1101'
	} state_t;

	// State Registers
	state_t current_state, next_state;

	// State Transition Logic
	always @(posedge clk) begin
		if (reset) begin
			current_state <= S0;
			start_shifting <= 0;
		end else begin
			current_state <= next_state;
			if (current_state == S4) begin
				start_shifting <= 1;
			end
		end
	end

	// Next State Logic
	always @(*) begin
		case (current_state)
			S0: next_state = data ? S1 : S0;
			S1: next_state = data ? S2 : S0;
			S2: next_state = data ? S2 : S3;
			S3: next_state = data ? S4 : S0;
			S4: next_state = S4; // Remain in S4 once sequence is detected
			default: next_state = S0;
		endcase
	end

endmodule
