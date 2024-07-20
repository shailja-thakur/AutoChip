module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

	// State encoding
	typedef enum logic [2:0] {
		S0, // Initial state
		S1, // Found '1'
		S2, // Found '11'
		S3, // Found '110'
		S4  // Found '1101'
	} state_t;

	state_t state, next_state;

	// Sequential logic for state transition
	always_ff @(posedge clk) begin
		if (reset)
			state <= S0;
		else
			state <= next_state;
	end

	// Combinational logic for next state and output
	always_comb begin
		next_state = state; // Default next state
		start_shifting = 0; // Default output
		case (state)
			S0: begin
				if (data)
					next_state = S1;
			end
			S1: begin
				if (data)
					next_state = S2;
				else
					next_state = S0;
			end
			S2: begin
				if (data)
					next_state = S2; // Remain in S2
				else
					next_state = S3;
			end
			S3: begin
				if (data)
					next_state = S4;
				else
					next_state = S0;
			end
			S4: begin
				start_shifting = 1; // Sequence found, set start_shifting
			end
		endcase
	end
endmodule
