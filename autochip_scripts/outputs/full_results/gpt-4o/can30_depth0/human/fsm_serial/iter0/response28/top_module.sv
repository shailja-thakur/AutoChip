module top_module (
	input clk,
	input in,
	input reset,
	output reg done
);

	// State encoding
	typedef enum logic [2:0] {
		IDLE         = 3'b000,
		START        = 3'b001,
		DATA_BITS    = 3'b010,
		STOP         = 3'b011
	} state_t;

	state_t current_state, next_state;
	logic [2:0] bit_count;
	logic [7:0] data_byte;

	// State transition logic
	always_ff @(posedge clk or posedge reset) begin
		if (reset) begin
			current_state <= IDLE;
			bit_count <= 3'd0;
			done <= 1'b0;
		end else begin
			current_state <= next_state;
		end
	end

	// Next state logic
	always_comb begin
		next_state = current_state;
		done = 1'b0; // Default to done being low, set high only when a valid byte is received

		case (current_state)
			IDLE: begin
				if (~in) // Detect start bit (0)
					next_state = START;
			end

			START: begin
				if (in) // Start bit must be 0, if it's 1 go back to IDLE
					next_state = IDLE;
				else
					next_state = DATA_BITS;
			end

			DATA_BITS: begin
				if (bit_count < 7) begin
					next_state = DATA_BITS;
				end else begin
					next_state = STOP;
				end
			end

			STOP: begin
				if (in) begin // Stop bit must be 1
					done = 1'b1; // Indicate a correct byte was received
					next_state = IDLE; // Prepare for the next byte
				end else begin
					next_state = IDLE; // Error in stop bit, return to IDLE
				end
			end

			default: begin
				next_state = IDLE;
			end
		endcase
	end

	// Data counter and bit reception handling
	always_ff @(posedge clk or posedge reset) begin
		if (reset) begin
			bit_count <= 3'd0;
		end else begin
			if (current_state == DATA_BITS) begin
				bit_count <= bit_count + 1;
				if (bit_count < 8) begin
					data_byte[bit_count] <= in;
				end
			end else begin
				bit_count <= 3'd0;
			end
		end
	end

endmodule
