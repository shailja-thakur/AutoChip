module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg done
);

	typedef enum logic [1:0] {
		IDLE = 2'b00,   // Waiting for the first byte with in[3] = 1
		BYTE1 = 2'b01,  // First byte received
		BYTE2 = 2'b10,  // Second byte received
		BYTE3 = 2'b11   // Third byte received
	} state_t;

	state_t state, next_state;

	// State Transition
	always @(posedge clk) begin
		if (reset) 
			state <= IDLE;
		else
			state <= next_state;
	end

	// Next state logic and output logic
	always @(*) begin
		next_state = state; // Default to hold state
		done = 0; // Default to no done signal
		
		case (state)
			IDLE: begin
				if (in[3] == 1)
					next_state = BYTE1;
			end
			BYTE1: begin
				next_state = BYTE2;
			end
			BYTE2: begin
				next_state = BYTE3;
			end
			BYTE3: begin
				next_state = IDLE;
				done = 1; // Signal completion of a message
			end
			default: begin
				next_state = IDLE;
			end
		endcase
	end

endmodule
