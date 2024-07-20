module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg done
);

	// State definition
	typedef enum reg [1:0] {
		IDLE,    // Waiting for in[3] = 1
		BYTE1,   // First byte received, waiting for second byte
		BYTE2,   // Second byte received, waiting for third byte
		DONE     // Third byte received, signal done
	} state_t;

	state_t state, next_state;

	always @(posedge clk) begin
		if (reset)
			state <= IDLE;
		else
			state <= next_state;
	end

	always @* begin
		// Default outputs and next state
		done = 0;
		next_state = state;
		
		case (state)
			IDLE: begin
				if (in[3])
					next_state = BYTE1;
			end
			BYTE1: begin
				next_state = BYTE2;
			end
			BYTE2: begin
				next_state = DONE;
			end
			DONE: begin
				done = 1;
				next_state = IDLE;
			end
		endcase
	end

endmodule
