module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	// Define states
	typedef enum logic [1:0] {
		S_IDLE     = 2'b00,
		S_FLIP     = 2'b01,
		S_PASSTHRU = 2'b10
	} state_t;

	state_t state, next_state;
	logic flip_bit;

	// State transition
	always_ff @(posedge clk or posedge areset) begin
		if (areset)
			state <= S_IDLE;
		else
			state <= next_state;
	end

	// Next state logic and output logic
	always_comb begin
		next_state = state; // Default: stay in the same state
		flip_bit = 0;
		case (state)
			S_IDLE: begin
				if (!areset)  // Reset has been released
					next_state = S_FLIP;
			end
			S_FLIP: begin
				if (x == 1) begin
					flip_bit = 1;
					next_state = S_PASSTHRU;
				end
				else
					next_state = S_FLIP;
			end
			S_PASSTHRU: begin
				next_state = S_PASSTHRU;
			end
			default: next_state = S_IDLE;
		endcase
	end

	// Output logic
	always_ff @(posedge clk or posedge areset) begin
		if (areset)
			z <= 0;
		else begin
			case (state)
				S_IDLE: z <= 0;
				S_FLIP: z <= ~x;
				S_PASSTHRU: z <= x;
				default: z <= x;
			endcase
		end
	end
endmodule
