module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

	// Declare the states
	typedef enum logic [1:0] {
		BYTE1,
		BYTE2,
		BYTE3,
		DONE
	} state_type;

	reg state, next_state; // Registers to hold the current and next states
	
	// Declare the variables for state transitions
	reg [2:0] third_bit_prev;
	reg [2:0] third_bit;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= BYTE1; // Reset the state to BYTE1
			third_bit_prev <= 0; // Reset the previous third bit
		end else begin
			state <= next_state; // Update the state using the next_state signal
			third_bit_prev <= third_bit; // Store the previous third bit
		end
	end

	always @(state or in) begin
		case (state)
			BYTE1: begin
				if (in[2] == 1) begin
					next_state = BYTE2; // Transition to BYTE2 if third bit is 1
				end else begin
					next_state = BYTE1; // Stay in BYTE1 state if third bit is 0
				end
			end

			BYTE2: begin
				next_state = BYTE3; // Transition to BYTE3 state
			end

			BYTE3: begin
				next_state = DONE; // Transition to DONE state
			end

			DONE: begin
				if (in[2] == 1) begin
					next_state = BYTE2; // Transition to BYTE2 if third bit is 1
				end else begin
					next_state = BYTE1; // Transition to BYTE1 if third bit is 0
				end
			end
		endcase
	end

	assign done = (state == DONE); // Assert done signal when the state is DONE

endmodule
