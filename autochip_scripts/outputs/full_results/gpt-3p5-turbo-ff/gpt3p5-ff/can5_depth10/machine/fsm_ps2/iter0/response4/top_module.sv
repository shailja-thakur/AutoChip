module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

// Define state enumeration
typedef enum logic [1:0] {
	BYTE1,
	BYTE2,
	BYTE3,
	DONE
} state_t;

// Define state register and next state
reg state_t current_state;
reg state_t next_state;

// Define done register
reg done_reg;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		// Reset state machine
		current_state <= BYTE1;
		next_state <= BYTE1;
		done_reg <= 0;
	end else begin
		// Update state machine and done signal
		current_state <= next_state;
		done_reg <= (current_state == DONE);
	end
end

always @(current_state or in) begin
	case (current_state)
		BYTE1: begin
			// Check third bit of input
			if (in[2] == 1'b1) begin
				// Transition to BYTE2
				next_state <= BYTE2;
			end else begin
				// Remain in BYTE1
				next_state <= BYTE1;
			end
		end
		
		BYTE2: begin
			// Transition to BYTE3
			next_state <= BYTE3;
		end
		
		BYTE3: begin
			// Transition to DONE
			next_state <= DONE;
		end
		
		DONE: begin
			// Check third bit of input again
			if (in[2] == 1'b1) begin
				// Transition to BYTE2
				next_state <= BYTE2;
			end else begin
				// Transition to BYTE1
				next_state <= BYTE1;
			end
		end
	endcase
end

assign done = done_reg;

endmodule
