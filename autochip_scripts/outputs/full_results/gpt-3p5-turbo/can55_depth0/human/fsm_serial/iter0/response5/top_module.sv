module top_module (
	input clk,
	input in,
	input reset,
	output done
);

// State enumeration
typedef enum logic [2:0] {
	IDLE,
	START,
	DATA,
	STOP
} state_t;

// Flip-flop for current state
reg [2:0] current_state, next_state;
// Output flip-flop for done signal
reg done_reg;

always @(posedge clk, posedge reset) begin
	if (reset) begin
		// Reset state machine
		current_state <= IDLE;
		done_reg <= 0;
	end else begin
		// Update current state based on next state
		current_state <= next_state;
		done_reg <= 0;
	end
end

always_comb begin
	// Default next state
	next_state = current_state;
	
	case(current_state)
		IDLE: begin
			// Wait for start bit
			if (in == 0) begin
				next_state = START;
			end
		end
		
		START: begin
			// Wait for 8 data bits
			if (in == 1) begin
				next_state = DATA;
			end
		end
		
		DATA: begin
			// Verify stop bit
			if (in == 0) begin
				next_state = STOP;
			end
		end
		
		STOP: begin
			// Byte received successfully, set done signal
			done_reg = 1;
			next_state = IDLE;
		end
	endcase
end

assign done = done_reg;

endmodule
