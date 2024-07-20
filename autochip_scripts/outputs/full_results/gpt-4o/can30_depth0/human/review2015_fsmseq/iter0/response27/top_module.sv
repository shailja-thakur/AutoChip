module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

	// State declarations
	typedef enum logic [2:0] {
		S0, // Initial state
		S1, // State after seeing 1
		S2, // State after seeing 11
		S3, // State after seeing 110
		S4  // State after seeing 1101
	} state_t;

	state_t state, next_state;

	// Sequential logic for state transition
	always_ff @(posedge clk) begin
		if (reset) begin
			state <= S0;
			start_shifting <= 0;
		end
		else begin
			state <= next_state;
		end
	end

	// Combinational logic for next state and output
	always_comb begin
		case (state)
			S0: begin
				if (data)
					next_state = S1;
				else
					next_state = S0;
				start_shifting = 0;
			end
			S1: begin
				if (data)
					next_state = S2;
				else
					next_state = S0;
				start_shifting = 0;
			end
			S2: begin
				if (data)
					next_state = S2;
				else
					next_state = S3;
				start_shifting = 0;
			end
			S3: begin
				if (data)
					next_state = S4;
				else
					next_state = S0;
				start_shifting = 0;
			end
			S4: begin
				next_state = S4; // Remain in S4 after sequence is detected
				start_shifting = 1;
			end
			default: begin
				next_state = S0;
				start_shifting = 0;
			end
		endcase
	end

endmodule
