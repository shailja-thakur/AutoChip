module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

	// State encoding
	typedef enum reg [2:0] {
		S0, // Initial state
		S1, // State after seeing 1
		S2, // State after seeing 11
		S3, // State after seeing 110
		S4  // State after seeing 1101, final state
	} state_t;
	
	state_t state, next_state;

	// State transition
	always @(posedge clk) begin
		if (reset) begin
			state <= S0;
			start_shifting <= 0;
		end else begin
			state <= next_state;
			if (next_state == S4)
				start_shifting <= 1;
		end
	end

	// Next state logic
	always @(*) begin
		case (state)
			S0: next_state = data ? S1 : S0;
			S1: next_state = data ? S2 : S0;
			S2: next_state = data ? S2 : S3;
			S3: next_state = data ? S4 : S0;
			S4: next_state = S4; // Remain in S4 indefinitely once reached
			default: next_state = S0;
		endcase
	end
endmodule
