module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	typedef enum logic [1:0] {
		STATE_IDLE = 2'b00,
		STATE_FIRST_ONE = 2'b01,
		STATE_COMPLEMENT = 2'b10
	} state_t;

	state_t state, next_state;
	logic first_one_detected;

	// State transition
	always_ff @(posedge clk or posedge areset) begin
		if (areset)
			state <= STATE_IDLE;
		else
			state <= next_state;
	end

	// Next state logic
	always_comb begin
		next_state = state;  // Default to maintain current state
		case (state)
			STATE_IDLE: begin
				if (first_one_detected)
					next_state = STATE_FIRST_ONE;
			end
			STATE_FIRST_ONE: begin
				next_state = STATE_COMPLEMENT;
			end
			STATE_COMPLEMENT: begin
				// Stay in this state until reset
			end
		endcase
	end

	// Output and first_one_detected logic
	always_ff @(posedge clk or posedge areset) begin
		if (areset) begin
			z <= 0;
			first_one_detected <= 0;
		end else begin
			case (state)
				STATE_IDLE: begin
					z <= x;  // Pass the input directly
					if (x == 1)
						first_one_detected <= 1;
				end
				STATE_FIRST_ONE: begin
					z <= x;  // The first '1' is passed directly
				end
				STATE_COMPLEMENT: begin
					z <= ~x;  // Complement every subsequent bit
				end
			endcase
		end
	end

endmodule
