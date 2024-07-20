module top_module (
	input clk,
	input in,
	input reset,
	output reg done
);

	// State encoding
	typedef enum logic [2:0] {
		IDLE = 3'b000,
		START = 3'b001,
		DATA = 3'b010,
		STOP = 3'b011,
		ERROR = 3'b100
	} state_t;
	
	state_t state, next_state;
	reg [2:0] bit_count;

	// State transition logic
	always_ff @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
			bit_count <= 3'b000;
		end else begin
			state <= next_state;
		end
	end

	// Next state logic and output logic
	always_comb begin
		next_state = state; // Default to hold state
		done = 1'b0; // Default output

		case (state)
			IDLE: begin
				if (in == 1'b0) // Detecting start bit
					next_state = START;
			end
			
			START: begin
				next_state = DATA;
				bit_count = 3'b000;
			end
			
			DATA: begin
				if (bit_count == 3'b111) begin // After receiving 8 data bits
					next_state = STOP;
				end else begin
					bit_count = bit_count + 1;
				end
			end
			
			STOP: begin
				if (in == 1'b1) begin // Valid stop bit detected
					done = 1'b1;
					next_state = IDLE;
				end else begin
					next_state = ERROR;
				end
			end
			
			ERROR: begin
				if (in == 1'b1) // Waiting for idle state to retry
					next_state = IDLE;
			end
			
			default: next_state = IDLE;
		endcase
		if (reset) begin
			done = 1'b0;
		end
	end
endmodule
