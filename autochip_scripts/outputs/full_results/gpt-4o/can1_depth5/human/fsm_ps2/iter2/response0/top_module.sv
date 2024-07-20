module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg done
);
    // State declarations
    typedef enum logic [1:0] {
        IDLE,   // Idle state, waiting for in[3]=1
        BYTE1,  // We found the first byte of a message
        BYTE2,  // We found the second byte of a message
        BYTE3   // We found the third byte of a message
    } state_t;

    state_t current_state, next_state;

	// State transition logic
	always_ff @(posedge clk or posedge reset) begin
		if (reset) begin
			current_state <= IDLE;
		end
		else begin
			current_state <= next_state;
		end
	end

	// Next state and output logic
	always_comb begin
		// Default values
		done = 0;
		next_state = current_state;

		case (current_state)
			IDLE: begin
				if (in[3] == 1'b1)
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
				done = 1'b1;
			end
		endcase
	end

endmodule
