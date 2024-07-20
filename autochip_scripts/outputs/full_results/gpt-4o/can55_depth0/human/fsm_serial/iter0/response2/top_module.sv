module top_module (
	input clk,
	input in,
	input reset,
	output reg done
);

	// Define states
	typedef enum logic [2:0] {
		IDLE = 3'b000,   // IDLE state: waiting for the start bit
		START = 3'b001,  // START state: have received the start bit, now collecting data bits
		DATA = 3'b010,   // DATA state: collecting the 8 data bits
		STOP = 3'b011,   // STOP state: verifying the stop bit
		ERROR = 3'b100  // ERROR state: waiting for stop bit after an incorrect stop bit
	} state_t;
	
	state_t state, next_state;
	reg [2:0] bit_count;  // To count the number of received bits

	// State transition and output logic
	always_ff @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
			bit_count <= 3'b000;
			done <= 1'b0;
		end
		else begin
			state <= next_state;

			if (state == START) begin
				bit_count <= 3'b000; // Reset bit counter when entering START state
			end
			else if (state == DATA) begin
				bit_count <= bit_count + 1;
			end
		end
	end

	// Next state logic
	always_comb begin
		next_state = state;
		done = 1'b0;

		case (state)
			IDLE: begin
				if (in == 1'b0) begin // Detect start bit
					next_state = START;
				end
			end

			START: begin
				if (in == 1'b0) begin // Ensure the start bit is still 0
					next_state = DATA;
				end
				else begin
					next_state = IDLE; // Go back to idle if start bit is invalid
				end
			end

			DATA: begin
				if (bit_count == 3'b111) begin  // Wait for 8 bits to be received
					next_state = STOP; // Move to stop bit verification
				end
			end

			STOP: begin
				if (in == 1'b1) begin // Verify stop bit
					done = 1'b1; // If stop bit is correct, acknowledge reception
					next_state = IDLE; // Go back to idle for next byte
				end
				else begin
					next_state = ERROR; // If stop bit is incorrect, move to ERROR state
				end
			end

			ERROR: begin
				if (in == 1'b1) begin // Wait for a correct stop bit
					next_state = IDLE; // After finding stop bit, go back to idle
				end
			end
		endcase
	end

endmodule
