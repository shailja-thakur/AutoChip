module top_module (
	input clk,
	input in,
	input reset,
	output reg done
);

	// State encoding
	typedef enum logic [2:0] {
		IDLE         = 3'b000,
		START_BIT    = 3'b001,
		DATA_BITS    = 3'b010,
		STOP_BIT     = 3'b011,
		ERROR        = 3'b100
	} state_t;

	state_t current_state, next_state;
	reg [2:0] bit_counter;

	always_ff @(posedge clk or posedge reset) begin
		if (reset) begin
			current_state <= IDLE;
			bit_counter <= 0;
			done <= 0;
		end else begin
			current_state <= next_state;
			if (current_state == DATA_BITS)
				bit_counter <= bit_counter + 1;
			else
				bit_counter <= 0;

			if (current_state == STOP_BIT)
				done <= 1;
			else
				done <= 0;
		end
	end

	always_comb begin
		next_state = current_state;
		case (current_state)
			IDLE: begin
				if (in == 0)
					next_state = START_BIT;
			end
			START_BIT: begin
				next_state = DATA_BITS;
			end
			DATA_BITS: begin
				if (bit_counter == 7)
					next_state = STOP_BIT;
			end
			STOP_BIT: begin
				if (in == 1)
					next_state = IDLE;
				else
					next_state = ERROR;
			end
			ERROR: begin
				if (in == 1)
					next_state = IDLE;
			end
			default: next_state = IDLE;
		endcase
	end

endmodule
